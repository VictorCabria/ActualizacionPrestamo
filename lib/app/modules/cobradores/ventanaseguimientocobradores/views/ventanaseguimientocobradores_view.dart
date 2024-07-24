import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prestamo_mc_2_0/app/modules/cobradores/ventanaseguimientocobradores/controllers/ventanaseguimientocobradores_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../models/zone_model.dart';
import '../../../../utils/palette.dart';


class VentanaseguimientocobradoresView
  extends GetView<VentanaseguimientocobradoresController> {
  const VentanaseguimientocobradoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del cobrador'),
          backgroundColor: Palette.primary,
          centerTitle: true,
        ),
        body: Obx(() => Column(children: [
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
                        controller.editarcobrador(controller.cobrador!);
                      },
                      child: const Text(
                        "Editar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
                          future: controller
                              .getcobradorById(controller.cobrador!.id!),
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              Cobradores cobrador = snapshot.data as Cobradores;
                              return Text(
                                ("Cobrador: ${cobrador.nombre!}"),
                                style: const TextStyle(fontSize: 20),
                              );
                            } else {
                              return const Text("");
                            }
                          }),
                      isThreeLine: true,
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 10, 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                              ),
                              SizedBox(height: 2.h),
                              Row(
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
                                            Text(
                                              'Recaudos creados',
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
                                              controller.recaudo.length
                                                  .toString(),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'Total Recaudado ',
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
                                            Text(controller.recaudoreciente ==
                                                    null
                                                ? "No ha recaudado"
                                                : controller.montorecaudos
                                                    .toStringAsFixed(1)),
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
            ])));
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final VentanaseguimientocobradoresController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<VentanaseguimientocobradoresController>(
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

  final VentanaseguimientocobradoresController controller;

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
                                              .recaudoreciente!.total!
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
                                            Flexible(
                                              child: FutureBuilder(
                                                  future: controller
                                                      .getzonaById(controller
                                                          .recaudoreciente!
                                                          .zoneId!),
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
                                                  }),
                                            )
                                          ])
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
                                          Text(controller
                                              .recaudoreciente!.estado!),
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
