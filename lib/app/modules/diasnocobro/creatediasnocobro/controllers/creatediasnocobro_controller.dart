import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/diasnocobro_modal.dart';

import '../../../../services/model_services/diascobro_service.dart';

class CreatediasnocobroController extends GetxController {
  //TODO: Implement CreatediasnocobroController
  final formkey = GlobalKey<FormState>();
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  @override
  void onInit() {
    super.onInit();
  }

  /* Future selectDate(
      BuildContext context, TextEditingController controller) async {
    var selectedDate = DateTime.now();
    DateFormat formatter = DateFormat('dd MMMM yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      controller.value = TextEditingValue(text: formatter.format(picked));
    }
  } */

  adddiasnocobro() async {
    Diasnocobro diasnocobro = Diasnocobro(dia: fecha.value);
    try {
      var status = formkey.currentState!.validate();
      if (status) {
        await diasnocobroServiceService.savediasnocobro(
            diasnocobro: diasnocobro);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
