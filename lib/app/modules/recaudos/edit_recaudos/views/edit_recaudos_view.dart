import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/palette.dart';
import '../controllers/edit_recaudos_controller.dart';

class EditRecaudosView extends GetView<EditRecaudosController> {
  const EditRecaudosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Editar de Recaudos"),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                        height: 10.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
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
                          controller: controller.fromDateControler,
                          keyboardType: TextInputType.number,
                          cursorColor: Palette.primary,
                          onSaved: (value) {
                            controller.fromDateControler.text = value!;
                          },
                          decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.headset, color: Palette.primary),
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
                              labelText: "Fecha",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary)),
                        ),
                      ),
                const SizedBox(height: 15),
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Obx(
                      () => DropdownButtonFormField(
                          items: controller.barriocontroller.map((items) {
                            return DropdownMenuItem<String>(
                                value: items.id,
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
                              labelText: "Barrio",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary)),
                          value: controller.selectbarrio?.id,
                          onChanged: controller.onChangeDorpdown),
                    )),
                const SizedBox(height: 15),
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Obx(
                      () => DropdownButtonFormField(
                          items: controller.cobradorescontroller.map((items) {
                            return DropdownMenuItem<String>(
                                value: items.id,
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
                              labelText: "Cobrador",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary)),
                          value: controller.selectcobradores?.id,
                          onChanged: controller.onChangeDorpdowncobradores),
                    )),
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
                        /*  controller.addrecaudos(); */
                      },
                      child: const Text(
                        "Guardar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
