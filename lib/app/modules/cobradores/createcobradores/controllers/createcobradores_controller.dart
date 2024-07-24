import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/barrio_modal.dart';
import '../../../../models/cedula_modal.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../services/firebase_services/auth_services.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/cobradores_service.dart';


class CreatecobradoresController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  late TabController tabController;

  late TextEditingController nombresController,
      apellidocontroller,
      emailcontroller,
      telefonocontroller,
      cedulacontroller,
      direccioncontroller,
      correocontroller,
      pincontroller,
      celularcontroller;
  RxList<Cedula> cedulalistcontroller = RxList<Cedula>([]);
  late Stream<List<Cedula>> cedulaStream;
  Cedula? selectcedula;
  RxList<Barrio> barriocontroller = RxList<Barrio>([]);
  late Stream<List<Barrio>> barrioStream;
  Barrio? selectbarrio;
  RxBool admincobrador = false.obs;

  @override
  void onInit() {
    cedulaStream = getcobradores();
    barrioStream = getbarrios();
    init();
    nombresController = TextEditingController();
    apellidocontroller = TextEditingController();
    emailcontroller = TextEditingController();
    telefonocontroller = TextEditingController();
    cedulacontroller = TextEditingController();
    pincontroller = TextEditingController();
    direccioncontroller = TextEditingController();
    correocontroller = TextEditingController();
    celularcontroller = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  getcobradores() => cobradoresService
      .obtenerlisttipocedula()
      .snapshots()
      .map((event) => event.docs.map((e) => Cedula.fromJson(e)).toList());

  init() {
    cedulaStream.listen((event) async {
      cedulalistcontroller.value = event;
    });
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

  String? validateEmailedit(String value) {
    if (value.isEmpty) {
      return ("Campo requerido");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+.-]+.[a-z]").hasMatch(value)) {
      return ("Ingrese un correo valido");
    }
    return null;
  }

  void onChangeDorpdown(Cedula? cedula) {
    selectcedula = cedula!;
  }

  getbarrios() => barrioService
      .obtenerlistbarrios()
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  void onChangeDorpdown2(Barrio? barrio) {
    selectbarrio = barrio!;
  }

  addcobradores() async {
    try {
      formkey.currentState!.validate();
      if (nombresController.text != '' &&
          correocontroller.text != '' &&
          pincontroller.text != '') {
        var response =
            await auth.signUp(correocontroller.text, nombresController.text);
        if (response != null) {
          auth.postDetailsToFirestore(
              nombresController.text, admincobrador.value);
          Cobradores cobradores = Cobradores(
              id: response.uid,
              nombre: nombresController.text,
              correo: correocontroller.text,
              pin: pincontroller.text,
              tipocedula: {
                'id': selectcedula?.id,
                'cedula': selectcedula?.cedula
              },
              cedula: cedulacontroller.text,
              apellido: apellidocontroller.text,
              direccion: direccioncontroller.text,
              barrio: {'id': selectbarrio?.id, 'barrio': selectbarrio?.nombre},
              telefono: telefonocontroller.text,
              celula: celularcontroller.text);

          await cobradoresService.savecobradores(cobradores: cobradores);
          Get.back();
        }
      } else {
        tabController.animateTo(0);
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
/* 
    Cobradores cobradores = Cobradores(
        nombre: nombresController.text,
        correo: correocontroller.text,
        pin: pincontroller.text,
        tipocedula: {'id': selectcedula?.id, 'cedula': selectcedula?.cedula},
        cedula: cedulacontroller.text,
        apellido: apellidocontroller.text,
        direccion: direccioncontroller.text,
        barrio: {'id': selectbarrio?.id, 'barrio': selectbarrio?.nombre},
        telefono: telefonocontroller.text,
        celula: celularcontroller.text);

    try {
      // var status = formkey.currentState!.validate();
      formkey.currentState!.validate();
      if (nombresController.text != '' &&
          correocontroller.text != '' &&
          pincontroller.text != '') {
        await cobradoresService.savecobradores(cobradores: cobradores);
        Get.back();
      } else {
        tabController.animateTo(0);
      }
    } on Exception catch (e) {
      return 'Error $e';
    }
  } */
  }
}
