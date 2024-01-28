import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../utils/palette.dart';
import '../controllers/informetransacciones_controller.dart';

class InformetransaccionesView extends GetView<InformetransaccionesController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text(
            "informes de Transacciones",
          ),
          centerTitle: true,
          backgroundColor: Palette.primary,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(
          children: [
            Form(
              key: controller.formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                      items: controller.items.map(
                        (items) {
                          return DropdownMenuItem<String>(
                            value: items.keys.first,
                            child: Text('${items.values.first}'),
                          );
                        },
                      ).toList(),
                      decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
                        prefixIcon:
                            Icon(Icons.calendar_month, color: Palette.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          ),
                        ),
                        labelText: "Tipo",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: controller.dropdowndatos),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: DateTimePicker(
                    type: DateTimePickerType.date,
                    initialValue: controller.fecha.value,
                    dateMask: "yyyy-MM-dd",
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onChanged: (value) => controller.fecha.value = value,
                    decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
                        prefixIcon:
                            Icon(Icons.calendar_month, color: Palette.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          ),
                        ),
                        labelText: "Desde",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: "yyyy-MM-dd",
                    initialValue: controller.fechafinal.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onChanged: (value) => controller.fechafinal.value = value,
                    decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
                        prefixIcon:
                            Icon(Icons.calendar_month, color: Palette.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          ),
                        ),
                        labelText: "Hasta",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: controller.selectdatos.value == "Cobrador"
                        ? Obx(
                            () => DropdownButtonFormField(
                                items: controller.cobradorescontroller
                                    .map((items) {
                                  return DropdownMenuItem<Cobradores>(
                                      value: items,
                                      child: Text(' ${items.nombre}'));
                                }).toList(),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle,
                                        color: Palette.primary),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.primary,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Palette.primary,
                                      ),
                                    ),
                                    labelText: "Cobradores",
                                    fillColor: Palette.primary,
                                    labelStyle:
                                        TextStyle(color: Palette.primary)),
                                onChanged:
                                    controller.onChangeDorpdowncobradores),
                          )
                        : Container(),
                  ),
                ]),
              ),
            ),
            /*   controller.cargando.value
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 5,
                      )),
                    )
                  : Container() */
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                backgroundColor: Palette.primary,
                child: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  if (controller.selectdatos.value == "") {
                    Get.dialog(
                        const AlertDialog(content: Text("Seleccione un tipo")));
                  } else {
                    controller.buscarlistas(controller.selectdatos.value);
                  }
                })
          ],
        )));
  }
}
