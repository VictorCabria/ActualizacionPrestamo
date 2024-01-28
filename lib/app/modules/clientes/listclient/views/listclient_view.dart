import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import '../controllers/listclient_controller.dart';

class ListclientView extends GetView<ListclientController> {
  const ListclientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.isBuscar.value
                ? CustomSearch(controller: controller)
                : Text(controller.isMultiSelectionEnabled.value
                    ? controller.getSelectedUsers()
                    : "Clientes" " ${controller.clientes.length}"),
            actions: <Widget>[
              controller.isBuscar.value
                  ? IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.cancel))
                  : IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.search)),
              Visibility(
                visible: controller.selectedItem.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  "Estas seguro que quieres borrar este usuario"),
                              content: const Text(
                                  "esta accion no se puede deshacer"),
                              actions: <Widget>[
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Palette.primary)),
                                    child: const Text("Aceptar"),
                                    onPressed: () {
                                      controller.delete();
                                      controller.selectedItem.clear();
                                      Get.back();
                                    }),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Palette.primary)),
                                    child: const Text("Cancelar"),
                                    onPressed: () {
                                      Get.back();
                                    })
                              ],
                            ));
                  },
                ),
              ),
              Visibility(
                visible: controller.selectedItem.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.list_alt),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  "Estas seguro que quieres añadir este cliente a la lista negra"),
                              actions: <Widget>[
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Palette.primary)),
                                    child: const Text("Aceptar"),
                                    onPressed: () {
                                      controller.listnegra();
                                      Get.back();
                                    }),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Palette.primary)),
                                    child: const Text("Cancelar"),
                                    onPressed: () {
                                      Get.back();
                                    })
                              ],
                            ));
                  },
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: Palette.primary,
            leading: controller.isMultiSelectionEnabled.value
                ? CustomMultiselector(controller: controller)
                : BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
          ),
          body: GetX<ListclientController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    children: b.clienteget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomCard(
                                  controller: b,
                                  s: element.obs,
                                ),
                                const Divider(
                                  thickness: 0.5,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList()),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Palette.primary,
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Get.toNamed(Routes.REGISTRARCLIENTE);
                },
              ),
            ],
          ),
        ));
  }
}

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListclientController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          controller.selectedItem.clear();
          controller.isMultiSelectionEnabled.value = false;
        },
        icon: const Icon(Icons.close));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final ListclientController controller;

  final Rx<Client> s;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: controller.selectedItem.contains(s.value)
                ? Colors.grey[300]
                : null,
            child: ListTile(
              onTap: () {
                controller.doMultiSelection(s.value);
              },
              onLongPress: () {
                controller.isMultiSelectionEnabled.value = true;
                controller.doMultiSelection(s.value);
              },
              title: Text(s.value.nombre!),
              isThreeLine: true,
              subtitle: Text(('Recorrrido: ${s.value.recorrido}' "\n") +
                  ('Barrio: ${s.value.barrio?['zona']}' "\n")),
              leading: const CircleAvatar(
                backgroundColor: Palette.primary,
              ),
            )),
        Container(
          child: s.value.listanegra == true
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: (const Center(
                    child: Text("Lista Negra",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  )),
                )
              : Container(),
        )
      ],
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListclientController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        autofocus: true,
        onChanged: (buscar) => controller.searching(buscar),
        decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintText: 'Buscar'),
      ),
    );
  }
}
