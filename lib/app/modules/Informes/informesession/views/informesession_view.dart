import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/palette.dart';
import '../controllers/informesession_controller.dart';
import 'package:pdf/widgets.dart' as pw;

class InformesessionView extends GetView<InformesessionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "informes de Session",
          ),
          backgroundColor: Palette.primary,
          centerTitle: true,
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
                child: Icon(
                  Icons.search,
                ),
                onPressed: () => controller.metodobusqueda())
          ],
        ));
  }
}
