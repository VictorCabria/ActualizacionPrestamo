import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/barrio_modal.dart';
import '../../../../models/zone_model.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/zona_service.dart';

class CreatebarriosController extends GetxController {
  final formkey = GlobalKey<FormState>();
  RxList<Zone> zonecontroller = RxList<Zone>([]);
  RxBool isloading = false.obs;
  late Stream<List<Zone>> zoneStream;
  late Zone selectzona;

  late TextEditingController nombrecontroller;
  final selezona = "".obs;
  @override
  void onInit() {
    super.onInit();

    zoneStream = getzone();
    init();
    nombrecontroller = TextEditingController();
  }

  getzone() => zonaService
      .obtenerlistzonas()
      .snapshots()
      .map((event) => event.docs.map((e) => Zone.fromJson(e)).toList());
  init() {
    zoneStream.listen((event) async {
      zonecontroller.value = event;
    });
  }

  void onChangeDorpdown(Zone? zone) {
    selectzona = zone!;
  }

  String? validateNombre(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  String? validatebarrios(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  addbarrios() async {
    Barrio barrio = Barrio(
        nombre: nombrecontroller.text,
        zona: {'id': selectzona.id, 'zona': selectzona.nombre});

    try {
      var status = formkey.currentState!.validate();
      if (nombrecontroller.text != '' && status) {
        await barrioService.savebarrio(barrio: barrio);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
