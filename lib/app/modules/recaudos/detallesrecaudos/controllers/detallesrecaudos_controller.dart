import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/recaudo_line_modal.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';

import '../../../../models/cuotas_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/references.dart';
import '../../../principal/home/controllers/home_controller.dart';

class DetallesrecaudosController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final homeControll = Get.find<HomeController>();
/*   final prestamocontroller = Get.find<RecaudarprestamoController>(); */
  Recaudo? recaudo;
  RecaudoLine? recaudoreciente;

  RxList<RecaudoLine> recaudolinea = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  RxList<Cuotas> cuotas = RxList<Cuotas>([]);
  late Stream<List<Cuotas>> cuotaStream;
  List<Cuotas> get cuotaget => cuotas;
  final loadinReciente = true.obs;
  RxBool isloading = false.obs;
  late TabController tabController;
  final homecontroller = Get.find<HomeController>();
  final pagodercaudo = DateTime.now();
  @override
  void onInit() {
    recaudo = Get.arguments['recaudos'];
    recaudoStream = getrecaudo();
    tabController = TabController(length: 1, vsync: this);
    init();
    /*  getcuota2(); */
    super.onInit();
  }

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('id_recaudo', isEqualTo: recaudo!.id)
      .orderBy('fecha')
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  init() {
    recaudoStream.listen((event) async {
      loadinReciente.value = true;
      recaudolinea.value = event;
      recaudoreciente = recaudolinea.length > 0 ? recaudolinea.first : null;
      loadinReciente.value = false;
    });
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getEstado() {
    switch (recaudo!.estado) {
      case 'open':
        return 'Abierto';
      case 'closed':
        return 'Cerrado';
      case 'progress':
        return 'En progreso';
      default:
    }
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getzonaById(String id) async {
    var response = await zonaService.getzonaById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  ventanadetalles() {
    Get.toNamed(Routes.VENTANARECAUDOTODOS,
        arguments: {firebaseReferences.recaudos: recaudo});
  }

  /* autorizarrecaudos() {
    homecontroller.session!.updatePyG(TipoOperacion.ingreso, recaudo!.total!);
    homecontroller.saldo.value = homecontroller.session!.pyg.toString();
    sessionService.updateSession(homecontroller.session!);
    Get.back();
  } */

  autorizarrecaudos() async {
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

    if (recaudo!.total == 0) {
      Get.dialog(const AlertDialog(
        content: Text("No has autorizado ningun recaudo"),
      ));
      return;
    }

    if (recaudo!.estado == StatusRecaudo.open.name) {
      Get.dialog(const AlertDialog(
        content: Text("Debes cerrar el recaudo para autorizar"),
      ));
      return;
    } else if (recaudo!.estado == StatusRecaudo.closed.name) {
      for (var i in recaudolinea) {
        var response = await prestamoService.getprestamosById(i.idPrestamo!);
        i.procesado = true;
        recaudoService.updaterecaudados(i);
        for (var u in response) {
          var resp = await cuotaService.getlistacuotasub(documentId: u.id!);
          if (response.isNotEmpty) {
            cuotas.value = resp;
          }
          final montotemporal = i.monto;
          for (var e in cuotas) {
            if (e.estado != Statuscuota.pagado.name) {
              if (i.monto! > 0) {
                if (e.valorpagado == 0) {
                  if (i.monto! < e.valorcuota!) {
                    e.valorpagado = i.monto!;
                    i.monto = 0;
                    e.idrecaudo = recaudo!.id;
                    e.estado = Statuscuota.incompleto.name;
                    e.fechaderecaudo = pagodercaudo.toString();
                  } else {
                    e.valorpagado = e.valorcuota!;
                    i.monto = i.monto! - e.valorcuota!;
                    e.idrecaudo = recaudo!.id;
                    e.estado = Statuscuota.pagado.name;
                    e.fechaderecaudo = pagodercaudo.toString();
                  }
                } else {
                  final restante = e.valorcuota! - e.valorpagado!;
                  if (i.monto! < restante) {
                    e.valorpagado = e.valorpagado! + i.monto!;
                    i.monto = 0;
                    e.estado = Statuscuota.incompleto.name;
                    e.idrecaudo = recaudo!.id;
                    e.fechaderecaudo = pagodercaudo.toString();
                  } else {
                    e.valorpagado = e.valorcuota!;
                    i.monto = i.monto! - restante;
                    e.idrecaudo = recaudo!.id;
                    e.estado = Statuscuota.pagado.name;
                    e.fechaderecaudo = pagodercaudo.toString();
                  }
                }
                print("valor cuota ${e.valorpagado}");
                await cuotaService.updatecuota(documentId: u.id!, cuota: e);
              }
            }
          }
          final fechaactualizada = "".obs;
          for (var o in cuotas) {
            if (o.estado == Statuscuota.incompleto.name) {
              fechaactualizada.value = o.fechadepago!;
            }
            if (o.estado == Statuscuota.nopagado.name) {
              fechaactualizada.value = o.fechadepago!;
              break;
            }
          }
          u.fechaPago = fechaactualizada.value;
          u.saldoPrestamo = u.saldoPrestamo! - montotemporal!;
          u.estado = StatusPrestamo.aldia.name;
          if (u.saldoPrestamo! <= 0) {
            u.estado = StatusPrestamo.pagado.name;
          }
          prestamoService.updateprestamo(u);
        }
      }
      homecontroller.session!.updatePyG(TipoOperacion.ingreso, recaudo!.total!);
      homecontroller.saldo.value = homecontroller.session!.pyg!;
      sessionService.updateSession(homecontroller.session!);

      recaudo!.confirmacion = StatusRecaudo.passed.name;
      recaudoService.updaterecaudo(recaudo!);

      Get.back();
    }
  }
}
