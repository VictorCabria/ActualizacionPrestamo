// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/models/cedula_modal.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/cobradores_service.dart';

class EditcobradoresController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  late TabController tabController;
  RxList<Cedula> edittipocedulacontroller = RxList<Cedula>([]);
  RxList<Barrio> edittipobarriocontroller = RxList<Barrio>([]);
  Cedula? editcedula;
  Barrio? editbarrio;
  RxBool loading = false.obs;
  late Stream<List<Cedula>> cedulatream;
  late Stream<List<Barrio>> barriotream;
  late Cobradores cobrador;

  final nombre = "".obs;
  final correo = "".obs;
  final cedula = "".obs;
  final apellido = "".obs;
  final direccion = "".obs;
  final telefono = "".obs;
  final celula = "".obs;
  final pin = "".obs;

  @override
  void onInit() {
    cobrador = Get.arguments['cobradores'];
    nombre.value = cobrador.nombre!;
    correo.value = cobrador.correo!;
    cedula.value = cobrador.cedula!;
    pin.value = cobrador.pin!;
    apellido.value = cobrador.apellido!;
    editbarrio = Barrio.fromDinamic(cobrador.barrio);
    editcedula = Cedula.fromDinamic(cobrador.tipocedula);
    direccion.value = cobrador.direccion!;
    telefono.value = cobrador.telefono!;
    celula.value = cobrador.celula!;
    tabController = TabController(length: 2, vsync: this);
    cedulatream = getcedula();
    barriotream = getbarrio();
    init();
    super.onInit();
  }

  void onChangeDorpdowncedula(String? tipocedula) {
    editcedula = edittipocedulacontroller.value
        .firstWhere((element) => element.id == tipocedula);
  }

  void onChangeDorpdownbarrio(String? barrio) {
    editbarrio = edittipobarriocontroller.value
        .firstWhere((element) => element.id == barrio);
  }

  getcedula() => cobradoresService
      .obtenerlisttipocedula()
      .snapshots()
      .map((event) => event.docs.map((e) => Cedula.fromJson(e)).toList());

  getbarrio() => barrioService
      .obtenerlistbarrios()
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  init() {
    cedulatream.listen((event) async {
      edittipocedulacontroller.value = event;
      editcedula = edittipocedulacontroller
          .firstWhere((element) => element.id == cobrador.tipocedula['id']);
    });
    barriotream.listen((event) async {
      edittipobarriocontroller.value = event;
      editbarrio = edittipobarriocontroller
          .firstWhere((element) => element.id == cobrador.barrio['id']);
    });
  }

  editcobradores() async {
    if (formkey.currentState!.validate()) {
      cobrador.nombre = nombre.value;
      cobrador.correo = correo.value;
      cobrador.pin = pin.value;
      cobrador.tipocedula = {
        'id': editcedula!.id,
        'cedula': editcedula!.cedula
      };
      cobrador.cedula = cedula.value;
      cobrador.apellido = apellido.value;
      cobrador.direccion = direccion.value;
      cobrador.barrio = {'id': editbarrio!.id, 'cedula': editbarrio!.nombre};
      cobrador.telefono = telefono.value;
      cobrador.celula = celula.value;

      await cobradoresService.updatecobrador(cobrador);

      Get.back();
    }
  }
}
