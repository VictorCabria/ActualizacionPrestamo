import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../models/concepto_model.dart';
import '../../../../models/transaction_model.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/conceptos_service.dart';
import '../../../../services/model_services/transacciones_service.dart';

class EdittransaccionesController extends GetxController {
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradores2Stream;
  Cobradores? selectcobradores;
  final formkey = GlobalKey<FormState>();
  RxList<Concepto> conceptocontroller = RxList<Concepto>([]);
  late Stream<List<Concepto>> conceptoStream;
  Concepto? selectconcepto;
  final fecha = "".obs;
  final detalle = "".obs;
  final valor = 0.0.obs;
  final debitoocredito = 0.0.obs;
  Transacciones? transacciones;
  Concepto? concepto;
  Cobradores? cobrador;
  late TextEditingController fromDateControler2;
  DateTime selectedDate2 = DateTime.now();

  final listaconcepto = [].obs;
  final listcobradores = [].obs;

  @override
  void onInit() {
    transacciones = Get.arguments['transacciones'];
    fecha.value = transacciones!.fecha!;
    fromDateControler2 = TextEditingController(text: transacciones!.fecha!);

    valor.value = transacciones!.valor!;
    conceptoStream = getconcepto();
    cobradores2Stream = getcobradores();
    init();
    super.onInit();
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
      selectconcepto = conceptocontroller
          .firstWhere((element) => element.id == transacciones!.concept);
    });
    cobradores2Stream.listen((event) async {
      cobradorescontroller.value = event;
      selectcobradores = cobradorescontroller
          .firstWhere((element) => element.id == transacciones!.cobrador);
    });
  }

  void onChangeDorpdowncobradores(String? cobradores) {
    selectcobradores =
        cobradorescontroller.firstWhere((element) => element.id == cobradores);
  }

  void onChangeDorpdown(String? concepto) {
    selectconcepto =
        conceptocontroller.firstWhere((element) => element.id == concepto);
  }

  /*  void getajustesinicial() async {
    try {
      var res = await transaccionesService.gettransacciones();
      if (res != null) {
        transacciones = res;
        concepto =
            listaconcepto.where((p0) => p0.id == transacciones!.concept).first;
        cobrador = listcobradores
            .where((p0) => p0.id == transacciones!.cobrador)
            .first;
      }
    } catch (error) {
      print(error);
    }
  } */

  edittransacciones() async {
    if (formkey.currentState!.validate()) {
      transacciones!.fecha = fromDateControler2.text;
      transacciones!.concept = selectconcepto!.id;
      transacciones!.valor = valor.value;
      transacciones!.cobrador = selectcobradores!.id;
      transacciones!.detalles = detalle.value;

      await transaccionesService.updatetransacciones(transacciones!);

      Get.back();
    }
  }

  monto() {
    if (selectconcepto!.naturaleza["naturaleza"] == "Debito") {
      print(debitoocredito.value + valor.value);
      debitoocredito.value + valor.value;
    } else {
      debitoocredito.value - valor.value;
      print(debitoocredito.value - valor.value);
    }
  }
}
