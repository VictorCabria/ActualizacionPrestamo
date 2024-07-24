import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/references.dart';

class VentanaseguimientocobradoresController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement VentanasseguimientocobradoresController
  Cobradores? cobrador;
  RxList<Recaudo> recaudo = RxList<Recaudo>([]);
  late Stream<List<Recaudo>> recaudoStream;
  Recaudo? recaudoreciente;
  late TabController tabController;
  final loadinReciente = true.obs;
  final montorecaudos = 0.0.obs;
  RxBool isloading = false.obs;
  @override
  void onInit() {
    cobrador = Get.arguments['cobradores'];
    recaudoStream = getrecaudo();
    tabController = TabController(length: 1, vsync: this);
    init();
    super.onInit();
  }

  getrecaudo() {
    return recaudoService
        .obtenerlistrecaudos()
        .where('id_cobrador', isEqualTo: cobrador!.id)
        .where('confirmacion', isEqualTo: "passed")
        .snapshots()
        .map((event) => event.docs.map((e) => Recaudo.fromJson(e)).toList());
  }

  init() {
    loadinReciente.value = true;
    recaudoStream.listen((event) async {
      recaudo.value = event;
      recaudoreciente = recaudo.isNotEmpty ? recaudo.first : null;
      montoyinteres();
      loadinReciente.value = false;
    });
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
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

  editarcobrador(Cobradores cobradorfiltrado) {
    Get.toNamed(Routes.EDITCOBRADORES,
        arguments: {firebaseReferences.cobradores: cobradorfiltrado});
  }

  ventanadetalles() {
    Get.toNamed(Routes.VENTANARECAUDOSSEGUIMIENTO,
        arguments: {firebaseReferences.cobradores: cobrador});
  }

  montoyinteres() async {
    montorecaudos.value = 0;
    for (var i in recaudo) {
      montorecaudos.value += i.total!.toInt();
    }
  }
}
