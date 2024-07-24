import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc_2_0/app/models/concepto_model.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/conceptos_service.dart';
import '../../../../services/model_services/transacciones_service.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/references.dart';


class ListaconceptosController extends GetxController {
  RxList<Concepto> conceptos = RxList<Concepto>([]);
  RxList<Concepto> consulta = RxList<Concepto>([]);
  late Stream<List<Concepto>> conceptosStream;
  List<Concepto> get conceptosget => conceptos;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxList<Concepto> selectedItem = RxList();
  RxBool isBuscar = false.obs;
  @override
  void onInit() {
    conceptosStream = getclient();
    super.onInit();
    init();
  }

  getclient() => conceptoService
      .obtenerlistconceptos()
      .orderBy('nombre')
      .snapshots()
      .map((event) => event.docs.map((e) => Concepto.fromJson(e)).toList());

  init() {
    conceptosStream.listen((event) async {
      conceptos.value = event;
      consulta.value = event;
        searching('');
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      conceptos.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      conceptos.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      conceptos.value = consulta;
    }
  }

  void doMultiSelection(Concepto concept) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(concept)) {
        selectedItem.remove(concept);
      } else {
        selectedItem.add(concept);
      }
    } else {
      editarconcepto(concept);
    }
  }

  String getSelectedUsers() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  editarconcepto(Concepto concepto) {
    Get.toNamed(Routes.EDITCONCEPTOS,
        arguments: {firebaseReferences.concepto: concepto});
  }

  delete() async {
    selectedItem.forEach((element) async {
      var listado = await transaccionesService
          .obtenerlisttransacciones()
          .where("concept.id", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        conceptoService.deleteconcepto(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este concepto no puede ser borrado porque esta siendo ocupado para transacciones"),
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
