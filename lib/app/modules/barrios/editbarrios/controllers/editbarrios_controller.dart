// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/barrio_modal.dart';
import '../../../../models/zone_model.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/zona_service.dart';

class EditbarriosController extends GetxController {
  final formkey = GlobalKey<FormState>();
  RxList<Zone> zonecontroller = RxList<Zone>([]);
  Zone? editzona;
  RxBool loading = false.obs;
  late Stream<List<Zone>> zoneStream;
  late Barrio barrio;
  final nombre = "".obs;

  @override
  void onInit() {
    barrio = Get.arguments['barrios'];
    nombre.value = barrio.nombre!;
    editzona = Zone.fromDinamic(barrio.zona);

    zoneStream = getzone();
    init();
    super.onInit();
  }

  void onChangeDorpdown(String? zona) {
    editzona = zonecontroller.value.firstWhere((element) => element.id == zona);
  }

  getzone() => zonaService
      .obtenerlistzonas()
      .snapshots()
      .map((event) => event.docs.map((e) => Zone.fromJson(e)).toList());
  init() {
    zoneStream.listen((event) async {
      zonecontroller.value = event;
      editzona = zonecontroller
          .firstWhere((element) => element.id == barrio.zona['id']);
      loading.value = false;
    });
  }

  editbarrio() async {
    if (formkey.currentState!.validate()) {
      barrio.nombre = nombre.value;
      barrio.zona = {'id': editzona!.id, 'zona': editzona!.nombre};

      await barrioService.updatebarrio(barrio);

      Get.back();
    }
  }
}
