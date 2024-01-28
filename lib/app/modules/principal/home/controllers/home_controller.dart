import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/ajustes_modal.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/models/company_model.dart';
import 'package:prestamo_mc/app/models/session_model.dart';
import 'package:prestamo_mc/app/modules/principal/ajustes/controllers/ajustes_controller.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';

import '../../../../services/firebase_services/auth_service.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../../utils/utils.dart';

class HomeController extends GetxController {
  final gestorMode = false.obs;
  final loading = false.obs;
  final isExpanded = false.obs;
  final isOpen = false.obs;
  final isNulll = true.obs;
  RxBool cargando = false.obs;

  Session? session;
  Session? sessionAnterior;
  Cobradores? cobradores;
  Company? company;
  Ajustes? ajustes;

  //info de la session
  final fecha = ''.obs;
  final cobrador = ''.obs;
  final saldo = 0.0.obs;
  final zona = ''.obs;
  final prestamos = ''.obs;
  final transacciones = ''.obs;
  final recaudos = ''.obs;

  final scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    cargando.value = true;

    gestorMode.value =
        Get.arguments != null ? Get.arguments['gestorMode'] : false;
    await getCobrador();

    getLastSession();
    scrollController.addListener(_onScroll);
    cargando.value = false;
  }

  getCobrador() async {
    if (gestorMode.value) {
      cobradores = Get.arguments != null ? Get.arguments['cobrador'] : null;
      cobrador.value = cobradores!.nombre!;
    } else {
      var response = await cobradoresService
          .loginCobradorAdmin(auth.getCurrentUser()!.uid);
      if (response != null) {
        cobradores = response;
        cobrador.value = cobradores!.nombre!;
        print('Cobrador${cobradores!.nombre!}');
      }
    }
  }

  void goToPrestamos() {
    print('goToPrestamos');
    Get.toNamed(Routes.LIST_PRESTAMO);
  }

  void createSession() async {
    Get.put(AjustesController());
    if (session == null) {
      //create new session
      var data = await Get.toNamed(Routes.CREATE_SESSION);
      if (data != null) {
        session = data;
        fecha.value =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(session!.fecha!));

        saldo.value = session!.pyg!;
        zona.value = session!.zonaId!;
        isNulll.value = false;
        isOpen.value = true;
      }
    } else {
      //resume session
      if (session!.estado == StatusSession.closed.name) {
        sessionAnterior = session;
        var data = await Get.toNamed(Routes.CREATE_SESSION);
        if (data != null) {
          session = data;
          fecha.value =
              DateFormat('dd/MM/yyyy').format(DateTime.parse(session!.fecha!));

          saldo.value = session!.pyg!;
          zona.value = session!.zonaId!;
          isNulll.value = false;
          isOpen.value = true;

          print(sessionAnterior!.toJson());
          print(session!.toJson());
        }
      }
    }
  }

  void recaudar() async {
    Get.toNamed(Routes.DETALLESSESSION);
  }

  void getLastSession() async {
    print("getLastSession ${cobradores!.id}");
    /* var res = await sessionService.getLastSession(cobradores!.id!); */
    var res = await sessionService.getLastSessiontodos();
    if (res != null) {
      session = res;
      fecha.value =
          DateFormat('dd/MM/yyyy').format(DateTime.parse(session!.fecha!));
      cobrador.value = cobradores!.nombre!;
      saldo.value = session!.pyg!;
      zona.value = session!.zonaId!;
      isNulll.value = false;
      if (session!.estado != 'closed') {
        isOpen.value = true;
      } else {
        isOpen.value = false;
      }

      /*    prestamos.value = session!.prestamoCnt.toString();
      transacciones.value = session!.transaccionCnt.toString();
      recaudos.value = session!.recaudoCnt.toString(); */
    }
  }

  void closeSession() async {
    Get.dialog(AlertDialog(
      content: Text("Estas seguro que quieres cerrar session"),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              if (session != null) {
                session!.estado = StatusSession.closed.name;
                sessionService.updateSession(session!);
                isOpen.value = false;
              }
              Get.back();
            },
            child: const Text("Aceptar")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancelar"))
      ],
    ));
  }

  recaudosentrar() {
    if (session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    } else {
      Get.toNamed(Routes.PANELRECAUDOS);
    }
  }

  transaccionesentrar() {
    if (session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    } else {
      Get.toNamed(Routes.LISTATRANSACCIONES);
    }
  }

  getEstado() {
    switch (session!.estado) {
      case 'open':
        return 'Abierta';
      case 'closed':
        return 'Cerrada';

      case 'progress':
        return 'En progreso';
      default:
        return 'Abierta';
    }
  }

  logout() async {
    var response = await auth.signOut();
    if (response) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  _onScroll() {
    isExpanded.value = isSliverAppBarExpanded;
    if (kDebugMode) {
      print(isExpanded.value);
    }
  }

  bool get isSliverAppBarExpanded {
    return scrollController.hasClients &&
        scrollController.offset > (150 - kToolbarHeight);
  }
}
