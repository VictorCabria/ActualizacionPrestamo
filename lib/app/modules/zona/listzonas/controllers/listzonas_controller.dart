// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/references.dart';

class ListzonasController extends GetxController {
  RxList<Zone> zonas = RxList<Zone>([]);
  RxBool isBuscar = false.obs;
  RxList<Zone> consulta = RxList<Zone>([]);
  late Stream<List<Zone>> zonasStream;
  List<Zone> get zonasget => zonas;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxList<Zone> selectedItem = RxList();
  @override
  void onInit() {
    zonasStream = getzone();
    super.onInit();
    init();
  }

  getzone() => zonaService
      .obtenerlistzonas()
      .snapshots()
      .map((event) => event.docs.map((e) => Zone.fromJson(e)).toList());

  init() {
    zonasStream.listen((event) async {
      zonas.value = event;
      consulta.value = event;
      searching('');
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      zonas.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      zonas.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      zonas.value = consulta;
    }
  }

  String getSelectedzone() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  void doMultiSelection(Zone zone) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(zone)) {
        selectedItem.remove(zone);
      } else {
        selectedItem.add(zone);
      }
    } else {
      detallezona(zone);
    }
  }

  detallezona(Zone zone) {
    Get.toNamed(Routes.DETALLEZONA, arguments: {firebaseReferences.zona: zone});
    print(zone);
  }

  editarbarrio(Zone zone) {
    Get.toNamed(Routes.EDITZONE, arguments: {firebaseReferences.zona: zone});
  }

  delete() async {
    selectedItem.forEach((element) async {
      var listado = await barrioService
          .obtenerlistbarrios()
          .where("zona.id", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        zonaService.deletezona(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Esta zona no puede ser borrado porque esta siendo ocupado para barrios"),
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
