import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/services/model_services/barrio_service.dart';
import 'package:prestamo_mc/app/services/model_services/client_service.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:prestamo_mc/app/utils/references.dart';

import '../../../../models/zone_model.dart';
import '../../../../services/model_services/zona_service.dart';

class ListbarriosController extends GetxController {
  RxList<Barrio> barrios = RxList<Barrio>([]);
  RxList<Barrio> consulta = RxList<Barrio>([]);
  late Stream<List<Barrio>> barriosStream;
  List<Barrio> get barriosget => barrios;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  RxList<Barrio> selectedItem = RxList();
  RxList<Zone> zona = RxList<Zone>([]);
  RxList<Zone> zonafiltrados = RxList<Zone>([]);
  late Stream<List<Zone>> zonaStream;
  List<Zone> get cobradoresget => zona;

  @override
  void onInit() {
    barriosStream = getbarrios();
    zonaStream = getzonas();
    super.onInit();
    init();
  }

  getzonas() => zonaService
      .obtenerlistzonas()
      .snapshots()
      .map((event) => event.docs.map((e) => Zone.fromJson(e)).toList());

  getbarrios() => barrioService
      .obtenerlistbarrios()
      .orderBy("nombre")
      .snapshots()
      .map((event) => event.docs.map((e) => Barrio.fromJson(e)).toList());

  init() {
    barriosStream.listen((event) async {
      barrios.value = event;
      consulta.value = event;
      searching('');
    });

    zonaStream.listen((event) async {
      zona.value = event;
      zonafiltrados.value = event;
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      barrios.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      barrios.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      barrios.value = consulta;
    }
  }

  void filtrarlist(String name) {
    if (name != "todos") {
      var c = [];
      c.addAll(zonafiltrados.where((p0) => p0.nombre == name).toList());

      barrios.value = consulta.where((barriosconzona) {
        var lista = c.where((p0) {
          return p0.id == barriosconzona.zona['id'];
        });

        if (lista.isEmpty) return false;

        /*      c.clear(); */
        return true;
      }).toList();
    } else {
      barrios.value = consulta.toList();
    }
  }

  String getSelectedbarrios() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  void doMultiSelection(Barrio barrio) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(barrio)) {
        selectedItem.remove(barrio);
      } else {
        selectedItem.add(barrio);
      }
    } else {
      editarbarrio(barrio);
    }
  }

  editarbarrio(Barrio barrio) {
    Get.toNamed(Routes.EDITBARRIOS,
        arguments: {firebaseReferences.barrios: barrio});
  }

  delete() async {
    selectedItem.forEach((element) async {
      var listado = await clientService
          .obtenerlist()
          .where("barrio.id", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        barrioService.deletebarrio(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este barrio no puede ser borrado porque esta siendo ocupado para un cliente"),
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
