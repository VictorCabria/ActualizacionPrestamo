import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/utils/palette.dart';

import '../controllers/createzone_controller.dart';

class CreatezoneView extends GetView<CreatezoneController> {
  const CreatezoneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Registrar Zonas"),
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
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      controller: controller.nombrezonecontroller,
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        controller.nombrezonecontroller.text = value!;
                        if (kDebugMode) {
                          print(controller.nombrezonecontroller);
                        }
                      },
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
                          labelText: "Nombre de la Zona",
                          fillColor: Palette.primary,
                          labelStyle: TextStyle(color: Palette.primary)),
                    )),
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
                        controller.addzone();
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
