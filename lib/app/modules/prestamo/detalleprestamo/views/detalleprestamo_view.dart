import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../models/client_model.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/palette.dart';
import '../controllers/detalleprestamo_controller.dart';

class DetalleprestamoView extends GetView<DetalleprestamoController> {
  const DetalleprestamoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del prestamo'),
          backgroundColor: Palette.primary,
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isloading.value
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    const SizedBox(height: 3),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Palette.primary)),
                            onPressed: () {
                              controller.editarprestamo(controller.prestamo!);
                            },
                            child: const Text(
                              "Editar",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          controller.prestamo!.estado ==
                                  StatusPrestamo.refinanciado.name
                              ? Container()
                              : controller.prestamo!.estado ==
                                      StatusPrestamo.aldia.name
                                  ? controller.prestamo!.saldoPrestamo! <= 0
                                      ? Container()
                                      : ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Palette.primary)),
                                          onPressed: () {
                                            controller
                                                .renovar(controller.prestamo!);
                                          },
                                          child: const Text(
                                            "Renovar",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        )
                                  : controller.prestamo!.estado ==
                                          StatusPrestamo.vencido.name
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Palette.primary)),
                                          onPressed: () {
                                            controller.refinanciar(
                                                controller.prestamo!);
                                          },
                                          child: const Text(
                                            "Refinanciar",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        )
                                      : Container(),
                          controller.prestamo!.estado ==
                                  StatusPrestamo.refinanciado.name
                              ? Container()
                              : controller.prestamo!.saldoPrestamo! <= 0
                                  ? Container()
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Palette.primary)),
                                      onPressed: () {
                                        controller.recaudarsinautorizar(
                                            controller.prestamo!);
                                      },
                                      child: const Text(
                                        "Recaudar",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Card(
                        elevation: 2,
                        child: Container(
                          child: ListTile(
                            title: FutureBuilder(
                              future: controller.getClientById(
                                  controller.prestamo!.clienteId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Client client = snapshot.data as Client;
                                  return Text(
                                    (client.nombre!),
                                    style: const TextStyle(fontSize: 30),
                                  );
                                } else {
                                  return const Text("");
                                }
                              },
                            ),
                            isThreeLine: true,
                            subtitle: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: FutureBuilder(
                                                future: controller
                                                    .getClientById(controller
                                                        .prestamo!.clienteId!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    Client client =
                                                        snapshot.data as Client;
                                                    return Text(
                                                      (client.recorrido!),
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    );
                                                  } else {
                                                    return const Text("");
                                                  }
                                                }),
                                          ),
                                          const SizedBox(width: 10),
                                          FutureBuilder(
                                              future: controller
                                                  .gettipoprestamoById(
                                                      controller.prestamo!
                                                          .tipoPrestamoId!),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  TypePrestamo tipoprestamo =
                                                      snapshot.data
                                                          as TypePrestamo;
                                                  return Container(
                                                      child: Text(
                                                          (" ${tipoprestamo.nombre!} "),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15)));
                                                } else {
                                                  return const Text("");
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cobrador',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FutureBuilder(
                                                      future: controller
                                                          .getcobradorById(
                                                              controller
                                                                  .prestamo!
                                                                  .cobradorId!),
                                                      builder:
                                                          (context, snapshot) {
                                                        print(snapshot.data);
                                                        if (snapshot.hasData) {
                                                          Cobradores cobrador =
                                                              snapshot.data
                                                                  as Cobradores;
                                                          return Text(
                                                            (cobrador.nombre!),
                                                          );
                                                        } else {
                                                          return const Text("");
                                                        }
                                                      }),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Monto',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.monto}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'N. Cuotas',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.numeroDeCuota}',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Fecha',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.fecha} ',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Porcentaje',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.porcentaje}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Valor Cuota',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.valorCuota}',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Zona',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: FutureBuilder(
                                                          future: controller
                                                              .getzonaById(
                                                                  controller
                                                                      .prestamo!
                                                                      .zonaId!),
                                                          builder: (context,
                                                              snapshot) {
                                                            print(
                                                                snapshot.data);
                                                            if (snapshot
                                                                .hasData) {
                                                              Zone zone =
                                                                  snapshot.data
                                                                      as Zone;
                                                              return Text(
                                                                (zone.nombre!),
                                                              );
                                                            } else {
                                                              return const Text(
                                                                  "");
                                                            }
                                                          }),
                                                    )
                                                  ]),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.totalPrestamo} ',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Saldo ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${controller.prestamo!.saldoPrestamo!.toStringAsFixed(2)} ',
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                        child: const Text("Detalles",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    const SizedBox(height: 5),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${controller.prestamo!.detalle}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*     const SizedBox(height: 15),
                            Container(
                                color: Colors.red,
                                child: Text(controller.prestamo!.estado!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))), */
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Form(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Column(
                                children: [
                                  TabBar(
                                    controller: controller.tabController,
                                    labelColor: Palette.primary,
                                    indicatorColor: Palette.primary,
                                    tabs: const [
                                      Tab(text: "Recaudos"),
                                      Tab(text: "Cuota"),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: controller.tabController,
                                      children: [
                                        Page2(controller: controller),
                                        Page1(controller: controller),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetalleprestamoController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetalleprestamoController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(children: [
              Column(
                children: [
                  CustomCard(
                    controller: b,
                  ),
                  const Divider(
                    thickness: 0.5,
                  )
                ],
              ),
            ]),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DetalleprestamoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loadinReciente.value
        ? const CircularProgressIndicator()
        : controller.cuotareciente != null
            ? InkWell(
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                        children: [
                                          Text(""),
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ])),
                    isThreeLine: true,
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'N.cuota',
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
                                          Text(controller.cuotareciente!.ncuotas
                                              .toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Valor cuota',
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
                                            '${controller.cuotareciente!.valorcuota}',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Fecha de pago',
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
                                          Text(controller.cuotareciente!
                                                      .fechadepago !=
                                                  null
                                              ? DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse(
                                                      "${controller.cuotareciente!.fechadepago}"))
                                              : ""),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Valor Pagado',
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
                                            '${controller.cuotareciente!.valorpagado}',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'F de recaudo',
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
                                          Text("${controller.cuotareciente!.fechaderecaudo}" ==
                                                  ""
                                              ? ""
                                              : controller.cuotareciente!
                                                          .fechaderecaudo !=
                                                      null
                                                  ? DateFormat("dd/MM/yyyy")
                                                      .format(DateTime.parse(
                                                              "${controller.cuotareciente!.fechaderecaudo}")
                                                          .toLocal())
                                                  : ""),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Estado',
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
                                          Container(
                                              child: controller.cuotareciente!
                                                          .estado ==
                                                      Statuscuota.nopagado.name
                                                  ? Container(
                                                      height: 20,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[500]),
                                                      child: (const Center(
                                                        child: Text("No Pagado",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      )),
                                                    )
                                                  : controller.cuotareciente!
                                                              .estado ==
                                                          Statuscuota
                                                              .pagado.name
                                                      ? Container(
                                                          height: 20,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .green[500],
                                                          ),
                                                          child: (const Center(
                                                            child: Text(
                                                                "Pagado",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          )),
                                                        )
                                                      : controller.cuotareciente!
                                                                  .estado ==
                                                              Statuscuota
                                                                  .incompleto
                                                                  .name
                                                          ? Container(
                                                              height: 20,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red[500],
                                                              ),
                                                              child:
                                                                  (const Center(
                                                                child: Text(
                                                                    "Incompleto",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              )),
                                                            )
                                                          : Container())
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Palette.primary)),
                                          onPressed: (() =>
                                              controller.ventanacuotas()),
                                          child: const Text("Cuotas"))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink());
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetalleprestamoController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetalleprestamoController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(children: [
              Column(
                children: [
                  CustomCard2(
                    controller: b,
                  ),
                  const Divider(
                    thickness: 0.5,
                  )
                ],
              ),
            ]),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  const CustomCard2({Key? key, required this.controller}) : super(key: key);

  final DetalleprestamoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loadinReciente.value
        ? const CircularProgressIndicator()
        : controller.recaudoreciente != null
            ? InkWell(
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),
                              Row(
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
                                        children: [
                                          Text(controller
                                                      .recaudoreciente!.fecha !=
                                                  null
                                              ? DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse(
                                                          "${controller.recaudoreciente!.fecha}")
                                                      .toLocal())
                                              : ""),
                                        ],
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ])),
                    isThreeLine: true,
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                          Text(controller
                                              .recaudoreciente!.saldo!
                                              .toStringAsFixed(2)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Monto',
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
                                          Text(controller
                                              .recaudoreciente!.monto!
                                              .toStringAsFixed(2)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Valor a pagar',
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
                                            controller.recaudoreciente!.total!
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Palette.primary)),
                                          onPressed: (() =>
                                              controller.ventanadetalles()),
                                          child: const Text("Recaudos"))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink());
  }
}
