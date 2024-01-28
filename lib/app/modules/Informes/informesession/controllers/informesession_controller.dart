import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/services/model_services/session_service.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../models/session_model.dart';
import '../../../../models/transaction_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/transacciones_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class InformesessionController extends GetxController {
  //TODO: Implement InformesessionController
  RxList<Session> session = RxList<Session>([]);
  late Stream<List<Session>> sessionStream;
  final homecontroller = Get.find<HomeController>();
  RxList<Session> consultar = RxList<Session>([]);
  RxList<Session> sessionnuevos = RxList<Session>([]);

  RxList<Transacciones> transacciones = RxList<Transacciones>([]);
  late Stream<List<Transacciones>> transaccionesStream;
  RxList<Transacciones> consultartransaccion = RxList<Transacciones>([]);
  RxList<Transacciones> transaccionesnuevos = RxList<Transacciones>([]);

  RxList<Prestamo> consultarprestamos = RxList<Prestamo>([]);
  RxList<Prestamo> prestamosnuevos = RxList<Prestamo>([]);
  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;

  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  RxList<RecaudoLine> consultarrecaudos = RxList<RecaudoLine>([]);
  RxList<RecaudoLine> recaudosnuevos = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  final formkey = GlobalKey<FormState>();

 RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString fechafinal = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  @override
  void onInit() {
    sessionStream = gersession();
    transaccionesStream = gettransacciones();
    prestamosStream = getprestamos();
    recaudoStream = getrecaudo();
    init();
    super.onInit();
  }

  gettransacciones() =>
      transaccionesService.obtenerlisttransacciones().snapshots().map(
          (event) => event.docs.map((e) => Transacciones.fromJson(e)).toList());

  gersession() => sessionService
      .obtenerlistsesion()
      .snapshots()
      .map((event) => event.docs.map((e) => Session.fromJson(e)).toList());

  getprestamos() => prestamoService
      .obtenerlistprestamo()
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  init() {
    sessionStream.listen((event) async {
      session.value = event;
      consultar.value = event;
      print(event);
    });
    transaccionesStream.listen((event) async {
      transacciones.value = event;
      consultartransaccion.value = event;
      print(event);
    });
    prestamosStream.listen((event) async {
      prestamos.value = event;
      consultarprestamos.value = event;
      print(event);
    });
    recaudoStream.listen((event) async {
      recaudo.value = event;
      consultarrecaudos.value = event;
    });
  }

  metodobusqueda() {
    transaccionesnuevos.clear();
    sessionnuevos.clear();
    prestamosnuevos.clear();
    recaudosnuevos.clear();
    final fechainicio = DateTime.parse(fecha.value);

    var response = session.value = consultar
        .where((element) =>
            DateTime.parse(element.fecha!).isAtSameMomentAs(fechainicio))
        .toList();

    var transaccion = transacciones.value = consultartransaccion
        .where((element) => element.idSession == homecontroller.session!.id)
        .toList();

    var prestamo = prestamos.value = consultarprestamos
        .where((element) => element.sesionId == homecontroller.session!.id)
        .toList();

    var recaudoline = recaudo.value = consultarrecaudos
        .where((element) => element.idSession == homecontroller.session!.id)
        .toList();

    recaudosnuevos.addAll(recaudoline);
    sessionnuevos.addAll(response);
    transaccionesnuevos.addAll(transaccion);
    prestamosnuevos.addAll(prestamo);
    Get.toNamed(Routes.VENTANADEINFORMESSESSION);
  }
}
