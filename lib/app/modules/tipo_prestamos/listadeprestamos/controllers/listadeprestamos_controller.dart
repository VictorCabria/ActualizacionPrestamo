import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/references.dart';

class ListadeprestamosController extends GetxController {
  RxList<TypePrestamo> prestamo = RxList<TypePrestamo>([]);
  RxList<TypePrestamo> consulta = RxList<TypePrestamo>([]);
  late Stream<List<TypePrestamo>> prestamoStream;
  List<TypePrestamo> get prestamoget => prestamo;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  RxList<TypePrestamo> selectedItem = RxList();
  @override
  void onInit() {
    prestamoStream = getprestamo();
    super.onInit();
    init();
  }

  getprestamo() => typePrestamoService
      .obtenerlistprestamo2()
      .snapshots()
      .map((event) => event.docs.map((e) => TypePrestamo.fromJson(e)).toList());

  init() {
    prestamoStream.listen((event) async {
      prestamo.value = event;
      consulta.value = event;
      searching('');
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      prestamo.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      prestamo.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      prestamo.value = consulta;
    }
  }

  String getSelectedbarrios() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  void doMultiSelection(TypePrestamo prestamo) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(prestamo)) {
        selectedItem.remove(prestamo);
      } else {
        selectedItem.add(prestamo);
      }
    } else {
      editarprestamo(prestamo);
    }
  }

  editarprestamo(TypePrestamo prestamo) {
    Get.toNamed(Routes.EDITARPRESTAMOS,
        arguments: {firebaseReferences.prestamosregistrados: prestamo});
  }

  delete() async {
    /* for (var i in selectedItem) {
      typePrestamoService.deleteprestamo(i);
    } */

    selectedItem.forEach((element) async {
      var listado = await prestamoService
          .obtenerlistprestamo()
          .where("tipo_prestamo", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        typePrestamoService.deleteprestamos(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este tipo no puede ser borrado porque esta siendo ocupado para Prestamos"),
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
