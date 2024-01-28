import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/ajustes_modal.dart';
import 'package:prestamo_mc/app/models/concepto_model.dart';
import 'package:prestamo_mc/app/modules/principal/home/controllers/home_controller.dart';
import 'package:prestamo_mc/app/services/model_services/ajustes_service.dart';
import 'package:prestamo_mc/app/services/model_services/tipoprestamo_service.dart';

import '../../../../models/type_prestamo_model.dart';
import '../../../../services/model_services/conceptos_service.dart';

class AjustesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<Concepto> conceptocontroller = RxList<Concepto>([]);
  late Stream<List<Concepto>> conceptoStream;
  Concepto? selectconcepto;
  Concepto? selectpositiva;
  Concepto? selectnegativa;
  Concepto? selectrefinanciacoon;
  Ajustes? ajustes;
  RxList<TypePrestamo> tipoPrestamoscontroller = RxList<TypePrestamo>([]);
  late Stream<List<TypePrestamo>> tipoPrestamosStream;
  TypePrestamo? selecttipoPrestamos;
  final homeControll = Get.find<HomeController>();
  final formkey = GlobalKey<FormState>();
  late TabController tabController;
  final monto = 0.0.obs;
  final refinacion = 0.obs;
  final diasprimercobro = 0.obs;
  RxBool cobrarsabado = false.obs;
  RxBool cobrardomingo = false.obs;

  @override
  void onInit() async {
    tabController = TabController(length: 3, vsync: this);
    conceptoStream = getconcepto();
    tipoPrestamosStream = gettipoprestamo();

    init();
    super.onInit();

    getajustesinicial();
    update(
        ['tipoprestamo', 'concepto', 'positivo', 'negativo', 'refinanciacion']);
  }

  getconcepto() => conceptoService
      .obtenerlistconceptos()
      .snapshots()
      .map((event) => event.docs.map((e) => Concepto.fromJson(e)).toList());

  gettipoprestamo() => typePrestamoService
      .obtenerlistprestamo2()
      .snapshots()
      .map((event) => event.docs.map((e) => TypePrestamo.fromJson(e)).toList());

  init() {
    conceptoStream.listen((event) async {
      conceptocontroller.value = event;
    });
    tipoPrestamosStream.listen((event) async {
      tipoPrestamoscontroller.value = event;
    });
  }

  void onChangeDorpdown(Concepto? concepto) {
    selectconcepto = concepto!;
  }

  void onChangerefinanciacion(Concepto? refinaciar) {
    selectrefinanciacoon = refinaciar!;
  }

  void onChangeDorpdowntipo(TypePrestamo? tipoprestamos) {
    selecttipoPrestamos = tipoprestamos!;
  }

  void onChangepositiva(Concepto? tipoprestamos2) {
    selectpositiva = tipoprestamos2!;
  }

  void onChangenegativa(Concepto? tipoprestamos3) {
    selectnegativa = tipoprestamos3!;
  }

  void getajustesinicial() async {
    try {
      var res = await ajustesservice.getajustes();
      if (res != null) {
        ajustes = res;
        selecttipoPrestamos = tipoPrestamoscontroller
            .where((p0) => p0.id == ajustes!.tipoprestamoid)
            .first;
        selectconcepto = conceptocontroller
            .where((p0) => p0.id == ajustes!.conceptoid)
            .first;
        selectpositiva =
            conceptocontroller.where((p0) => p0.id == ajustes!.positivo).first;
        selectnegativa =
            conceptocontroller.where((p0) => p0.id == ajustes!.negativo).first;

        selectrefinanciacoon = conceptocontroller
            .where((p0) => p0.id == ajustes!.refinanciacion)
            .first;
        monto.value = ajustes!.monto!;
        refinacion.value = ajustes!.diasrefinanciacion!;
        diasprimercobro.value = ajustes!.diasparacobro!;
        cobrarsabado.value = ajustes!.cobrarsabados!;
        cobrardomingo.value = ajustes!.cobrardomingos!;

        update([
          'tipoprestamo',
          'concepto',
          'positivo',
          'negativo',
          'refinanciacion'
        ]);
      }
    } catch (error) {
      print(error);
    }
  }

  editajustes() async {
    if (formkey.currentState!.validate()) {
      /* Ajustes ajustes = Ajustes(
        monto: monto.value,
        conceptoid: selectconcepto!.id,
        positivo: selectpositiva!.id,
        negativo: selectnegativa!.id,
        diasparacobro: diasprimercobro.value,
        cobrarsabados: cobrarsabado.value,
        cobrardomingos: cobrardomingo.value,
        tipoprestamoid: selecttipoPrestamos!.id,
        refinanciacion: selectrefinanciacoon!.id,
        diasrefinanciacion: refinacion.value,
      );
      await ajustesservice.saveajustes(ajustes: ajustes); */
      ajustes!.monto = monto.value;
      ajustes!.conceptoid = selectconcepto!.id;
      ajustes!.positivo = selectpositiva!.id;
      ajustes!.negativo = selectnegativa!.id;
      ajustes!.diasparacobro = diasprimercobro.value;
      ajustes!.cobrarsabados = cobrarsabado.value;
      ajustes!.cobrardomingos = cobrardomingo.value;
      ajustes!.tipoprestamoid = selecttipoPrestamos!.id;
      ajustes!.refinanciacion = selectrefinanciacoon!.id;
      ajustes!.diasrefinanciacion = refinacion.value;
      await ajustesservice.updateajustes(ajustes!);

      Get.back();
    }
  }
}
