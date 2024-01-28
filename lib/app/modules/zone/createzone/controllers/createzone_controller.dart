import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/zone_model.dart';
import 'package:prestamo_mc/app/services/model_services/zona_service.dart';

class CreatezoneController extends GetxController {
  final formkey = GlobalKey<FormState>();
  RxBool isloading = false.obs;

  late TextEditingController nombrezonecontroller;
  @override
  void onInit() {
    super.onInit();

    nombrezonecontroller = TextEditingController();
  }

  String? validateNombre(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  String? validatezone(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  addzone() async {
    Zone zone = Zone(nombre: nombrezonecontroller.text);
    try {
      if (formkey.currentState!.validate()) {
        await zonaService.savezona(zona: zone);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
