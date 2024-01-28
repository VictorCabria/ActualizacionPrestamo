import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/models/zone_model.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../controllers/create_session_controller.dart';

class CreateSessionView extends GetView<CreateSessionController> {
  const CreateSessionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: FutureBuilder(
            future: controller
                .getcobradorById(controller.homeControll.cobradores!.id!),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                Cobradores cobrador = snapshot.data as Cobradores;
                return Text(
                  ('Sesion de ${cobrador.nombre!}'),
                  style: const TextStyle(fontSize: 20),
                );
              } else {
                return const Text("");
              }
            }),
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
                  child: DateTimePicker(
                    dateMask: "d/MM/yyyy",
                    cursorColor: Palette.primary,
                    initialValue: controller.hoy,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 665)),
                    dateLabelText: 'Fecha',
                    onChanged: (val) => controller.hoy = val,
                    decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
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
                        labelText: "Fecha",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                  ),
                ),

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: GetBuilder<CreateSessionController>(
                    id: 'cobradores',
                    builder: (manual) => DropdownButtonFormField(
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione un Cobrador';
                          }
                          return null;
                        },
                        items: controller.cobradores.map((items) {
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
                            labelText: "Cobradores",
                            fillColor: Palette.primary,
                            labelStyle: TextStyle(color: Palette.primary)),
                        value: controller.cobrador2,
                        onChanged: (d) {
                          controller.cobrador = d as Cobradores;
                          print(controller.cobrador!.nombre);
                        }),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Obx(
                    () => DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione una Zona';
                          }
                          return null;
                        },
                        items: controller.zonas.map((items) {
                          return DropdownMenuItem<Zone>(
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.red,
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
                          labelStyle: TextStyle(color: Palette.primary),
                        ),
                        onChanged: (d) {
                          controller.zona = d as Zone;
                        }),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                      /* initialValue: controller.valorInicial.toString() */
                      controller: controller.controller2,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese un valor inicial';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.valorInicial.value = double.parse(value);
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
                          labelText: "Valor Inicial",
                          fillColor: Palette.primary,
                          labelStyle: TextStyle(color: Palette.primary)),
                      onTap: () => controller.selectAll2()),
                ),

                const SizedBox(height: 15),
                // Container(
                //   height: 60,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20)),
                //   child: Obx(
                //     () => DropdownButtonFormField(
                //         items: controller.naturalezaconceptocontroller
                //             .map((items) {
                //           return DropdownMenuItem<Naturaleza>(
                //               value: items, child: Text(' ${items.tipo}'));
                //         }).toList(),
                //         decoration: const InputDecoration(
                //             prefixIcon: Icon(Icons.account_circle,
                //                 color: Palette.primary),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.all(
                //                 Radius.circular(40.0),
                //               ),
                //               borderSide: BorderSide(
                //                 color: Palette.primary,
                //                 width: 1,
                //               ),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.all(
                //                 Radius.circular(40.0),
                //               ),
                //               borderSide: BorderSide(
                //                 color: Palette.primary,
                //               ),
                //             ),
                //             labelText: "Naturaleza",
                //             fillColor: Palette.primary,
                //             labelStyle: TextStyle(color: Palette.primary)),
                //         onChanged: controller.onChangeDorpdownnaturaleza),
                //   ),
                // ),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Palette.primary)),
                      onPressed: () => controller.createSession(),
                      child: const Text(
                        "Crear Session",
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
