// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/services/model_services/barrio_service.dart';

import '../../../../services/model_services/client_service.dart';

class EditclientController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  RxList<Barrio> barriocontroller = RxList<Barrio>([]);
  Barrio? selectbarrio;
  late Stream<List<Barrio>> barrioStream;
  late TabController tabController;
  late Client client;
  final nombre = "".obs;
  final email = "".obs;
  final apodo = "".obs;
  final cedula = "".obs;
  final direccion = "".obs;
  final telefono = "".obs;
  final recorrido = "".obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    client = Get.arguments['clients'];
    nombre.value = client.nombre!;
    email.value = client.correo!;
    apodo.value = client.apodo!;
    cedula.value = client.cedula!;
    direccion.value = client.direccion!;
    telefono.value = client.telefono!;
    recorrido.value = client.recorrido!;
    selectbarrio = Barrio.fromDinamic(client.barrio);
    barrioStream = getbarrios();
    init();
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  getbarrios() => barrioService
      .obtenerlistbarrios()
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  init() {
    barrioStream.listen((event) async {
      barriocontroller.value = event;
      selectbarrio = barriocontroller
          .firstWhere((element) => element.id == client.barrio['id']);
    });
  }

  onChangeDorpdown(String? barrio) {
    selectbarrio =
        barriocontroller.value.firstWhere((element) => element.id == barrio);
  }

  editclient() async {
    if (formkey.currentState!.validate()) {
      client.apodo = apodo.value;
      client.barrio = {'id': selectbarrio!.id, 'zona': selectbarrio!.nombre};
      client.cedula = cedula.value;
      client.recorrido = recorrido.value;
      client.correo = email.value;
      client.direccion = direccion.value;
      client.nombre = nombre.value;
      client.telefono = telefono.value;
      await clientService.updateclient(client);

      Get.back();
    }
  }
}
