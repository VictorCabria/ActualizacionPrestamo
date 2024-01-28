import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/utils/palette.dart';

import '../controllers/editconceptos_controller.dart';

class EditconceptosView extends GetView<EditconceptosController> {
  const EditconceptosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Editar Concepto"),
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
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    initialValue: controller.concepto.nombre,
                    autofocus: false,
                    onChanged: (value) => controller.nombre.value = value,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    cursorColor: Palette.primary,
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
                        labelText: "Nombre",
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
                    () => !controller.loading.value
                        ? DropdownButtonFormField<String>(
                            items: controller.edittipocontroller.map((items) {
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
                                labelText: "Tipo",
                                fillColor: Palette.primary,
                                labelStyle: TextStyle(color: Palette.primary)),
                            value: controller.edittipo?.id,
                            onChanged: controller.onChangeDorpdown)
                        : const CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 15),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(
                    () => !controller.loading.value
                        ? DropdownButtonFormField<String>(
                            items: controller.naturalezacontroller.map((items) {
                              return DropdownMenuItem<String>(
                                  value: items.id,
                                  child: Text(' ${items.tipo}'));
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
                                labelText: "Naturaleza",
                                fillColor: Palette.primary,
                                labelStyle: TextStyle(color: Palette.primary)),
                            value: controller.editnaturaleza?.id,
                            onChanged: controller.onChangeDorpdownnaturaleza)
                        : const CircularProgressIndicator(),
                  ),
                ), 
                const SizedBox(height: 15),
                Obx(() => CheckboxListTile(
                    title: const Text(
                      "Concepto de Transaccion",
                      style: TextStyle(color: Palette.primary),
                    ),
                    value: controller.tipotransaccion.value,
                    activeColor: Palette.primary,
                    onChanged: ((value) {
                      controller.tipotransaccion.value = value!;
                    }))),
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
                           controller.editconcepto(); 
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
