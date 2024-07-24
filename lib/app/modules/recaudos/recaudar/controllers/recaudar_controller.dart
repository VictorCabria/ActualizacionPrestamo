import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class RecaudarController extends GetxController {
  //TODO: Implement RecaudarController
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  DateTime selectedDate = DateTime.now();
  Prestamo? selectprestamos;
  final homecontroller = Get.find<HomeController>();
  final formkey = GlobalKey<FormState>();
  late TextEditingController recaudocontroller;
  late TextEditingController fromDateControler;
  final monto = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    fromDateControler = TextEditingController(text: fecha.value);
    recaudocontroller = TextEditingController();
  }

  valorseleccionado() async {
    var res = await Get.toNamed(Routes.SEACHPRESTAMOS);
    if (res != null) {
      selectprestamos = res;
      final cliente = await getClientById(selectprestamos!.clienteId!);
      recaudocontroller.text = cliente.nombre;

      print(selectprestamos!.cobradorId);
    }
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }
/* 
  addrecaudar() async {
    print("sesion id ${ homecontroller.session!.id}");
    RecaudoLine recaudar = RecaudoLine(
        fecha: fecha.value,
        monto: monto.value,
        idPrestamo: selectprestamos!.id,
        idRecaudo: '',
        idSession: homecontroller.session!.id);

    try {
      if (formkey.currentState!.validate()) {
        await recaudoService.saveRecaudoLine(lines: [recaudar]);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
} */
}
