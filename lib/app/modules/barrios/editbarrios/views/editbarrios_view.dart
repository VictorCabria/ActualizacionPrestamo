import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/utils/palette.dart';

import '../../../../utils/palette.dart';
import '../controllers/editbarrios_controller.dart';

class EditbarriosView extends GetView<EditbarriosController> {
  const EditbarriosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Editar Barrios"),
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      initialValue: controller.barrio.nombre,
                      autofocus: false,
                      onChanged: (value) => controller.nombre.value = value,
                      textInputAction: TextInputAction.next,
                      cursorColor: Palette.primary,
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
                          labelText: "Nombre",
                          fillColor: Palette.primary,
                          labelStyle: TextStyle(color: Palette.primary)),
                    )),
                const SizedBox(height: 20),
                Obx(
                  () => !controller.loading.value
                      ? DropdownButtonFormField<String>(
                          items: controller.zonecontroller.map((items) {
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
                              labelText: "Zona",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary)),
                          value: controller.editzona?.id,
                          onChanged: controller.onChangeDorpdown)
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
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
                        controller.editbarrio();
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
