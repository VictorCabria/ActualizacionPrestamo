import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/ajustes_modal.dart';
import '../../../../models/cuotas_modal.dart';
import '../../../../models/diasnocobro_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/ajustes_services.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/diascobro_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/references.dart';
import '../../../principal/home/controllers/home_controller.dart';

class DetalleprestamoController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  final homecontroller = Get.find<HomeController>();
  RxList<Cuotas> cuotas = RxList<Cuotas>([]);
  late Stream<List<Cuotas>> cuotaStream;
  Cuotas? cuotareciente;
  List<Cuotas> get cuotaget => cuotas;
  final homeControll = Get.find<HomeController>();
  RecaudoLine? recaudoreciente;
  Ajustes? ajustes;
  final loadinReciente = true.obs;
  Prestamo? prestamo;
  Prestamo? prestamoactualizado;
  Prestamo? prestamoeditado;
  Prestamo? prestamocreadouevo;
  TypePrestamo? tipoPrestamo;
  RxBool isloading = false.obs;
  final cobrarsabado = false.obs;
  final cobrardomingo = false.obs;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);
  Diasnocobro? diasnocobro;
  final fecharecaudo = "".obs;
  final valorapagar = 0.0.obs;
  late TabController tabController;
  @override
  void onInit() {
    prestamo = Get.arguments['prestamos'];
    recaudoStream = getrecaudo();
    diasnocobroStream = getdiasnocobro();
    getcuota2();
    /* cuotaStream = getcuota() */
    tabController = TabController(length: 2, vsync: this);
    init();
    getcuota2();

    super.onInit();
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  Future<void> getajustesinicial() async {
    var res = await ajustesservice.getajustes();
    if (res != null) {
      ajustes = res;
      cobrarsabado.value = ajustes!.cobrarsabados!;
      cobrardomingo.value = ajustes!.cobrardomingos!;
    }
  }

  getcuota2() async {

    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);
    if (response.isNotEmpty) {
      loadinReciente.value = true;
      cuotas.value = response;
      cuotareciente = cuotas.isNotEmpty ? cuotas.first : null;
    }
    loadinReciente.value = false;
    print(cuotas);
  }

  getdiasnocobro() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('prestamo', isEqualTo: prestamo!.id)
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  /* getcuota() => cuotaService
      .obtenerlistcuota(prestamo!.id!)
      .where('idprestmo', isEqualTo: prestamo!.id)
      .snapshots()
      .map((event) => event.docs.map((e) => Cuotas.fromJson(e)).toList()); */

  init() {
    recaudoStream.listen((event) async {
      loadinReciente.value = true;
      recaudo.value = event;
      print("Lista$event");
      recaudoreciente = recaudo.isNotEmpty ? recaudo.first : null;
      loadinReciente.value = false;
    });

    /* cuotaStream.listen((event) async {
      loadinReciente.value = true;
      cuotas.value = event;
      print("Lista$event");
      cuotareciente = cuotas.length > 0 ? cuotas.first : null;
      loadinReciente.value = false;
    }); */
  }

  getzonaById(String id) async {
    var response = await zonaService.getzonaById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  editarprestamo(Prestamo prestamos) async {
    if (homeControll.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }
    if (homeControll.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }
    var resp = await Get.toNamed(Routes.EDITPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});

    if (resp != null) {
      prestamoeditado = resp;
      isloading.value = true;
      prestamo!.saldoPrestamo = prestamoeditado!.saldoPrestamo;
      prestamo!.porcentaje = prestamoeditado!.porcentaje;
      prestamo!.valorCuota = prestamoeditado!.valorCuota;
      prestamo!.numeroDeCuota = prestamoeditado!.numeroDeCuota;
      prestamo!.monto = prestamoeditado!.monto;
      prestamo!.tipoPrestamoId = prestamoeditado!.tipoPrestamoId;
      prestamo!.cobradorId = prestamoeditado!.cobradorId;
      prestamo!.tipoPrestamoId = prestamoeditado!.tipoPrestamoId;

      refresh();
      isloading.value = false;
    }
  }

  recaudarsinautorizar(Prestamo prestamos) async {
    if (homeControll.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }

    if (homeControll.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }
    var response = await Get.toNamed(Routes.RECAUDARPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});

    if (response != null) {
      prestamoactualizado = response;
      isloading.value = true;
      prestamo!.saldoPrestamo = prestamoactualizado!.saldoPrestamo;
      refresh();
      isloading.value = false;

      print("Dato nuevo${prestamo!.saldoPrestamo}");
    }
  }

  renovar(Prestamo prestamos) async {
    if (homeControll.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }

    if (homeControll.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }
    var response = await Get.toNamed(Routes.RENOVACIONPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});

    if (response != null) {
      prestamocreadouevo = response;
      var typeprestamoid = prestamo!.tipoPrestamoId;
      tipoPrestamo =
          await typePrestamoService.selecttypeprestamoid(typeprestamoid!);
      RxList<Cuotas> listacuota = RxList<Cuotas>([]);
      var aux = DateTime.parse(prestamo!.fechaPago!);
      var nim = 1;
      var nim2 = 0;
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
            print("Dias no cobro$aux");
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            print("resultado dias no cobro $res");
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
          print(fechaactualizada.value);
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

          fechaactualizada.value = aux.toString();
        }

        /* var fechaactual = aux = aux.add(const Duration(days: 1)); */
        var ncuota = nim2 += nim;

        if (prestamo != null) {
          Cuotas cuota = Cuotas(
            idprestmo: prestamo!.id,
            ncuotas: ncuota,
            fechadepago: fechaactualizada.value,
            fechaderecaudo: fecharecaudo.value,
            valorcuota: prestamocreadouevo!.valorCuota,
            sesionId: homecontroller.session!.id,
            valorpagado: valorapagar.value,
            estado: Statuscuota.nopagado.name,
          );
          listacuota.add(cuota);
        }
        print("Cuotas $listacuota");
        await cuotaService.savesubcoleccioncuota(
            documentId: prestamo!.id!, cuotas: listacuota);
      }
    }
  }

  refinanciar(Prestamo prestamos) async {
    if (homeControll.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }

    if (homeControll.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }
    var response = await Get.toNamed(Routes.REFINANCIACIONPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamos});

    if (response != null) {
      prestamocreadouevo = response;
      var typeprestamoid = prestamo!.tipoPrestamoId;
      tipoPrestamo =
          await typePrestamoService.selecttypeprestamoid(typeprestamoid!);
      RxList<Cuotas> listacuota = RxList<Cuotas>([]);
      var aux = DateTime.now();
      var nim = 1;
      var nim2 = 0;
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
            print("Dias no cobro$aux");
            final res = diasnocobros
                .where((element) =>
                    DateTime.parse(element.dia!).isAtSameMomentAs(aux))
                .toList();
            print("resultado dias no cobro $res");
            if (res.isNotEmpty) {
              aux = aux.add(const Duration(days: 1));
            }
          }

          fechaactualizada.value = aux.toString();
          print(fechaactualizada.value);
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

          fechaactualizada.value = aux.toString();
        }

        /* var fechaactual = aux = aux.add(const Duration(days: 1)); */
        var ncuota = nim2 += nim;

        if (prestamo != null) {
          Cuotas cuota = Cuotas(
            idprestmo: prestamo!.id,
            ncuotas: ncuota,
            fechadepago: fechaactualizada.value,
            fechaderecaudo: fecharecaudo.value,
            valorcuota: prestamocreadouevo!.valorCuota,
            sesionId: homecontroller.session!.id,
            valorpagado: valorapagar.value,
            estado: Statuscuota.nopagado.name,
          );
          listacuota.add(cuota);
        }
        print("Cuotas $listacuota");
        await cuotaService.savesubcoleccioncuota(
            documentId: prestamo!.id!, cuotas: listacuota);
      }
    }
  }

  ventanadetalles() {
    Get.toNamed(Routes.VENTANARECAUDOSPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamo});
    print("Prestamo${prestamo!.clienteId}");
  }

  ventanacuotas() {
    Get.toNamed(Routes.VENTANACUOTAPRESTAMO,
        arguments: {firebaseReferences.prestamos: prestamo});
    print("Prestamo${prestamo!.clienteId}");
  }

  gettipoprestamoById(String id) async {
    var response = await typePrestamoService.getprestamoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }
}
