import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/transaction_model.dart';
import 'package:prestamo_mc/app/modules/principal/home/controllers/home_controller.dart';
import 'package:prestamo_mc/app/services/model_services/conceptos_service.dart';
import 'package:prestamo_mc/app/services/model_services/recaudos_service.dart';

import '../../../../../models/prestamo_model.dart';
import '../../../../../models/recaudo_line_modal.dart';
import '../../../../../models/recaudo_model.dart';
import '../../../../../services/model_services/client_service.dart';
import '../../../../../services/model_services/cobradores_service.dart';
import '../../../../../services/model_services/prestamo_service.dart';
import '../../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../../services/model_services/transacciones_service.dart';

class DetallessessionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement DetallessessionController

  late TabController tabController;
  final homecontroller = Get.find<HomeController>();
  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;
  List<Prestamo> get prestamosget => prestamos;
  final homeControll = Get.find<HomeController>();

  RxList<Transacciones> transacciones = RxList<Transacciones>([]);
  List<Transacciones> get transaccionesget => transacciones;
  late Stream<List<Transacciones>> transaccionesStream;

  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;
  List<RecaudoLine> get recaudoget => recaudo;
  RxBool isloading = false.obs;
  @override
  void onInit() {
    prestamosStream = getorestamos();
    transaccionesStream = gettransacciones();
    recaudoStream = getrecaudo();
    tabController = TabController(length: 3, vsync: this);
    init();
    super.onInit();
  }

  getorestamos() => prestamoService
      .obtenerlistprestamo()
      .where('sesion_id', isEqualTo: homeControll.session!.id)
      .orderBy("recorrido")
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .where('id_session', isEqualTo: homeControll.session!.id)
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  gettransacciones() => transaccionesService
      .obtenerlisttransacciones()
      .where('id_session', isEqualTo: homeControll.session!.id)
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
    });
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
