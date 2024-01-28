import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/naturaleza.dart';
import 'package:prestamo_mc/app/models/tipoconcepto.dart';
import 'package:prestamo_mc/app/services/model_services/conceptos_service.dart';

import '../../../../models/concepto_model.dart';

import '../../../../services/model_services/conceptos_service.dart';

class CreateconceptosController extends GetxController {
  final formkey = GlobalKey<FormState>();
  late TextEditingController nombreconceptocontroller;
  RxList<TipoConcepto> tipoconceptocontroller = RxList<TipoConcepto>([]);
   TipoConcepto? selecttipoconcepto;
  late Stream<List<TipoConcepto>> tipoconceptoStream;
  RxList<Naturaleza> naturalezaconceptocontroller = RxList<Naturaleza>([]);
   Naturaleza? naturalezaconcepto;
  late Stream<List<Naturaleza>> naturalezaStream;
  RxBool tipotransaccion = false.obs;
  @override
  void onInit() {
    if (kDebugMode) {
      print(tipoconceptocontroller);
    }
    super.onInit();
    tipoconceptoStream = gettipoconcepto();
    naturalezaStream = getnaturaleza();
    init();
    nombreconceptocontroller = TextEditingController();
  }

  gettipoconcepto() => conceptoService
      .obtenerlisttipoconcepto()
      .snapshots()
      .map((event) => event.docs.map((e) => TipoConcepto.fromJson(e)).toList());

  getnaturaleza() => conceptoService
      .obtenerlistnaturaleza()
      .snapshots()
      .map((event) => event.docs.map((e) => Naturaleza.fromJson(e)).toList());

  init() {
    tipoconceptoStream.listen((event) async {
      tipoconceptocontroller.value = event;
    });
    naturalezaStream.listen((event) async {
      naturalezaconceptocontroller.value = event;
    });
  }

  void onChangeDorpdown(TipoConcepto? zone) {
    selecttipoconcepto = zone!;
  }

  void onChangeDorpdownnaturaleza(Naturaleza? naturaleza) {
    naturalezaconcepto = naturaleza!;
  }

  addconcepto() async {
    Concepto concepto = Concepto(
        nombre: nombreconceptocontroller.text,
        tipoconcepto: {
          'id': selecttipoconcepto?.id,
          'tipo': selecttipoconcepto?.nombre
        },
        naturaleza: {
          'id': naturalezaconcepto?.id,
          'naturaleza': naturalezaconcepto?.tipo
        },
        conceptotransaccion: tipotransaccion.value);

    try {
      var status = formkey.currentState!.validate();
      if (nombreconceptocontroller.text != '') {
        await conceptoService.saveconcepto(concepto: concepto);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
