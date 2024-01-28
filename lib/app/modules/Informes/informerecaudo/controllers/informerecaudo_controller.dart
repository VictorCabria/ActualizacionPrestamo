import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:prestamo_mc/app/services/model_services/recaudos_service.dart';

import '../../../../models/recaudo_line_modal.dart';
import '../../../../routes/app_pages.dart';

class InformerecaudoController extends GetxController {
  RxList<RecaudoLine> recaudo = RxList<RecaudoLine>([]);
  RxList<RecaudoLine> consultar = RxList<RecaudoLine>([]);
  RxList<RecaudoLine> recaudosnuevos = RxList<RecaudoLine>([]);
  late Stream<List<RecaudoLine>> recaudoStream;

  final formkey = GlobalKey<FormState>();
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString fechafinal = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  @override
  void onInit() async {
    recaudoStream = getrecaudo();
    init();

    super.onInit();
  }

  getrecaudo() => recaudoService
      .obtenerlistrecaudo()
      .snapshots()
      .map((event) => event.docs.map((e) => RecaudoLine.fromJson(e)).toList());

  init() {
    recaudoStream.listen((event) async {
      recaudo.value = event;
      consultar.value = event;
    });
  }

  metodobusqueda() {
    recaudosnuevos.clear();
    final fechainicio = DateTime.parse(fecha.value);
    final fechaultima = DateTime.parse(fechafinal.value);

    var response = recaudo.value = consultar
        .where((element) =>
            DateTime.parse(element.fecha!).isAtSameMomentAs(fechainicio) ||
            DateTime.parse(element.fecha!).isAfter(fechainicio) &&
                DateTime.parse(element.fecha!).isBefore(fechaultima))
        .toList();

    recaudosnuevos.addAll(response);
    Get.toNamed(Routes.VENTANADEINFORMESRECAUDOS);
  }
}
