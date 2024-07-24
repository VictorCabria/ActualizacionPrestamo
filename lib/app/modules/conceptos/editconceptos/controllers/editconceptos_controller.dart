// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../models/concepto_model.dart';
import '../../../../models/naturaleza.dart';
import '../../../../models/tipoconcepto.dart';
import '../../../../services/model_services/conceptos_service.dart';

class EditconceptosController extends GetxController {
  final formkey = GlobalKey<FormState>();
  RxList<TipoConcepto> edittipocontroller = RxList<TipoConcepto>([]);
  RxList<Naturaleza> naturalezacontroller = RxList<Naturaleza>([]);
  Naturaleza? editnaturaleza;
  TipoConcepto? edittipo;
  RxBool loading = false.obs;
  late Stream<List<TipoConcepto>> tipoconceptotream;
  late Stream<List<Naturaleza>> naturalezatream;

  late Concepto concepto;
  final nombre = "".obs;
  RxBool tipotransaccion = false.obs;

  @override
  void onInit() {
    concepto = Get.arguments['concepto'];
    nombre.value = concepto.nombre!;
    edittipo = TipoConcepto.fromDinamic(concepto.tipoconcepto);
    editnaturaleza = Naturaleza.fromDinamic(concepto.naturaleza);
    tipotransaccion.value = concepto.conceptotransaccion!;

    tipoconceptotream = gettipoconcepto();
    naturalezatream = getnaturaleza();
    init();
    super.onInit();
  }

  void onChangeDorpdown(String? tipoconcepto) {
    edittipo = edittipocontroller.value
        .firstWhere((element) => element.id == tipoconcepto);
  }

  void onChangeDorpdownnaturaleza(String? naturaleza) {
    editnaturaleza = naturalezacontroller.value
        .firstWhere((element) => element.id == naturaleza);
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
    tipoconceptotream.listen((event) async {
      edittipocontroller.value = event;
      edittipo = edittipocontroller
          .firstWhere((element) => element.id == concepto.tipoconcepto['id']);
    });
    naturalezatream.listen((event) async {
      naturalezacontroller.value = event;
      editnaturaleza = naturalezacontroller
          .firstWhere((element) => element.id == concepto.naturaleza['id']);
    });
  }

  editconcepto() async {
    if (formkey.currentState!.validate()) {
      concepto.nombre = nombre.value;
      concepto.tipoconcepto = {'id': edittipo!.id, 'tipo': edittipo!.nombre};
      concepto.naturaleza = {
        'id': editnaturaleza!.id,
        'naturaleza': editnaturaleza!.tipo
      };
      concepto.conceptotransaccion = tipotransaccion.value;

      await conceptoService.updateconcepto(concepto);

      Get.back();
    }
  }
}
