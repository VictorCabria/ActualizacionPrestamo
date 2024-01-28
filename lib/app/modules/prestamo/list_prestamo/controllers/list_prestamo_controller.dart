import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/models/prestamo_model.dart';
import 'package:prestamo_mc/app/models/session_model.dart';
import 'package:prestamo_mc/app/services/model_services/client_service.dart';
import 'package:prestamo_mc/app/utils/references.dart';
import '../../../../models/ajustes_modal.dart';
import '../../../../models/cuotas_modal.dart';
import '../../../../models/diasnocobro_modal.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/ajustes_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/diascobro_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../utils/utils.dart';
import '../../../principal/home/controllers/home_controller.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:date_utils/date_utils.dart' as dt;

class ListPrestamoController extends GetxController {
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  RxBool cargando = true.obs;
  final homecontroller = Get.find<HomeController>();
  RxList<Prestamo> selectedItem = RxList();
  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  RxList<Prestamo> consultar = RxList<Prestamo>([]);
  TypePrestamo? tipoPrestamo;
  RxList<TypePrestamo> consultartipo = RxList<TypePrestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;
  RxList<Client> cliente = RxList<Client>([]);
  RxList<Client> clientefiltrados = RxList<Client>([]);
  late Stream<List<Client>> clientStream;
  List<Prestamo> get prestamosget => prestamos;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);

  RxList<Cuotas> cuotas = RxList<Cuotas>([]);

  Diasnocobro? diasnocobro;
  Prestamo? prestamo;
  Cobradores? cobrador;
  Ajustes? ajustes;
  RxString filtrobuscar = "".obs;

//tamaño
  /*  static const _pageSize = 20;

  final PagingController<int, Prestamo> _pagingController =
      PagingController(firstPageKey: 0); */

  final montosuma = 0.0.obs;
  final montointeres = 0.0.obs;
  final diasrefinan = 0.obs;
  final cobrarsabado = false.obs;
  final cobrardomingo = false.obs;
  final valorapagar = 0.0.obs;
  final fecharecaudo = "".obs;
  final valorcuota = 0.0.obs;
  final restantes = 0.obs;
  final pagados = 0.obs;
  RxBool isRefinan = false.obs;
  Session? session;
  @override
  void onInit() async {
    /*   await getListPrestamo(); */
    diasnocobroStream = getdiasnocobro();
    prestamosStream = getorestamos();
    clientStream = getclient();
    await getajustesinicial();
    consultartipo.value = await getListTypePrestamo();
    init();

    super.onInit();
  }

  getListTypePrestamo() async {
    return await typePrestamoService.getTypes();
  }

  getdiasnocobro() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  getorestamos() => prestamoService
      .obtenerlistprestamo()
      .orderBy("recorrido")
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  getclient() => clientService
      .obtenerlist()
      .snapshots()
      .map((event) => event.docs.map((e) => Client.fromJsonMap(e)).toList());

  init() {
    prestamosStream.listen((event) async {
      cargando.value = true;
      prestamos.value = event;
      consultar.value = event;
      searching('');
      /* await consultarcuotas(event); */
      metododecambioestado(event);
      monto();
      montoyinteres();
      filtrarlist(0, 1, 2);

      cargando.value = false;
    });
    clientStream.listen((event) async {
      cliente.value = event;
      clientefiltrados.value = event;
    });
    diasnocobroStream.listen((event) async {
      diasnocobros.value = event;
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      prestamos.value = consultar;
    }
  }

  searching(String texto) {
    RxList<Prestamo> prestamosnuevos = RxList<Prestamo>([]);
    prestamosnuevos.addAll(prestamos);

    if (texto != '') {
      cliente.value = clientefiltrados
          .where((p0) => (p0.nombre! + p0.apodo!)
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();

      prestamos.value = prestamosnuevos.where((prestamo) {
        var lista = cliente.where((p0) {
          return p0.id == prestamo.clienteId;
        });

        if (lista.isEmpty) return false;

        return true;
      }).toList();
    } else {
      prestamos.value = consultar;
    }
  }

  void listnegra() async {
    for (var i = 0; i < selectedItem.length; i++) {
      Client response = await getClientById(selectedItem[i].clienteId!);
      selectedItem[i].clientName = response.nombre;
      if (selectedItem[i].listanegra == true) {
        Get.dialog(AlertDialog(
          content: Text(
              "El prestamo ${selectedItem[i].clientName} ya hace parte de la lista negra"),
        ));
      } else {
        selectedItem[i].listanegra = true;
        prestamoService.updateprestamo(selectedItem[i]);
      }
    }
    selectedItem.clear();
  }

  monto() async {
    montosuma.value = 0;
    for (var i in prestamos) {
      montosuma.value += i.monto!.toInt();
    }
  }

/*   consultarcuotas(List<Prestamo> event) async {
    for (var i = 0; i < prestamos.length; i++) {
      var response =
          await cuotaService.getlistacuotasub(documentId: prestamos[i].id!);

      for (var i = 0; i < response.length; i++) {
        if (response[i].estado == Statuscuota.nopagado.name) {
          prestamos[i].cuotasrestantes = response.length;
        }
      }
      /*  prestamoService.updateprestamo(prestamos[i]); */
      print(restantes.value);
    }
  }

  consultarpagados(Prestamo prestamocuota) async {
    for (var i = 0; i < prestamos.length; i++) {
      var response =
          await cuotaService.getlistacuotasub(documentId: prestamos[i].id!);

      var listacuota =
          response.where((p0) => p0.idprestmo == prestamocuota.id).toList();
      if (listacuota.isNotEmpty) {
        pagados.value = response
            .where((e) => e.estado! == Statuscuota.pagado.name)
            .toList()
            .length;
        return pagados;
      }
    }
  }
 */
  montoyinteres() async {
    montointeres.value = 0;
    for (var i in prestamos) {
      montointeres.value += i.saldoPrestamo!.toInt();
    }
  }

  void doMultiSelection(Prestamo prestamo) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(prestamo)) {
        selectedItem.remove(prestamo);
      } else {
        selectedItem.add(prestamo);
      }
    } else {
      detalleprestamo(prestamo);
    }
  }

  detalleprestamo(Prestamo prestamos) {
    Get.toNamed(Routes.DETALLEPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});
  }

  editarprestamo(Prestamo prestamos) {
    Get.toNamed(Routes.EDITPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});
  }

  /*  getListPrestamo() async {
    /*   isloading.value = true;
    var response = await prestamoService.getPrestamos();
    print(response);
    if (response.isNotEmpty) {
      listPrestamo.value = response;
    }
    isloading.value = false; */
  } */

  createPrestamo() async {
    /*  montosuma.value = 0; */
    if (homecontroller.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }
    if (homecontroller.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }

    var response = await Get.toNamed(Routes.CREATE_PRESTAMO);
    if (response != null) {
      prestamo = response;

      var typeprestamoid = prestamo!.tipoPrestamoId;
      tipoPrestamo =
          await typePrestamoService.selecttypeprestamoid(typeprestamoid!);
      RxList<Cuotas> listacuota = RxList<Cuotas>([]);
      var aux = DateTime.parse(prestamo!.fecha!);
      var nim = 1;
      var nim2 = 0;
      int aux2 = 0;
      int aux3 = 0;
      double auxTotal = prestamo!.saldoPrestamo!;
      double auxCuota = prestamo!.valorCuota!;

      homecontroller.session!.updatePyG(TipoOperacion.costo, prestamo!.monto!);
      homecontroller.saldo.value = homecontroller.session!.pyg!;
      sessionService.updateSession(homecontroller.session!);

      /*   var res = diasnocobros.where((element) => element.dia == aux.toString());
      print(res); */
      final fechaactualizada = "".obs;
      for (int i = 1; i <= prestamo!.numeroDeCuota!; i++) {
        listacuota.clear();

        if (tipoPrestamo!.tipo['tipo'] == "Diario") {
          aux = aux.add(const Duration(days: 1));
          if (cobrarsabado.value != true) {
            if (aux.weekday == DateTime.saturday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (cobrardomingo.value != true) {
            if (aux.weekday == DateTime.sunday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (diasnocobros.isNotEmpty) {
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
        }

        if (tipoPrestamo!.tipo['tipo'] == "Semanal") {
          aux = aux.add(const Duration(days: 7));

          if (cobrarsabado.value != true) {
            if (aux.weekday == DateTime.saturday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (cobrardomingo.value != true) {
            if (aux.weekday == DateTime.sunday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (diasnocobros.isNotEmpty) {
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
        }
        if (tipoPrestamo!.tipo['tipo'] == "Quincenal") {
          aux = aux.add(const Duration(days: 15));

          if (cobrarsabado.value != true) {
            if (aux.weekday == DateTime.saturday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (cobrardomingo.value != true) {
            if (aux.weekday == DateTime.sunday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (diasnocobros.isNotEmpty) {
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
        }
        if (tipoPrestamo!.tipo['tipo'] == "Mensual") {
          aux = aux.add(const Duration(days: 30));

          if (cobrarsabado.value != true) {
            if (aux.weekday == DateTime.saturday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (cobrardomingo.value != true) {
            if (aux.weekday == DateTime.sunday) {
              aux = aux.add(const Duration(days: 1));
            }
          }
          if (diasnocobros.isNotEmpty) {
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
        }
        if (double.parse(auxTotal.toStringAsFixed(1)) >=
            double.parse(auxCuota.toStringAsFixed(1))) {
          aux2++;
          auxTotal = auxTotal - auxCuota;
        } else {
          aux3++;
        }
        if (aux3 > 0) {
          valorcuota.value = auxTotal;
        } else {
          valorcuota.value = auxCuota;
        }

        /* var fechaactual = aux = aux.add(const Duration(days: 1)); */
        var ncuota = nim2 += nim;

        if (prestamo != null) {
          Cuotas cuota = Cuotas(
            idrecaudo: "",
            idprestmo: prestamo!.id,
            ncuotas: ncuota,
            fechadepago: fechaactualizada.value,
            fechaderecaudo: fecharecaudo.value,
            valorcuota: valorcuota.value,
            sesionId: homecontroller.session!.id,
            valorpagado: valorapagar.value,
            estado: Statuscuota.nopagado.name,
          );
          listacuota.add(cuota);
        }
        await cuotaService.savesubcoleccioncuota(
            documentId: prestamo!.id!, cuotas: listacuota);
      }

      // += prestamo!.monto!;
      // homecontroller.session!.costos =
      //     homecontroller.session!.costos! + montosuma.value;
      /*  print(prestamo!.monto!);
      homecontroller.session!.updatePyG(TipoOperacion.costo, prestamo!.monto!);
      homecontroller.saldo.value = homecontroller.session!.pyg!;
      sessionService.updateSession(homecontroller.session!); */
    }
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  gettipoprestamoById(String id) async {
    var response = await typePrestamoService.getprestamoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  String getSelectedPrestamos() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  /*  delete2() async {
    print(selectedItem);
    for (var i = 0; i < selectedItem.length; i++) {
      if (homecontroller.session == null) {
        prestamoService.deleteprestamo(selectedItem[i]);
      }
      var response = await cuotaService.getlistacuotasubdesencente(
          documentId: selectedItem[i].id!);
      print(response);
      for (var o in response) {
        print(selectedItem[i].id!);
        prestamoService.deleteprestamosubcoleccion(
            collectionDocumentId: selectedItem[i].id!,
            subcollectionDocumentId: o.id!);
      }
      homecontroller.session!
          .updatePyG(TipoOperacion.costo, selectedItem[i].monto!, crear: false);
      sessionService.updateSession(homecontroller.session!);
      homecontroller.saldo.value = homecontroller.session!.pyg!;
      prestamoService.deleteprestamo(selectedItem[i]);
    }
    selectedItem.clear();
  }
 */
  delete() async {
    selectedItem.forEach((element) async {
      var listado = await recaudoService
          .obtenerlistrecaudo()
          .where("prestamo", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        var response = await cuotaService.getlistacuotasubdesencente(
            documentId: element.id!);
        for (var o in response) {
          prestamoService.deleteprestamosubcoleccion(
              collectionDocumentId: element.id!,
              subcollectionDocumentId: o.id!);
        }

        homecontroller.session!
            .updatePyG(TipoOperacion.costo, element.monto!, crear: false);
        sessionService.updateSession(homecontroller.session!);
        homecontroller.saldo.value = homecontroller.session!.pyg!;
        prestamoService.deleteprestamoid(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este prestamo no puede ser borrado porque tiene recaudos "),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.primary)),
                child: Text("Aceptar"),
                onPressed: () {
                  Get.back();
                }),
          ],
        ));
      }
    });

    selectedItem.clear();
  }

  Future<void> getajustesinicial() async {
    var res = await ajustesservice.getajustes();
    if (res != null) {
      ajustes = res;
      cobrarsabado.value = ajustes!.cobrarsabados!;
      cobrardomingo.value = ajustes!.cobrardomingos!;
      diasrefinan.value = ajustes!.diasrefinanciacion!;
    }
  }

  void filtrarlist(i, [i2, i3]) {
    //mete aqui los estados
    final estados = [
      StatusPrestamo.aldia.name,
      StatusPrestamo.atrasado.name,
      StatusPrestamo.vencido.name,
      StatusPrestamo.refinanciado.name,
      StatusPrestamo.renovado.name,
      StatusPrestamo.pagado.name,
      "Pendientes",
      "todos"
    ];

    String filtro1 = estados[i];
    String? filtro2;
    String? filtro3;
    if (i2 != null) {
      filtro2 = estados[i2];
    }
    if (i3 != null) {
      filtro3 = estados[i3];
    }
    if (filtro3 != null && filtro2 != null) {
      prestamos.value = consultar
          .where((element) =>
              element.estado == filtro1 ||
              element.estado == filtro2 ||
              element.estado == filtro3)
          .toList();
    } else if (filtro3 != null) {
      prestamos.value = consultar
          .where((element) =>
              element.estado == filtro1 || element.estado == filtro3)
          .toList();
    } else if (filtro2 != null) {
      prestamos.value = consultar
          .where((element) =>
              element.estado == filtro1 || element.estado == filtro2)
          .toList();
    } else if (filtro1 == "Pendientes") {
      prestamos.value = consultar
          .where((element) =>
              element.estado == "aldia" ||
              element.estado == "atrasado" ||
              element.estado == "vencido")
          .toList();
    } else if (filtro1 == "todos") {
      prestamos.value = consultar.toList();
    } else {
      prestamos.value =
          consultar.where((element) => element.estado == filtro1).toList();
    }
  }

  metododecambioestado(List<Prestamo> event) async {
    for (var i in event) {
      if (i.fechaPago == "") {
      } else {
        DateTime fechahoy = DateTime.now();
        DateTime fechaPago = DateTime.parse(i.fechaPago!);
        DateTime fechalimite = DateTime.parse(i.fechalimite!);
        int dias = fechahoy.difference(fechaPago).inDays;
        int diaslimite = fechahoy.difference(fechalimite).inDays;

        if (i.saldoPrestamo! > 0) {
          if (fechahoy.isBefore(fechalimite)) {
            if (i.renovado == true) {
              if (i.estado != StatusPrestamo.renovado.name) {
                i.estado = StatusPrestamo.renovado.name;
                prestamoService.updateprestamo(i);
              }
            } else if (dias <= 0) {
              if (i.estado == StatusPrestamo.aldia.name) {
              } else {
                i.estado = StatusPrestamo.aldia.name;
                prestamoService.updateprestamo(i);
              }
            } else if (dias > 0) {
              if (i.estado == StatusPrestamo.atrasado.name) {
              } else {
                i.estado = StatusPrestamo.atrasado.name;
                prestamoService.updateprestamo(i);
              }
            } else if (i.saldoPrestamo! <= 0) {
              i.estado = StatusPrestamo.pagado.name;
              prestamoService.updateprestamo(i);
            }
          } else {
            if (diaslimite > 5) {
              /*   print("Fecha Final$dialimite"); */
              if (i.refinanciado == true) {
                if (i.estado != StatusPrestamo.refinanciado.name) {
                  i.estado = StatusPrestamo.refinanciado.name;
                  prestamoService.updateprestamo(i);
                }
              } else {
                if (i.estado == StatusPrestamo.vencido.name) {
                } else {
                  i.estado = StatusPrestamo.vencido.name;
                  prestamoService.updateprestamo(i);
                }
              }
            }
          }
        }
      }
    }
  }

  /* agregar() async {
    for (int i = 0; i < prestamos.length; i++) {
      var response = await typePrestamoService
          .getprestamoById(prestamos[i].tipoPrestamoId!);

      var variable = getfechadevencimiento(
          DateTime.parse(prestamos[i].fecha!), response.first.meses!);

      print(response.first.meses);
      print(prestamos[i].clienteId);
      print("fecha de prstamo $variable");

      prestamos[i].fechalimite = variable.toString();

      prestamoService.updateprestamo(prestamos[i]);
    }
  } */

  getfechadevencimiento(DateTime fechainicial, int numerodemeses) {
    var init = fechainicial;
    for (int i = 1; i <= numerodemeses; i++) {
      final fechas = dt.DateUtils.daysInMonth(init);
      fechas.removeWhere((element) => element.month != init.month);
      int dias = fechas.length;

      init = init.add(Duration(days: dias));
    }

    return init;
  }
}
