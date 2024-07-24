import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/ajustes_modal.dart';
import '../../../../models/cuotas_modal.dart';
import '../../../../models/diasnocobro_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../services/model_services/ajustes_services.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/diascobro_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../principal/home/controllers/home_controller.dart';

class RecaudarprestamoController extends GetxController {
  RxList<RecaudoLine> recaudarLines = RxList<RecaudoLine>([]);
  RxList<Cuotas> cuotas = RxList<Cuotas>([]);
  late Stream<List<Cuotas>> cuotaStream;
  List<Cuotas> get cuotaget => cuotas;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);
  Diasnocobro? diasnocobro;
  final homecontroller = Get.find<HomeController>();
  final numberFormat = NumberFormat.currency(symbol: "", decimalDigits: 1);
  Prestamo? prestamo;
  Recaudo? recaudo;
  Ajustes? ajustes;
  TypePrestamo? tipoPrestamo;
  RecaudoLine? recaudoline;
  final valor = 0.0.obs;
  final cuota = 0.0.obs;
  DateTime selectedDate = DateTime.now();
  final total = 0.0.obs;
  final montosuma = 0.0.obs;
  final cobrarsabado = false.obs;
  final cobrardomingo = false.obs;
  final formkey = GlobalKey<FormState>();

  final pagodercaudo = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  final fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString().obs;
  RxBool cargando = false.obs;
  late TextEditingController fromDateControler;
  @override
  void onInit() async {
    prestamo = Get.arguments['prestamos'];
    fromDateControler = TextEditingController(text: fecha.value);

    diasnocobroStream = getdiasnocobro();
    cuota.value = prestamo!.valorCuota!;
    valor.value = prestamo!.valorCuota!;
    /*  cuotaStream = getcuota(); */

    getcuota2();
    await getajustesinicial();

    super.onInit();
  }

  getdiasnocobro() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  getcuota2() async {
    print("Id de prestamo${prestamo!.id}");

    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);
    if (response.isNotEmpty) {
      cuotas.value = response;
    }

    print(cuotas);
  }

  /* getcuota() => cuotaService
      .obtenerlistcuota()
      .where('idprestmo', isEqualTo: prestamo!.id)
      .orderBy('fechadepago')
      .snapshots()
      .map((event) => event.docs.map((e) => Cuotas.fromJson(e)).toList()); */

  /*  init() {
    cuotaStream.listen((event) async {
      cuotas.value = event;
    });
  } */

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
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

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getrecaudosinautorizar() async {
    cargando.value = true;
    if (formkey.currentState!.validate()) {
      if (kDebugMode) {
        print("Formulario valido ${homecontroller.cobradores!.id}");
      }
      var res = await recaudoService.createrecaudo(
          object: Recaudo.nueva(
                  fromDateControler.text,
                  homecontroller.cobradores!.id,
                  homecontroller.session!.id!,
                  prestamo!.zonaId)
              .toJson());
      if (res != null) {
        await recaudoService.saveRecaudoLine(RecaudoLine(
            cuota: prestamo!.valorCuota,
            fecha: fromDateControler.text,
            idCliente: prestamo!.clienteId,
            idPrestamo: prestamo!.id,
            idSession: homecontroller.session!.id!,
            monto: valor.value,
            procesado: true,
            idRecaudo: res.id,
            saldoAnterior: prestamo!.saldoPrestamo,
            saldo: prestamo!.saldoPrestamo! - valor.value,
            total: prestamo!.totalPrestamo));

//Autotizar y Cerrar recaudo
        montosuma.value += valor.value;
        res.total = montosuma.value;
        print("Total recaudo ${montosuma.value}");
        res.confirmacion = StatusRecaudo.passed.name;
        res.estado = StatusRecaudo.closed.name;
        await recaudoService.updaterecaudo(res);
//Actualizar PYG
        homecontroller.session!.updatePyG(TipoOperacion.ingreso, valor.value);
        homecontroller.saldo.value = homecontroller.session!.pyg!;
        await sessionService.updateSession(homecontroller.session!);
//Actualizar Cuotas
        final montotemporal = valor.value;
        for (var i in cuotas) {
          if (i.estado != Statuscuota.pagado.name) {
            if (valor.value > 0) {
              if (i.valorpagado == 0) {
                if (valor.value < i.valorcuota!) {
                  i.valorpagado = valor.value;
                  i.idrecaudo = res.id;
                  valor.value = 0;
                  i.estado = Statuscuota.incompleto.name;
                  i.fechaderecaudo = fromDateControler.text;
                } else {
                  i.valorpagado = i.valorcuota!;
                  valor.value = valor.value - i.valorcuota!;
                  i.idrecaudo = res.id;
                  i.estado = Statuscuota.pagado.name;
                  i.fechaderecaudo = fromDateControler.text;
                }
              } else {
                final restante = i.valorcuota! - i.valorpagado!;
                if (valor.value < restante) {
                  i.valorpagado = i.valorpagado! + valor.value;
                  valor.value = 0;
                  i.estado = Statuscuota.incompleto.name;
                  i.fechaderecaudo = fromDateControler.text;
                  i.idrecaudo = res.id;
                } else {
                  i.valorpagado = i.valorcuota!;
                  valor.value = valor.value - restante;
                  i.idrecaudo = res.id;
                  i.estado = Statuscuota.pagado.name;
                  i.fechaderecaudo = fromDateControler.text;
                }
              }
              await cuotaService.updatecuota(
                  documentId: prestamo!.id!, cuota: i);
            }
          }
        }

        final fechaactualizada = "".obs;
        for (var i in cuotas) {
          if (i.estado == Statuscuota.incompleto.name) {
            fechaactualizada.value = i.fechadepago!;
            print(fechaactualizada.value);
            break;
          }
          if (i.estado == Statuscuota.nopagado.name) {
            fechaactualizada.value = i.fechadepago!;
            break;
          }
        }
        prestamo!.fechaPago = fechaactualizada.value;
        prestamo!.saldoPrestamo = prestamo!.saldoPrestamo! - montotemporal;
        prestamo!.estado = StatusPrestamo.aldia.name;
        if (prestamo!.saldoPrestamo! <= 0) {
          prestamo!.estado = StatusPrestamo.pagado.name;
        }
        await prestamoService.updateprestamo(prestamo!);
        Get.back(result: prestamo!);
        cargando.value = false;
      }
    }
    cargando.value = false;
  }
}
