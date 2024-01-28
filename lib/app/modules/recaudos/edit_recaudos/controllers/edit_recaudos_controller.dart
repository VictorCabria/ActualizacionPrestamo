import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/services/model_services/barrio_service.dart';

import '../../../../models/recaudo_model.dart';
import '../../../../services/model_services/cobradores_service.dart';

class EditRecaudosController extends GetxController {
  RxList<Barrio> barriocontroller = RxList<Barrio>([]);
  late Stream<List<Barrio>> barrioStream;
  Barrio? selectbarrio;
  final formkey = GlobalKey<FormState>();
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradores2Stream;
  Cobradores? selectcobradores;
  RxBool tipotransaccion = false.obs;
  late Recaudo recaudo;
  final fecha = "".obs;

  @override
  void onInit() {
    recaudo = Get.arguments['recaudos'];
    fecha.value = recaudo.fecha!;
    // selectcobradores = Cobradores.fromDinamic(recaudo.cobradorId);
    // selectbarrio = Barrio.fromDinamic(recaudo.zoneId);
    super.onInit();

    barrioStream = getbarrio();
    cobradores2Stream = getcobradores();
    init();
  }

  getbarrio() => barrioService
      .obtenerlistbarrios()
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  init() {
    barrioStream.listen((event) async {
      barriocontroller.value = event;
      selectbarrio = barriocontroller
          .firstWhere((element) => element.id == recaudo.zoneId);
    });
    cobradores2Stream.listen((event) async {
      cobradorescontroller.value = event;
      selectcobradores = cobradorescontroller
          .firstWhere((element) => element.id == recaudo.cobradorId);
    });
  }

  void onChangeDorpdowncobradores(String? cobradores) {
    selectcobradores =
        cobradorescontroller.firstWhere((element) => element.id == cobradores);
  }

  void onChangeDorpdown(String? barrio) {
    selectbarrio =
        barriocontroller.firstWhere((element) => element.id == barrio);
  }

  
}
