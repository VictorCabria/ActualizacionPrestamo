import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';
import 'package:prestamo_mc/app/services/model_services/session_service.dart';
import 'package:prestamo_mc/app/utils/app_constants.dart';

import '../../../../models/cuotas_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../utils/references.dart';
import '../../../principal/home/controllers/home_controller.dart';

class PanelrecaudosController extends GetxController {
  final HomeController homecontroller = Get.find<HomeController>();
  final gestorMode = false.obs;
  final loading = false.obs;
  RxList<Recaudo> selectedItem = RxList();
  final scrollController = ScrollController();
  RxList<Recaudo> recaudo = RxList<Recaudo>([]);
  RxList<Recaudo> consultarecaudo = RxList<Recaudo>([]);
  RxList<RecaudoLine> recaudodoLines = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudolineStream;
  late Stream<List<Recaudo>> recaudoStream;
  RxList<Cuotas> cuotas = RxList<Cuotas>([]);
  late Stream<List<Cuotas>> cuotaStream;
  List<Recaudo> get recaudoget => recaudo;
  final pagodercaudo = DateTime.now();

  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  Recaudo? recaudos;
  RecaudoLine? recaudolinea;
  final cobrador = ''.obs;
  final isOpen = false.obs;
  final isNulll = true.obs;
  final fecha = ''.obs;
  final numRecaudado = 0.obs;
  RxBool cargando = false.obs;
  final numecantidad = 0.obs;
  var numRecaudado2 = 0;
  var totalrecaudados = 0.0;
  var totalrecaudos = 0.0.obs;
  final total = 0.0.obs;
  RxBool isBuscar = false.obs;

  @override
  void onInit() {
    recaudoStream = getrecaudo();
    recaudolineStream = getlistarecaudados();
    prestamosStream = getlistaprestamo();

    super.onInit();
    init();
    ultimorecaudo();
  }

  getEstado() {
    switch (recaudos!.estado) {
      case 'open':
        return 'Abierta';
      case 'closed':
        return 'Cerrada';
      case 'passed':
        return 'Aprobado';
      default:
        return 'Abierta';
    }
  }

  void closerecaudo() async {
    if (recaudos != null) {
      recaudos!.estado = StatusRecaudo.closed.name;
      await recaudoService.updaterecaudo(recaudos!);
      isOpen.value = false;
    }
  }

  void recaudar() async {
    Get.toNamed(Routes.LINEASRECAUDOS, arguments: recaudos);
  }

  void createrecaudo() async {
    if (recaudos == null) {
      var data = await Get.toNamed(Routes.CREATE_RECAUDOS);
      if (data != null) {
        recaudos = data;
        isNulll.value = false;
        fecha.value =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(recaudos!.fecha!));
        isOpen.value = true;
      }
    } else {
      if (recaudos!.estado == StatusRecaudo.closed.name) {
        var data = await Get.toNamed(Routes.CREATE_RECAUDOS);
        if (data != null) {
          recaudos = data;
          isNulll.value = false;
          fecha.value =
              DateFormat('dd/MM/yyyy').format(DateTime.parse(recaudos!.fecha!));
          isOpen.value = true;
        }
      }
    }
  }

  void doMultiSelection(Recaudo recaudo) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(recaudo)) {
        selectedItem.remove(recaudo);
      } else {
        selectedItem.add(recaudo);
      }
    } else {
      if (homecontroller.gestorMode.value) {
      } else {
        detallerecaudo(recaudo);
      }
    }
  }

  String getSelectedtransacciones() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  delete() async {
    cargando.value = true;

    for (var i = 0; i < selectedItem.length; i++) {
      if (selectedItem[i].confirmacion == StatusRecaudo.nopassed.name) {
        var respnuevo =
            await recaudoService.getrecaudolineById(selectedItem[i].id!);
        for (var c in respnuevo) {
          if (selectedItem[i].id == c.idRecaudo) {
            recaudoService.deleterecaudados(c);
          }
        }
        recaudoService.deleterecaudos(selectedItem[i]);
      } else {
        if (homecontroller.session == null) {
          recaudoService.deleterecaudos(selectedItem[i]);
        }
        var resp = await recaudoService.getrecaudolineById(selectedItem[i].id!);
        for (var l in resp) {
          var response = await prestamoService.getprestamosById(l.idPrestamo!);

          for (var u in response) {
            var response = await cuotaService.getlistacuotasubdesencente(
                documentId: u.id!);
            if (response.isNotEmpty) {
              cuotas.value = response;
            }
            var aux = l.monto;
            for (var o in cuotas) {
              if (aux! > 0) {
                if (o.estado == Statuscuota.pagado.name) {
                  if (o.valorpagado == o.valorcuota) {
                    if (aux > o.valorpagado!) {
                      aux = aux - o.valorpagado!;
                      o.valorpagado = 0;
                    } else {
                      o.valorpagado = o.valorpagado! - aux;
                      aux = 0;
                    }
                    if (o.valorpagado != 0) {
                      o.estado = Statuscuota.incompleto.name;
                    } else {
                      o.estado = Statuscuota.nopagado.name;
                      o.fechaderecaudo = "";
                    }
                  }
                } else if (o.estado == Statuscuota.incompleto.name) {
                  if (aux > o.valorpagado!) {
                    aux = aux - o.valorpagado!;
                    o.valorpagado = 0;
                  } else {
                    o.valorpagado = o.valorpagado! - aux;
                    aux = 0;
                  }
                  if (o.valorpagado != 0) {
                    o.estado = Statuscuota.incompleto.name;
                  } else {
                    o.estado = Statuscuota.nopagado.name;
                    o.fechaderecaudo = "";
                  }
                }
                cuotaService.updatecuota(documentId: u.id!, cuota: o);
              }
            }
            final fechaactualizada = "".obs;
            if (u.id == l.idPrestamo) {
              if (selectedItem[i].confirmacion == StatusRecaudo.passed.name) {
                u.saldoPrestamo = u.saldoPrestamo! + l.monto!;
              }
              var responsecuotas =
                  await cuotaService.getlistacuotasub(documentId: u.id!);
              for (var i in responsecuotas) {
                if (i.estado == Statuscuota.incompleto.name) {
                  fechaactualizada.value = i.fechadepago!;
                  break;
                }
                if (i.estado == Statuscuota.nopagado.name) {
                  fechaactualizada.value = i.fechadepago!;
                  break;
                }
              }
              u.fechaPago = fechaactualizada.value;
              await prestamoService.updateprestamo(u);
            }
          }
          if (selectedItem[i].id == l.idRecaudo) {
            recaudoService.deleterecaudados(l);
          }
        }

        homecontroller.session!.updatePyG(
            TipoOperacion.ingreso, selectedItem[i].total!,
            crear: false);
        sessionService.updateSession(homecontroller.session!);
        homecontroller.saldo.value = homecontroller.session!.pyg!;
        recaudoService.deleterecaudos(selectedItem[i]);
        recaudo.remove(selectedItem[i]);
      }

      cargando.value = false;
    }
    selectedItem.clear();
  }

  void ultimorecaudo() async {
    cargando.value = true;
    cobrador.value = homecontroller.cobradores!.id!;
    var response = await recaudoService.getLast(cobrador.value);
    if (response != null) {
      recaudos = response;
      fecha.value =
          DateFormat('dd/MM/yyyy').format(DateTime.parse(recaudos!.fecha!));
      isNulll.value = false;
      if (recaudos!.estado != 'closed') {
        isOpen.value = true;
      } else {
        isOpen.value = false;
      }
    }
    cargando.value = false;
  }

  detallerecaudo(Recaudo recaudo) {
    Get.toNamed(Routes.DETALLESRECAUDOS,
        arguments: {firebaseReferences.recaudos: recaudo});
  }

  getrecaudo() {
    if (homecontroller.gestorMode.value) {
      return recaudoService
          .obtenerlistrecaudos()
          .where('id_cobrador', isEqualTo: homecontroller.cobradores!.id)
          .snapshots()
          .map((event) => event.docs.map((e) => Recaudo.fromJson(e)).toList());
    }
    return recaudoService
        .obtenerlistrecaudos()
        .orderBy('fecha', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => Recaudo.fromJson(e)).toList());
  }

  getlistarecaudados() => recaudoService
      .obtenerlistrecaudo()
      /*  .where('id_session', isEqualTo: homecontroller.session!.id) */
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  getlistaprestamo() => prestamoService
      .obtenerlistprestamo()
      /* . where('id_session', isEqualTo: homecontroller.session!.id) */
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  init() {
    recaudoStream.listen((event) async {
      recaudo.value = event;
      consultarecaudo.value = event;
      filtrarlist(1);
    });
    recaudolineStream.listen((event) async {
      recaudodoLines.value = event;
      montototal();

      /*  mapearRecaudado(); */
    });

    prestamosStream.listen((event) async {
      prestamos.value = event;
    });
  }

  cantidad(Recaudo recaudo) {
    var recaudos2 =
        recaudodoLines.where((p0) => p0.idRecaudo == recaudo.id).toList();

    if (recaudos2.isNotEmpty) {
      numecantidad.value =
          recaudos2.where((e) => e.idRecaudo! == recaudo.id).toList().length;
      return numecantidad;
    }
  }

  monto(Recaudo recaudo) async {
    var recaudos =
        recaudodoLines.where((p0) => p0.idRecaudo == recaudo.id).toList();

    mapearRecaudado(recaudo);

    if (recaudos.isNotEmpty) {
      totalrecaudados = recaudos
          .map((e) => e.monto)
          .reduce((value, element) => value! + element!)!;

      return totalrecaudados;
    } else {
      return 0;
    }
  }

  montototal() async {
    totalrecaudos.value = 0;

    for (var i in recaudodoLines) {
      totalrecaudos.value += i.monto!.toInt();
    }
  }

  void filtrarlist(i, [i2, i3]) {
    //mete aqui los estados
    final estados = [
      StatusRecaudo.passed.name,
      StatusRecaudo.nopassed.name,
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
      recaudo.value = consultarecaudo
          .where((element) =>
              element.confirmacion == filtro1 ||
              element.confirmacion == filtro2 ||
              element.confirmacion == filtro3)
          .toList();
    } else if (filtro3 != null) {
      recaudo.value = consultarecaudo
          .where((element) =>
              element.estado == filtro1 || element.confirmacion == filtro3)
          .toList();
    } else if (filtro2 != null) {
      recaudo.value = consultarecaudo
          .where((element) =>
              element.estado == filtro1 || element.confirmacion == filtro2)
          .toList();
    } else if (filtro1 == "todos") {
      recaudo.value = consultarecaudo.toList();
    } else {
      recaudo.value = consultarecaudo
          .where((element) => element.confirmacion == filtro1)
          .toList();
    }
  }

  mapearRecaudado(Recaudo recaudo) {
    var recaudos2 =
        recaudodoLines.where((p0) => p0.idRecaudo == recaudo.id).toList();
    if (recaudos2.isNotEmpty) {
      numRecaudado2 =
          recaudos2.where((e) => e.idRecaudo! == recaudo.id).toList().length;
      return numRecaudado2;
    }
  }

  getcobradoresId(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      recaudo.value = consultarecaudo;
    }
  }

  searching(String texto) {
    if (texto != '') {
      recaudo.value = consultarecaudo
          .where((p0) =>
              (p0.total.toString()).toUpperCase().contains(texto.toUpperCase()))
          .toList();
    } else {
      recaudo.value = consultarecaudo;
    }
  }
}
