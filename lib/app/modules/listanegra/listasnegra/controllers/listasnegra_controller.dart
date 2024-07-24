import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/client_model.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../utils/palette.dart';

class ListasnegraController extends GetxController   with GetSingleTickerProviderStateMixin {
  RxList<Client> clientes = RxList<Client>([]);
  RxList<Client> consulta = RxList<Client>([]);
  late Stream<List<Client>> clientesStream;
  List<Client> get clienteget => clientes;

  final format = DateFormat('yyyy-MM-dd');
final numberFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 1);

  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  RxList<Prestamo> consultarprestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;
  List<Prestamo> get prestamosget => prestamos;

  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isMultiSelectionEnabledprestamo = false.obs;
  RxList<Client> selectedItem = RxList();
  RxList<Prestamo> selectedItemprestamos = RxList();
  RxBool isloading = false.obs;
  final index = 0.obs;
  @override
  void onInit() {
    clientesStream = getclient();
    prestamosStream = getorestamos();
    super.onInit();
    init();
  }

  getclient() => clientService
      .obtenerlist()
      .where('listanegra', isEqualTo: true)
      .snapshots()
      .map((event) => event.docs
          .map((e) => Client.fromJson(e.data() as Map<String, dynamic>))
          .toList());

  getorestamos() => prestamoService
      .obtenerlistprestamo()
      .where('listanegra', isEqualTo: true)
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  init() {
    clientesStream.listen((event) async {
      clientes.value = event;
    });
    prestamosStream.listen((event) async {
      prestamos.value = event;
    });
  }

  void doMultiSelection(Client client) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(client)) {
        selectedItem.remove(client);
      } else {
        selectedItem.add(client);
      }
    }
  }

  void doMultiSelectionprestamos(Prestamo prestamos) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItemprestamos.contains(prestamos)) {
        selectedItemprestamos.remove(prestamos);
      } else {
        selectedItemprestamos.add(prestamos);
      }
    }
  }

  String getSelectedUsers() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  String getSelected() {
    return selectedItemprestamos.isNotEmpty
        ? "${selectedItemprestamos.length}"
        : "";
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  void listnegra(Client cliente) {
    Get.dialog(AlertDialog(
      content: Text("Estas seguro que quieres remover de la lista negra"),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              cliente.listanegra = false;
              clientService.updateclient(cliente);
              Get.back();
            },
            child: const Text("Aceptar")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancelar"))
      ],
    ));
  }

  void listnegraprestamos(Prestamo prestamolista) {
    Get.dialog(AlertDialog(
      content: Text("Estas seguro que quieres remover de la lista negra"),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              prestamolista.listanegra = false;
              prestamoService.updateprestamo(prestamolista);
              Get.back();
            },
            child: const Text("Aceptar")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.primary)),
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancelar"))
      ],
    ));
  }
}
