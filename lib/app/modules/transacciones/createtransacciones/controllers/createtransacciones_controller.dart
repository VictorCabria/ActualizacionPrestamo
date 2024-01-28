
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/models/concepto_model.dart';
import 'package:prestamo_mc/app/models/transaction_model.dart';
import 'package:prestamo_mc/app/modules/principal/home/controllers/home_controller.dart';
import 'package:prestamo_mc/app/services/model_services/cobradores_service.dart';
import 'package:prestamo_mc/app/services/model_services/conceptos_service.dart';
import 'package:intl/intl.dart';

import '../../../../services/model_services/transacciones_service.dart';

class CreatetransaccionesController extends GetxController {
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  final formkey = GlobalKey<FormState>();
  late TextEditingController detallescontroller;
  RxBool isloading = false.obs;
  final homeControll = Get.find<HomeController>();
  RxList<Concepto> conceptocontroller = RxList<Concepto>([]);
  late Stream<List<Concepto>> conceptoStream;
  Concepto? selectconcepto;
  final valor = 0.0.obs;
  final debitoocredito = 0.0.obs;
  final total = 0.0.obs;
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradores2Stream;
  Cobradores? selectobradores;
  @override
  void onInit() {
    super.onInit();
    conceptoStream = getconcepto();
    cobradores2Stream = getcobradores();
    detallescontroller = TextEditingController();

    init();
  }

  getconcepto() => conceptoService
      .obtenerlistconceptos()
      .snapshots()
      .map((event) => event.docs.map((e) => Concepto.fromJson(e)).toList());

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  init() {
    conceptoStream.listen((event) async {
      conceptocontroller.value = event;
    });
    cobradores2Stream.listen((event) async {
      cobradorescontroller.value = event;
    });
  }

  void onChangeDorpdowncobradores(Cobradores? cobradores) {
    selectobradores = cobradores!;
  }

  void onChangeDorpdown(Concepto? concepto) {
    selectconcepto = concepto!;
  }

  void addtransacciones() async {
    if (selectconcepto!.naturaleza["naturaleza"] == "Debito") {
      total.value = debitoocredito.value + valor.value;
    } else {
      total.value = debitoocredito.value - valor.value;
    }
    Transacciones transacciones = Transacciones(
        fecha: fecha.value,
        idSession: homeControll.session!.id,
        concept: selectconcepto!.id,
        valor: valor.value,
        tiponaturaleza: total.value,
        cobrador: selectobradores!.id,
        detalles: detallescontroller.text);

    if (formkey.currentState!.validate()) {
      var response =
          await transaccionesService.savetransacciones(transacciones);
      transacciones.id = response;

      Get.back(result: transacciones);
    } else {
      print("no validado");
    }
  }

/*   monto() {
    if (selectconcepto!.naturaleza == "Debito") {
      debitoocredito.value + valor.value;
    } else {
      debitoocredito.value - valor.value;
    }
  }
} */
}
