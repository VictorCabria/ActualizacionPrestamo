import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/tipoprestamo.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';

import '../../../../services/model_services/tipoprestamo_service.dart';

class RegistrarprestamosController extends GetxController {
  final formkey = GlobalKey<FormState>();
  late TextEditingController nombresController,
      mesescontroller,
      cuotascontroller,
      porcentajecontroller;

  final porcentaje = 0.0.obs;
  final meses = 0.obs;
  final cuota = 0.obs;
  /*  String nombre = '${((meses.value.toString()) + cuota.value.toString())};'; */

  RxList<TipoPrestamos> tipoprestamocontroller = RxList<TipoPrestamos>([]);
  late Stream<List<TipoPrestamos>> prestamoStream;
  late TipoPrestamos selectprestamo;
  @override
  void onInit() {
    super.onInit();
    porcentajecontroller = TextEditingController();
    mesescontroller = TextEditingController();
    cuotascontroller = TextEditingController();
    prestamoStream = getprestamo();
    init();
  }

  getprestamo() => typePrestamoService.obtenerlistprestamo().snapshots().map(
      (event) => event.docs.map((e) => TipoPrestamos.fromJson(e)).toList());

  init() {
    prestamoStream.listen((event) async {
      tipoprestamocontroller.value = event;
    });
  }

  void onChangeDorpdown(TipoPrestamos? tipoprestamo) {
    selectprestamo = tipoprestamo!;
  }

  addprestamos() async {
    TypePrestamo prestamo = TypePrestamo(
        tipo: {'id': selectprestamo.id, 'tipo': selectprestamo.tipo},
        porcentaje: porcentaje.value,
        meses: meses.value,
        cuotas: cuota.value,
        nombre: (selectprestamo.tipo)! +
            (cuota.value == 0
                ? ""
                : (''' ${cuota.value.toString()} cuotas''')) +
            (porcentaje.value == 0
                ? ""
                : (''' [${porcentaje.value.toString()}%]''')) +
            (meses.value == 0
                ? ""
                : (''' ${meses.value.toString()} mes(es)''')));

    try {
      var status = formkey.currentState!.validate();
      if (status) {
        await typePrestamoService.saveprestamo(typeprestamo: prestamo);
        Get.back();
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
