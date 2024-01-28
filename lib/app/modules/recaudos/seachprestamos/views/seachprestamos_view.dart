import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/client_model.dart';
import 'package:prestamo_mc/app/models/prestamo_model.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/seachprestamos_controller.dart';

class SeachprestamosView extends GetView<SeachprestamosController> {
  const SeachprestamosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.isBuscar.value
                ? CustomSearch(controller: controller)
                : Text('Buscar Prestamos'),
            centerTitle: true,
            backgroundColor: Palette.primary,
            actions: <Widget>[
              controller.isBuscar.value
                  ? IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.cancel))
                  : IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.search)),
            ],
          ),
          body: GetX<SeachprestamosController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    children: controller.prestamosget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                CustomCard(
                                  controller: b,
                                  s: element,
                                ),
                                const Divider(
                                  thickness: 0.5,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList()),
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final SeachprestamosController controller;

  final Prestamo s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                controller.doSelection(s);
              },
              title: FutureBuilder(
                  future: controller.getClientById(s.clienteId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Client client = snapshot.data as Client;
                      return Text(
                        (client.nombre!),
                        style: const TextStyle(fontSize: 20),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
              isThreeLine: true,
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[500],
                                  borderRadius: BorderRadius.circular(4)),
                              child:  Text(
                                '${s.recorrido}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                          FutureBuilder(
                              future: controller
                                  .gettipoprestamoById(s.tipoPrestamoId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  TypePrestamo tipoprestamo =
                                      snapshot.data as TypePrestamo;
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 142, 199, 247),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text((" ${tipoprestamo.nombre!} "),
                                          style:
                                              const TextStyle(fontSize: 15)));
                                } else {
                                  return const Text("");
                                }
                              })
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Fecha',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${s.fecha}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Cuotas: ${s.numeroDeCuota} ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Valor',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${s.valorCuota} ',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Estado: ${s.estado ?? 'Nuevo'} ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Saldo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${s.saldoPrestamo} ',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total: ${s.totalPrestamo} ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ]),
              ),
              /* Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: (Table(children: [
                  TableRow(children: [
                    Text(
                      "${s.fecha}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(''),
                    FutureBuilder(
                        future:
                            controller.gettipoprestamoById(s.tipoPrestamoId!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            TypePrestamo tipoprestamos =
                                snapshot.data as TypePrestamo;
                            return Text(
                              tipoprestamos.nombre!,
                            );
                          } else {
                            return const Text("");
                          }
                        }),
                  ]),
                  const TableRow(children: [
                    Text(
                      "Fecha",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    Text(
                      "Valor",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    Text(
                      "Saldo",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "${s.fecha}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "${s.valorCuota}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "${s.saldoPrestamo}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "${s.fecha}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "${s.valorCuota}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "${s.saldoPrestamo}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Cuotas: ${s.numeroDeCuota}",
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const Text(
                      "Pagados: 0",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const Text(
                      "Restantes: 3",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ]),
                ])),
 ) */
              /* subtitle: Text(
            ('fecha: ${formatFecha.format(DateTime.parse(s.fecha!))}'
                "\nvalor: ${s.totalPrestamo}"),
            style: const TextStyle(fontSize: 15)), */
              /* trailing: SizedBox(
          width: 100,
          child: Stack(alignment: Alignment.centerRight, children: <Widget>[
            Visibility(
                visible: controller.isMultiSelectionEnabled.value,
                child: Icon(
                  controller.selectedItem.contains(s)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  size: 30,
                  color: Palette.primary,
                )),
          ]),
        ), */
            )));
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SeachprestamosController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        autofocus: true,
        onChanged: (buscar) => controller.searching(buscar),
        decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintText: 'Buscar'),
      ),
    );
  }
}
