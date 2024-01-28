import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/palette.dart';
import '../controllers/creatediasnocobro_controller.dart';

class CreatediasnocobroView extends GetView<CreatediasnocobroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: const Text("Indicar dias de no cobro"),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Form(
            key: controller.formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            height: 10.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: DateTimePicker(
                              dateMask: "d/MM/yyyy",
                              cursorColor: Palette.primary,
                              initialValue: controller.fecha.value,
                              firstDate: DateTime(2000),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 665)),
                              dateLabelText: 'Fecha',
                              onChanged: (val) => controller.fecha.value = val,
                              decoration: const InputDecoration(
                                  focusColor: Palette.primary,
                                  hoverColor: Palette.primary,
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
                                  labelText: "Dias no cobro",
                                  fillColor: Palette.primary,
                                  labelStyle:
                                      TextStyle(color: Palette.primary)),
                            ),
                          ),
                        ),
                      ])),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Palette.primary)),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "Atras",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Palette.primary)),
                        onPressed: () {
                          controller.adddiasnocobro();
                        },
                        child: const Text(
                          "Guardar",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
