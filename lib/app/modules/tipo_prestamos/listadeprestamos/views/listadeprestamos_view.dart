import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/utils/palette.dart';

import '../../../../models/type_prestamo_model.dart';
import '../controllers/listadeprestamos_controller.dart';

class ListadeprestamosView extends GetView<ListadeprestamosController> {
  const ListadeprestamosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.isBuscar.value
                ? CustomSearch(controller: controller)
                : Text(controller.isMultiSelectionEnabled.value
                    ? controller.getSelectedbarrios()
                    : "Tipos de prestamos"" ${controller.prestamo.length.toString()}"),
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
                                  "Estas seguro que quieres borrar este prestamo"),
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
          body: GetX<ListadeprestamosController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    children: b.prestamoget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 1,
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
                  Get.toNamed(Routes.REGISTRARPRESTAMOS);
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

  final ListadeprestamosController controller;

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

  final ListadeprestamosController controller;

  final Rx<TypePrestamo> s;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: ListTile(
        onTap: () {
          controller.doMultiSelection(s.value);
        },
        onLongPress: () {
          controller.isMultiSelectionEnabled.value = true;
          controller.doMultiSelection(s.value);
        },
        title: Text(
          s.value.nombre!,
        ),
        trailing: SizedBox(
          width: 100,
          child: Stack(alignment: Alignment.centerRight, children: <Widget>[
            Visibility(
                visible: controller.isMultiSelectionEnabled.value,
                child: Icon(
                  controller.selectedItem.contains(s.value)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  size: 30,
                  color: Palette.primary,
                )),
          ]),
        ),
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListadeprestamosController controller;

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
