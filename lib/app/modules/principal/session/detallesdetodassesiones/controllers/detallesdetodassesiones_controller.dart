import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../models/prestamo_model.dart';
import '../../../../../models/recaudo_line_modal.dart';
import '../../../../../models/session_model.dart';
import '../../../../../models/transaction_model.dart';
import '../../../../../services/model_services/client_service.dart';
import '../../../../../services/model_services/cobradores_service.dart';
import '../../../../../services/model_services/conceptos_service.dart';
import '../../../../../services/model_services/prestamo_service.dart';
import '../../../../../services/model_services/recaudos_service.dart';
import '../../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../../services/model_services/transacciones_service.dart';
import '../../../home/controllers/home_controller.dart';

class DetallesdetodassesionesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Session session;
  late TabController tabController;
  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;
  List<Prestamo> get prestamosget => prestamos;
  final homecontroller = Get.find<HomeController>();

  RxList<Transacciones> transacciones = RxList<Transacciones>([]);
  List<Transacciones> get transaccionesget => transacciones;
  late Stream<List<Transacciones>> transaccionesStream;

  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  RxBool isloading = false.obs;
  @override
  void onInit() {
    session = Get.arguments['sesiones'];
    prestamosStream = getorestamos();
    transaccionesStream = gettransacciones();
    recaudoStream = getrecaudo();
    print(session.id);
    tabController = TabController(length: 3, vsync: this);
    init();
    super.onInit();
  }

  getorestamos() => prestamoService
      .obtenerlistprestamo()
      .where('sesion_id', isEqualTo: session.id)
      .orderBy("recorrido")
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('id_session', isEqualTo: session.id)
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  gettransacciones() => transaccionesService
      .obtenerlisttransacciones()
      .where('id_session', isEqualTo: session.id)
      .snapshots()
      .map(
          (event) => event.docs.map((e) => Transacciones.fromJson(e)).toList());

  init() {
    prestamosStream.listen((event) async {
      prestamos.value = event;
    });
    transaccionesStream.listen((event) async {
      transacciones.value = event;
      transacciones.sort((b, a) => a.fecha!.compareTo(b.fecha!));
    });
    recaudoStream.listen((event) async {
      recaudo.value = event;
      print(recaudo);
    });
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getconceptoById(String id) async {
    var response = await conceptoService.getconceptoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getcobradoresId(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
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
}
