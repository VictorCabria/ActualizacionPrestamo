import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/diasnocobro_modal.dart';
import '../../../../services/model_services/diascobro_service.dart';

class DiasdenocobroController extends GetxController {
  final formkey = GlobalKey<FormState>();
  Diasnocobro? diasnocobro;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);
  List<Diasnocobro> get diasnocobrosget => diasnocobros;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxBool isloading = false.obs;
  RxBool isMultiSelectionEnabled = false.obs;
  RxList<Diasnocobro> selectedItem = RxList();

  @override
  void onInit() {
    diasnocobroStream = getnocobros();
    init();
    super.onInit();
  }

  getnocobros() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  init() {
    diasnocobroStream.listen((event) async {
      diasnocobros.value = event;
    });
  }

  String getSelecteddiasnocobro() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  void doMultiSelection(Diasnocobro diasnocobro) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(diasnocobro)) {
        selectedItem.remove(diasnocobro);
      } else {
        selectedItem.add(diasnocobro);
      }
    }
  }

  delete() async {
    for (var i in selectedItem) {
      diasnocobroServiceService.deletediasnocobro(i);
    }
  }
}
