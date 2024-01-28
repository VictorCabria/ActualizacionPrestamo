import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/zone_model.dart';
import 'package:prestamo_mc/app/services/model_services/zona_service.dart';

class EditzoneController extends GetxController {
  //TODO: Implement EditzoneController
final nombre = "".obs;
final formkey = GlobalKey<FormState>();
late Zone zone;
  @override
  void onInit() {
    zone = Get.arguments['zona'];

    nombre.value = zone.nombre!;
    super.onInit();
  }

editbzone() async {
    if (formkey.currentState!.validate()) {
      zone.nombre = nombre.value;
     

      await zonaService.updatezona(zone);

      Get.back();
    }
  }
}
  



