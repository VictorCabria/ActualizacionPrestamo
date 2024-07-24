import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/palette.dart';
import '../controllers/editzone_controller.dart';

class EditzoneView extends GetView<EditzoneController> {
  const EditzoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Zona'),
        backgroundColor: Palette.primary,
        centerTitle: true,
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
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      initialValue: controller.zone.nombre,
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
                          labelText: "Nombre de la zona",
                          fillColor: Palette.primary,
                          labelStyle: TextStyle(color: Palette.primary)),
                    )),
                const SizedBox(height: 20),
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
                        controller.editbzone();
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
