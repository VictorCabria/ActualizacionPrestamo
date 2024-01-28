// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/services/model_services/transacciones_service.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:prestamo_mc/app/utils/references.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/session_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class ListacobradoresController extends GetxController {
  RxList<Cobradores> cobradores = RxList<Cobradores>([]);
  RxList<Cobradores> consulta = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradoresStream;
  final homeControll = Get.find<HomeController>();
  List<Cobradores> get cobradoresget => cobradores;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  RxList<Cobradores> selectedItem = RxList();
  Cobradores? cobrador;
  final valorInicial = 0.0.obs;
  String hoy = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  @override
  void onInit() {
    cobradoresStream = getcobradores();
    super.onInit();
    init();
  }

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .orderBy("nombre")
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  init() {
    cobradoresStream.listen((event) async {
      cobradores.value = event;
      consulta.value = event;
      searching('');
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      cobradores.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      cobradores.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      cobradores.value = consulta;
    }
  }

  void doMultiSelection(Cobradores cobrador) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(cobrador)) {
        selectedItem.remove(cobrador);
      } else {
        selectedItem.add(cobrador);
      }
    } else {
      detallecobradores(cobrador);
    }
  }

  detallecobradores(Cobradores cobrador) {
    Get.toNamed(Routes.VENTANASSEGUIMIENTOCOBRADORES,
        arguments: {firebaseReferences.cobradores: cobrador});
  }

  String getSelectedcobradores() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  /* activarsessiones(Cobradores cobrador)async{
    var res = await sessionService.createSession(
          object: Session.nueva(hoy, cobrador.id, valorInicial.value,
                  cobrador., homeControll.sessionAnterior)
              .toJson());
  } */

  editarcobrador(Cobradores cobrador) {
    Get.toNamed(Routes.EDITCOBRADORES,
        arguments: {firebaseReferences.cobradores: cobrador});
  }

  delete() async {
    selectedItem.forEach((element) async {
      var listado = await transaccionesService
          .obtenerlisttransacciones()
          .where("cobrador.id", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        cobradoresService.deletecobradores(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este cobrador no puede ser borrado porque esta siendo ocupado para transacciones"),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.primary)),
                child: Text("Aceptar"),
                onPressed: () {
                  Get.back();
                }),
          ],
        ));
      }
    });
  }
}
