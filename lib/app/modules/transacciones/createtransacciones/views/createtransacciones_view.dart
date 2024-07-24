import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/concepto_model.dart';
import '../../../../utils/palette.dart';
import '../controllers/createtransacciones_controller.dart';

class CreatetransaccionesView extends GetView<CreatetransaccionesController> {
  const CreatetransaccionesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Registrar de Transacciones"),
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
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: 60,
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
                                '${pickedTime.day}-${pickedTime.month}-${pickedTime.year}';
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
                          items: controller.conceptocontroller.map((items) {
                            return DropdownMenuItem<Concepto>(
                                value: items, child: Text(' ${items.nombre}'));
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
                              labelText: "Concepto",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary)),
                          onChanged: controller.onChangeDorpdown),
                    )),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    initialValue: controller.valor.toString(),
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.valor.value = double.parse(value);
                    },
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
                        labelText: "Valor",
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
                        items: controller.cobradorescontroller.map((items) {
                          return DropdownMenuItem<Cobradores>(
                              value: items, child: Text(' ${items.nombre}'));
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
                            labelText: "Tercero",
                            fillColor: Palette.primary,
                            labelStyle: TextStyle(color: Palette.primary)),
                        onChanged: controller.onChangeDorpdowncobradores),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    cursorColor: Palette.primary,
                    controller: controller.detallescontroller,
                    onSaved: (value) {
                      controller.detallescontroller.text = value!;
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
                        labelText: "Detalle",
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
                        controller.addtransacciones();
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
