
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/palette.dart';
import '../controllers/creatediasnocobro_controller.dart';

class CreatediasnocobroView extends GetView<CreatediasnocobroController> {
  const CreatediasnocobroView({super.key});

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
                            child:  Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
               onTap: () async {
                  final DateTime? pickedTime = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (pickedTime != null) {
                    controller.fromDateControler.text =
                        DateFormat('yyyy-MM-dd').format(pickedTime);;
                  }
                },
                autofocus: false,
                keyboardType: TextInputType.number,
                cursorColor: Palette.primary,
               controller: controller.fromDateControler,
                onSaved: (value) {
                  controller.fromDateControler.text = value!;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.headset, color: Palette.primary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                      borderSide: BorderSide(color: Palette.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                      borderSide: BorderSide(
                        color: Palette.primary,
                      ),
                    ),
                    labelText: "Fecha expiracion",
                    fillColor: Palette.primary,
                    labelStyle: TextStyle(color: Palette.primary)),
              ),
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
