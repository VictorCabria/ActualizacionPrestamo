import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import '../controllers/recaudar_controller.dart';

class RecaudarView extends GetView<RecaudarController> {
  const RecaudarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recaudar'),
        centerTitle: true,
        backgroundColor: Palette.primary,
      ),
      body: Form(
        key: controller.formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: DateTimePicker(
                  dateMask: "d/MM/yyyy",
                  cursorColor: Palette.primary,
                  initialValue: controller.fecha.value,
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
                      labelText: "Fecha",
                      fillColor: Palette.primary,
                      labelStyle: TextStyle(color: Palette.primary)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: false,
                        onTap: () {
                          controller.valorseleccionado();
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: Palette.primary,
                        controller: controller.recaudocontroller,
                        onSaved: (value) {
                          controller.recaudocontroller.text = value!;
                        },
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
                            labelText: "Prestamos",
                            fillColor: Palette.primary,
                            labelStyle: TextStyle(color: Palette.primary)),
                      ),
                    ),
                  ])),
              const SizedBox(height: 15),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: Palette.primary,
                  initialValue: controller.monto.toString(),
                  onChanged: (value) {
                    controller.monto.value = double.parse(value);
                  },
                  decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.account_circle, color: Palette.primary),
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
                      labelText: "Monto",
                      fillColor: Palette.primary,
                      labelStyle: TextStyle(color: Palette.primary)),
                ),
              ),
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
                      /*          controller.addrecaudar(); */
                    },
                    child: const Text(
                      "Recaudar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}