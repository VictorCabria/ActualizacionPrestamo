import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/models/prestamo_model.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';
import 'package:prestamo_mc/app/services/model_services/barrio_service.dart';
import 'package:prestamo_mc/app/services/model_services/prestamo_service.dart';
import '../../../../models/ajustes_modal.dart';
import '../../../../models/cuotas_modal.dart';
import '../../../../models/diasnocobro_modal.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/ajustes_service.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/diascobro_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../principal/home/controllers/home_controller.dart';

class EditprestamoController extends GetxController {
  final homeControll = Get.find<HomeController>();

  final loading = false.obs;
  final scrollController = ScrollController();
  TextEditingController? textController = TextEditingController();

  //inicializar variables
  Client? client;
  late TextEditingController clientecontroller,
      tipodeprestamocontroller,
      recorridocontroller,
      montoTextController;
  Zone? zona;
  Ajustes? ajustes;
  TypePrestamo? tipoPrestamo;
  Cobradores? cobrador;
  Barrio? barrio;
  Prestamo? prestamo;
  Timestamp primerrecaudo = Timestamp.now();
  final pagodercaudo = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  //inicializar listas
  final clients = [].obs;
  final zonas = [].obs;
  final tipoPrestamos = [].obs;
  final zonaslist = [].obs;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);
  RxList<RecaudoLine> recaudarLines = RxList<RecaudoLine>([]);
  RxBool cargando = false.obs;

//calculos
  final monto = 0.0.obs;
  final porcentaje = 0.0.obs;
  final total = 0.0.obs;
  final cuotas = 0.obs;
  final meses = 0.obs;
  final valorCuota = '0.0'.obs;
  final detalle = ''.obs;
  final fecha = ''.obs;
  final cliente = ''.obs;
  final fechapago = ''.obs;
  final cobrarsabado = false.obs;
  final cobrardomingo = false.obs;
  final fecharecaudo = "".obs;
  final valorapagar = 0.0.obs;

  final formkey = GlobalKey<FormState>();
  @override
  void onInit() async {
    prestamo = Get.arguments['prestamos'];
    cobrador = homeControll.cobradores;
    clientecontroller = TextEditingController();
    recorridocontroller = TextEditingController();
    montoTextController = TextEditingController();
    tipodeprestamocontroller = TextEditingController();
    monto.value = prestamo!.monto!;
    montoTextController.text = monto.value.toString();
    valorCuota.value = prestamo!.valorCuota.toString();
    textController!.text = valorCuota.value;
    fecha.value = prestamo!.fecha!;
    fechapago.value = prestamo!.fechaPago.toString();
    clients.value = await getListClients();
    zonas.value = await getListZona();
    diasnocobroStream = getdiasnocobro();
    await getajustes();
    tipoPrestamos.value = await getListTypePrestamo();
    await getlistarecaudados();
    getajustesinicial();
    init();
    update(['recorrido', 'zone', 'tipoprestamo', 'monto', 'cliente']);
    calculoPrestamo(null, monto.value, null);
    super.onInit();
  }

  //init data
  getListClients() async {
    return await clientService.getClients();
  }

  getListZona() async {
    return await zonaService.getzones();
  }

  getListTypePrestamo() async {
    return await typePrestamoService.getTypes();
  }

  init() {
    diasnocobroStream.listen((event) async {
      diasnocobros.value = event;
      print("Dias no cobro$diasnocobros");
    });
  }

  getdiasnocobro() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  getlistarecaudados() async {
    var response =
        await recaudoService.getLineaRecaudadoprestamos(prestamo!.id!);

    recaudarLines.value = response;

    print(recaudarLines.length);
  }

  //onchange events
  onChangeClient(Client? client) async {
    if (client != null) {
      this.client = client;
      String idBarrio = client.barrio['id'];
      barrio = await barrioService.selectBarrio(idBarrio);
      update(['recorrido']);
      if (barrio != null) {
        zona = zonas.where((z) => z.id == barrio!.zona['id']).first;
        update(['zone']);
      }
    }
  }

  onChangetypeprestamo() async {
    try {
      var res = await Get.toNamed(Routes.SEACHTIPOPRESTAMO);
      print("res ${res.nombre}");
      if (res != null) {
        tipoPrestamo = res;
        var lista = tipoPrestamos.where((c) => c.id == res.id).toList();
        tipoPrestamo = lista.isNotEmpty ? lista.first : res;
        tipodeprestamocontroller.text = tipoPrestamo!.nombre!;
        calculoPrestamo(tipoPrestamo, null, null);
      }
    } catch (error) {
      print(error);
    }
  }

  void getajustesinicial() async {
    try {
      // var res = await prestamoService.getprestamo();
      // if (res != null) {
      //   prestamo = res;
      tipoPrestamo =
          tipoPrestamos.where((p0) => p0.id == prestamo!.tipoPrestamoId).first;
      client = clients.where((p0) => p0.id == prestamo!.recorrido).first;
      zona = zonas.where((p0) => p0.id == prestamo!.zonaId).first;
      clientecontroller.text = client!.nombre!;
      tipodeprestamocontroller.text = tipoPrestamo!.nombre!;
      print("zone ${zona!.id}     ${prestamo!.zonaId}");
      update(['tipoprestamo', 'recorrido', 'zone', 'cliente']);
      calculoPrestamo(tipoPrestamo, null, null);
      // }

    } catch (error) {
      print(error);
    }
  }

  Future<void> getajustes() async {
    var res = await ajustesservice.getajustes();
    if (res != null) {
      ajustes = res;
      cobrarsabado.value = ajustes!.cobrarsabados!;
      cobrardomingo.value = ajustes!.cobrardomingos!;
    }
  }

  onChangecliente() async {
    try {
      var res = await Get.toNamed(Routes.SEACHCLIENTE2);
      print("res ${res.recorrido}");
      if (res != null) {
        client = res;
        var lista = clients.where((c) => c.id == res.id).toList();
        client = lista.isNotEmpty ? lista.first : res;
        clientecontroller.text = client!.nombre!;

        var idBarrio = client!.barrio['id'];
        barrio = await barrioService.selectBarrio(idBarrio);

        if (barrio != null) {
          zona = zonas.where((z) => z.id == barrio!.zona['id']).first;
          update(['zone', 'recorrido']);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  onChangeZona(Zone? zona) {
    if (zona != null) {
      this.zona = zona;
    }
  }

  onChangerecorrido(Client? client) {
    if (client != null) {
      this.client = client;
    }
  }

  onChangeTipoPrestamo(TypePrestamo? tipoPrestamo) {
    if (tipoPrestamo != null) {
      this.tipoPrestamo = tipoPrestamo;
      calculoPrestamo(this.tipoPrestamo, null, null);
    }
  }

  onChangeMonto(String monto) {
    this.monto.value = double.parse(monto);
    calculoPrestamo(null, this.monto.value, null);
  }

  onChangeCuota(String cuota) {
    valorCuota.value = double.parse(cuota).toString();
    calculoPrestamo(null, null, double.parse(cuota));
  }

  //calculo de prestamo
  void calculoPrestamo(TypePrestamo? tipo, double? monto, double? cuota) {
    if (tipo != null) {
      print("tipo");
      cuotas.value = tipo.cuotas!;
      porcentaje.value = tipo.porcentaje!;
      meses.value = tipo.meses!;
      total.value =
          this.monto.value + (this.monto.value * (porcentaje.value / 100));
      valorCuota.value = (total.value / cuotas.value).toStringAsFixed(1);
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      textController!.text = valorCuota.value;
      calcularDetalle();
    }
    if (monto != null) {
      print("monto");
      total.value =
          this.monto.value + (this.monto.value * (porcentaje.value / 100));
      valorCuota.value = (total.value / cuotas.value).toStringAsFixed(1);
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      textController!.text = valorCuota.value;
      calcularDetalle();
    }

    if (cuota != null) {
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      double auxTotal = cuotas.value * double.parse(valorCuota.value);
      cuotas.value += total.value - auxTotal > 0 ? 1 : 0;
      calcularDetalle();
    }
  }

  calcularDetalle() {
    try {
      int aux = 0;
      int aux2 = 0;
      double auxTotal = total.value;
      double auxCuota = double.parse(valorCuota.value);

      for (int i = 0; i < cuotas.value; i++) {
        if (double.parse(auxTotal.toStringAsFixed(1)) >=
            double.parse(auxCuota.toStringAsFixed(1))) {
          aux++;
          auxTotal = auxTotal - auxCuota;
        } else {
          print("total $auxTotal cuota $auxCuota");
          aux2++;
        }
      }
      if (aux2 > 0) {
        detalle.value =
            '$aux cuotas de $valorCuota y $aux2 cuotas de ${auxTotal.toStringAsFixed(1)}';
      } else {
        detalle.value = '$aux cuotas de $valorCuota';
      }
    } catch (error) {
      print(error);
    }
  }

  void editPrestamo() async {
    cargando.value = true;
    if (homeControll.session!.id != null) {
      if (formkey.currentState!.validate()) {
        prestamo!.clienteId = client!.id;
        prestamo!.detalle = detalle.value;
        prestamo!.fecha = fecha.value;
        prestamo!.monto = monto.value;
        prestamo!.zonaId = zona!.id;
        prestamo!.recorrido = client!.id;
        prestamo!.fechaPago = fechapago.value;
        prestamo!.saldoPrestamo = total.value;
        prestamo!.numeroDeCuota = cuotas.value;
        prestamo!.porcentaje = porcentaje.value;
        prestamo!.tipoPrestamoId = tipoPrestamo!.id;
        prestamo!.totalPrestamo = total.value;
        prestamo!.valorCuota = double.parse(valorCuota.value);
        var response = await prestamoService.updateprestamo(prestamo!);

        if (response != null) {
          var resp = await cuotaService.getlistacuotasubdesencente(
              documentId: prestamo!.id!);
          for (var o in resp) {
            prestamoService.deleteprestamosubcoleccion(
                collectionDocumentId: prestamo!.id!,
                subcollectionDocumentId: o.id!);
          }

          RxList<Cuotas> listacuota = RxList<Cuotas>([]);
          var aux = DateTime.parse(prestamo!.fecha!);
          var nim = 1;
          var nim2 = 0;
          int aux2 = 0;
          int aux3 = 0;
          double auxTotal = prestamo!.saldoPrestamo!;
          double auxCuota = prestamo!.valorCuota!;

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
            }
            if (double.parse(auxTotal.toStringAsFixed(1)) >=
                double.parse(auxCuota.toStringAsFixed(1))) {
              aux2++;
              auxTotal = auxTotal - auxCuota;
            } else {
              aux3++;
            }
            if (aux3 > 0) {
              valorCuota.value = auxTotal.toString();
            } else {
              valorCuota.value = auxCuota.toString();
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
                valorcuota: double.parse(valorCuota.value),
                sesionId: homeControll.session!.id,
                valorpagado: valorapagar.value,
                estado: Statuscuota.nopagado.name,
              );
              listacuota.add(cuota);
            }
            print("Cuotas $listacuota");
            await cuotaService.savesubcoleccioncuota(
                documentId: prestamo!.id!, cuotas: listacuota);
          }
          var datoscuotas = 0.0.obs;
          var idrecaudo = "".obs;
          for (var i in recaudarLines) {
            datoscuotas.value = datoscuotas.value + i.monto!;
            idrecaudo.value = i.idRecaudo!;

            print(datoscuotas);
          }
          prestamo!.saldoPrestamo =
              prestamo!.saldoPrestamo! - datoscuotas.value;
          await prestamoService.updateprestamo(prestamo!);

          var responsecuotas =
              await cuotaService.getlistacuotasub(documentId: prestamo!.id!);
          for (var u in responsecuotas) {
            print(responsecuotas);
            if (u.estado != Statuscuota.pagado.name) {
              if (datoscuotas.value > 0) {
                if (u.valorpagado == 0) {
                  if (datoscuotas.value < u.valorcuota!) {
                    u.valorpagado = datoscuotas.value;
                    u.idrecaudo = idrecaudo.value;
                    datoscuotas.value = 0;
                    u.estado = Statuscuota.incompleto.name;
                    u.fechaderecaudo = pagodercaudo.toString();
                  } else {
                    u.valorpagado = u.valorcuota!;
                    datoscuotas.value = datoscuotas.value - u.valorcuota!;
                    u.idrecaudo = idrecaudo.value;
                    u.estado = Statuscuota.pagado.name;
                    u.fechaderecaudo = pagodercaudo.toString();
                  }
                } else {
                  final restante = u.valorcuota! - u.valorpagado!;
                  if (datoscuotas.value < restante) {
                    u.valorpagado = u.valorpagado! + datoscuotas.value;
                    datoscuotas.value = 0;
                    u.estado = Statuscuota.incompleto.name;
                    u.fechaderecaudo = pagodercaudo.toString();
                    u.idrecaudo = idrecaudo.value;
                  } else {
                    u.valorpagado = u.valorcuota!;
                    datoscuotas.value = datoscuotas.value - restante;
                    u.idrecaudo = idrecaudo.value;
                    u.estado = Statuscuota.pagado.name;
                    u.fechaderecaudo = pagodercaudo.toString();
                  }
                }
              }
            }

            await cuotaService.updatecuota(documentId: prestamo!.id!, cuota: u);
          }
          responsecuotas.clear();
        }

        Get.back(result: prestamo);
        cargando.value = false;
      } else {
        print("no validado");
      }
    } else {
      print("no hay session");
    }
    cargando.value = false;
  }
}
