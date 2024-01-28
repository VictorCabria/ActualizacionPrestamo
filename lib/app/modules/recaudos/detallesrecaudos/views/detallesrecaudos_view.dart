import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/utils/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/detallesrecaudos_controller.dart';

class DetallesrecaudosView extends GetView<DetallesrecaudosController> {
  const DetallesrecaudosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Recaudo'),
        backgroundColor: Palette.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),
          InkWell(
            child: Card(
              elevation: 2,
              child: Container(
                child: ListTile(
                  title: FutureBuilder(
                    future: controller
                        .getcobradorById(controller.recaudo!.cobradorId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Cobradores cobrador = snapshot.data as Cobradores;
                        return Text(
                          (cobrador.nombre!),
                          style: const TextStyle(fontSize: 20),
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
                                          controller.recaudo!.fecha != null
                                              ? DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse(
                                                      "${controller.recaudo!.fecha}"))
                                              : "",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    controller.recaudo!.confirmacion != "passed"
                                        ? Row(
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Palette
                                                                .primary)),
                                                onPressed: () {
                                                  controller
                                                      .autorizarrecaudos();
                                                },
                                                child: const Text(
                                                  "Autorizar",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container()
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
                                        Text(
                                          controller.getEstado(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
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
                                          'Zona',
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
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FutureBuilder(
                                                  future: controller
                                                      .getzonaById(controller
                                                          .recaudo!.zoneId!),
                                                  builder: (context, snapshot) {
                                                    print(snapshot.data);
                                                    if (snapshot.hasData) {
                                                      Zone zone =
                                                          snapshot.data as Zone;
                                                      return Text(
                                                        (zone.nombre!),
                                                      );
                                                    } else {
                                                      return const Text("");
                                                    }
                                                  })
                                            ]),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
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
                length: 1,
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
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
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
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetallesrecaudosController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetallesrecaudosController>(
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
  const CustomCard({Key? key, required this.controller}) : super(key: key);

  final DetallesrecaudosController controller;

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: controller.getClientById(
                                          controller
                                              .recaudoreciente!.idCliente!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Client client =
                                              snapshot.data as Client;
                                          return Text(
                                            (client.nombre!),
                                          );
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                  ))
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
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
                                          child: const Text("Ver todos"))
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
