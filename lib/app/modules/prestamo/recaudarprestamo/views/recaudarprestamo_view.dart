import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import '../../../../utils/references.dart';
import '../controllers/recaudarprestamo_controller.dart';

class RecaudarprestamoView extends GetView<RecaudarprestamoController> {
  const RecaudarprestamoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: FutureBuilder(
              future: controller.getClientById(controller.prestamo!.clienteId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Client client = snapshot.data as Client;
                  return Text(
                    ("Prestamo ${client.nombre!} - ${controller.prestamo!.saldoPrestamo!.toStringAsFixed(2)}"),
                    style: const TextStyle(fontSize: 20),
                  );
                } else {
                  return const Text("");
                }
              }),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Form(
              key: controller.formkey,
              child: ListView(children: [
                Container(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text("Cobrador",
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 0.h),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FutureBuilder(
                                              future: controller
                                                  .getcobradorById(controller
                                                      .prestamo!.cobradorId!),
                                              builder: (context, snapshot) {
                                                print(snapshot.data);
                                                if (snapshot.hasData) {
                                                  Cobradores cobrador = snapshot
                                                      .data as Cobradores;
                                                  return Text(
                                                    (cobrador.nombre!),
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  );
                                                } else {
                                                  return const Text("");
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              )),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Cliente',
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 0.h),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future: controller.getClientById(
                                                controller
                                                    .prestamo!.clienteId!),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                Client client =
                                                    snapshot.data as Client;
                                                return Text(
                                                  (client.nombre!),
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                );
                                              } else {
                                                return const Text("");
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text('Saldo',
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 0.h),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              controller
                                                  .prestamo!.saldoPrestamo!
                                                  .toStringAsFixed(2),
                                              style:
                                                  const TextStyle(fontSize: 18))
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              )),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                            child: DateTimePicker(
                              dateMask: "d/MM/yyyy",
                              cursorColor: Palette.primary,
                              enabled: true,
                              initialValue: controller.pagodercaudo.value,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              onChanged: (value) =>
                                  controller.pagodercaudo.value = value,
                              decoration: const InputDecoration(
                                  focusColor: Palette.primary,
                                  hoverColor: Palette.primary,
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Palette.primary),
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
                                  labelStyle:
                                      TextStyle(color: Palette.primary)),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            height: 60,
                            width: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              initialValue: controller.valor.toString(),
                              autofocus: false,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                //aqui debes validar que este un numero si esta vacio no parseas
                                controller.valor.value = double.parse(value);
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
                                  labelText: "Valor",
                                  fillColor: Palette.primary,
                                  labelStyle:
                                      TextStyle(color: Palette.primary)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Palette.primary)),
                                onPressed: () {
                                  controller.getrecaudosinautorizar();
                                },
                                child: const Text(
                                  "Guardar",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Palette.primary)),
                                onPressed: () {
                                  Get.back();
                                  /* showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "Estas seguro que quieres cancelar "),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Palette
                                                                  .primary)),
                                                  onPressed: () {
                                                    Get.back(
                                                        closeOverlays: false);
                                                  },
                                                  child: const Text("Aceptar")),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Palette
                                                                  .primary)),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Cancelar"))
                                            ],
                                          )); */
                                },
                                child: const Text(
                                  "Descartar",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
            controller.cargando.value
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 5,
                    )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
