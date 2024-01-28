import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/barrio_modal.dart';
import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../utils/references.dart';

class DetallezonaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Zone? zone;
  RxBool isloading = false.obs;
  late TabController tabController;
  final loadinReciente = true.obs;
  RxList<Barrio> barrios = RxList<Barrio>([]);
  late Stream<List<Barrio>> barriosStream;
  List<Barrio> get barriosget => barrios;
  @override
  void onInit() {
    zone = Get.arguments['zona'];
    barriosStream = getbarrios();
    init();
    tabController = TabController(length: 1, vsync: this);
  }

  getbarrios() => barrioService
      .obtenerlistbarrios()
      .orderBy("nombre")
      .where('zona.id', isEqualTo: zone!.id)
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  init() {
    barriosStream.listen((event) async {
      barrios.value = event;
    });
  }

  editarzone(Zone zona) {
    Get.toNamed(Routes.EDITZONE, arguments: {firebaseReferences.zona: zona});
  }
}
