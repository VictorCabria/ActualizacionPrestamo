import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/models/client_model.dart';

import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/client_service.dart';

class RegistrarclienteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  late TextEditingController nombresController,
      emaileditController,
      apodocontroller,
      cedulacontroller,
      direccioncontroller,
      telefonocontroller,
      recorridocontroller;
  RxList<Barrio> barriocontroller = RxList<Barrio>([]);
  late Stream<List<Barrio>> barrioStream;
  Barrio? selectbarrio;
  late TabController tabController;

  @override
  void onInit() {
    barrioStream = getbarrios();
    init();
    nombresController = TextEditingController();
    emaileditController = TextEditingController();
    apodocontroller = TextEditingController();
    cedulacontroller = TextEditingController();
    direccioncontroller = TextEditingController();
    telefonocontroller = TextEditingController();
    recorridocontroller = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  getbarrios() => barrioService
      .obtenerlistbarrios()
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  init() {
    barrioStream.listen((event) async {
      barriocontroller.value = event;
    });
  }

  String? validateNombre(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  String? validateapodo(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  String? validatepin(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    return null;
  }

  void onChangeDorpdown(Barrio? barrio) {
    selectbarrio = barrio!;
  }

  addclient() async {
    Client cliente = Client(
        apodo: apodocontroller.text,
        nombre: nombresController.text,
        correo: emaileditController.text,
        listanegra: false,
        cedula: cedulacontroller.text,
        direccion: direccioncontroller.text,
        telefono: telefonocontroller.text,
        recorrido: recorridocontroller.text,
        barrio: {'id': selectbarrio?.id, 'zona': selectbarrio?.nombre});

    try {
      /* var status = formkey.currentState!.validate(); */
      formkey.currentState!.validate();
      if (nombresController.text != '' && recorridocontroller.text != '') {
        await clientService.saveclient(client: cliente);
        Get.back();
      } else {
        tabController.animateTo(0);
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  }
}
