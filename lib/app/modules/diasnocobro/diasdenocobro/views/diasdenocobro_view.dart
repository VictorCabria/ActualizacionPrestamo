import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/diasnocobro_modal.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/palette.dart';
import '../controllers/diasdenocobro_controller.dart';

class DiasdenocobroView extends GetView<DiasdenocobroController> {
  const DiasdenocobroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(controller.isMultiSelectionEnabled.value
                ? controller.getSelecteddiasnocobro()
                : 'Listas dias sin cobro'),
            actions: <Widget>[
              Visibility(
                visible: controller.selectedItem.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  "Estas seguro que quieres borrar este dia de no cobro?"),
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
                                    }),
                              ],
                            ));
                  },
                ),
              ),
            ],
            backgroundColor: Palette.primary,
            centerTitle: true,
            leading: controller.isMultiSelectionEnabled.value
                ? CustomMultiselector(controller: controller)
                : BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
          ),
          body: GetX<DiasdenocobroController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    children: b.diasnocobrosget
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
          floatingActionButton:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            FloatingActionButton(
                backgroundColor: Palette.primary,
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Get.toNamed(Routes.CREATEDIASNOCOBRO);
                })
          ]),
        ));
  }
}

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DiasdenocobroController controller;

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

  final DiasdenocobroController controller;

  final Rx<Diasnocobro> s;
  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          controller.selectedItem.contains(s.value) ? Colors.grey[300] : null,
      child: ListTile(
        onTap: () {
          controller.doMultiSelection(s.value);
        },
        onLongPress: () {
          controller.isMultiSelectionEnabled.value = true;
          controller.doMultiSelection(s.value);
        },
        title: Text(
            ("${s.value.dia}" == ""
                    ? ""
                    : s.value.dia != null
                        ? DateFormat("EEEE")
                            .format(DateTime.parse("${s.value.dia}").toLocal())
                        : "") +
                (" ") +
                (" ${s.value.dia}" == ""
                    ? ""
                    : s.value.dia != null
                        ? DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse("${s.value.dia}").toLocal())
                        : ""),
            style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
