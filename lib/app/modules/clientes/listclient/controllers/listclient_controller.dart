import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/services/model_services/client_service.dart';
import 'package:prestamo_mc/app/services/model_services/prestamo_service.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:prestamo_mc/app/utils/references.dart';

class ListclientController extends GetxController {
  RxList<Client> clientes = RxList<Client>([]);
  RxList<Client> consulta = RxList<Client>([]);
  late Stream<List<Client>> clientesStream;
  List<Client> get clienteget => clientes;
  RxBool isBuscar = false.obs;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxList<Client> selectedItem = RxList();

  @override
  void onInit() {
    clientesStream = getclient();
    super.onInit();
    init();
  }

  getclient() => clientService
      .obtenerlist()
      .orderBy('recorrido')
      .snapshots()
      .map((event) => event.docs
          .map((e) => Client.fromJson(e.data() as Map<String, dynamic>))
          .toList());

  init() {
    clientesStream.listen((event) async {
      clientes.value = event;
      consulta.value = event;
      searching('');
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      clientes.value = consulta;
    }
  }

  searching(String texto) {
    if (texto != '') {
      clientes.value = consulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      clientes.value = consulta;
    }
  }

  void doMultiSelection(Client client) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(client)) {
        selectedItem.remove(client);
      } else {
        selectedItem.add(client);
      }
    } else {
      editarcliente(client);
    }
  }

  String getSelectedUsers() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  editarcliente(Client client) {
    Get.toNamed(Routes.EDITCLIENT,
        arguments: {firebaseReferences.client: client});
  }

  void listnegra() {
    for (var i = 0; i < selectedItem.length; i++) {
      if (selectedItem[i].listanegra == true) {
        Get.dialog(AlertDialog(
          content: Text(
              "El cliente ${selectedItem[i].nombre} ya pertenece a la lista negra"),
        ));
      } else {
        selectedItem[i].listanegra = true;
        clientService.updateclient(selectedItem[i]);
      }
    }
    selectedItem.clear();
  }

  delete() async {
    /*   for (var i in selectedItem) {
      clientService.deleteclient(i);
    } */
    selectedItem.forEach((element) async {
      var listado = await prestamoService
          .obtenerlistprestamo()
          .where("cliente", isEqualTo: element.id!)
          .get();

      if (listado.docs.isEmpty) {
        clientService.deleteclient(element.id);
      } else {
        Get.dialog(AlertDialog(
          content: const Text(
              "Este cliente no puede ser borrado porque esta siendo ocupado para prestamos"),
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
