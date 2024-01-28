import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/tipoprestamo.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';
import 'package:prestamo_mc/app/services/model_services/tipoprestamo_service.dart';

class EditarprestamosController extends GetxController {
  RxList<TipoPrestamos> tipeprestamocontroller = RxList<TipoPrestamos>([]);
  final formkey = GlobalKey<FormState>();
  TipoPrestamos? editprestamo;
  RxBool loading = false.obs;
  late Stream<List<TipoPrestamos>> tipoprestamoStream;
  late TypePrestamo typeprestamo;
  final porcentaje = 0.0.obs;
  final meses = 0.obs;
  final cuotas = 0.obs;
  TextEditingController porcentajecontroller = TextEditingController();
  TextEditingController mesescontroller = TextEditingController();
  TextEditingController cuotascontroller = TextEditingController();

  @override
  void onInit() {
    typeprestamo = Get.arguments['tipodeprestamo'];
    editprestamo = TipoPrestamos.fromDinamic(typeprestamo.tipo);
    porcentaje.value = typeprestamo.porcentaje!;
    meses.value = typeprestamo.meses!;
    cuotas.value = typeprestamo.cuotas!;

    tipoprestamoStream = getprestamo();
    init();
    super.onInit();
  }

  void onChangeDorpdown(String? tipo) {
    editprestamo =
        tipeprestamocontroller.firstWhere((element) => element.id == tipo);
  }

  getprestamo() => typePrestamoService.obtenerlistprestamo().snapshots().map(
      (event) => event.docs.map((e) => TipoPrestamos.fromJson(e)).toList());
  init() {
    tipoprestamoStream.listen((event) async {
      tipeprestamocontroller.value = event;
      editprestamo = tipeprestamocontroller
          .firstWhere((element) => element.id == typeprestamo.tipo['id']);
      loading.value = false;
    });
  }

  editprestamos() async {
    if (formkey.currentState!.validate()) {
      typeprestamo.tipo = {'id': editprestamo!.id, 'tipo': editprestamo!.tipo};
      typeprestamo.porcentaje = porcentaje.value;
      typeprestamo.meses = meses.value;
      typeprestamo.cuotas = cuotas.value;
      typeprestamo.nombre = (editprestamo!.tipo)! +
          (cuotas.value == 0
              ? ""
              : (''' ${cuotas.value.toString()} cuotas''')) +
          (porcentaje.value == 0
              ? ""
              : (''' [${porcentaje.value.toString()}%]''')) +
          (meses.value == 0 ? "" : (''' ${meses.value.toString()} mes(es)'''));

      await typePrestamoService.updateprestamo(typeprestamo);

      Get.back();
    }
  }
}
