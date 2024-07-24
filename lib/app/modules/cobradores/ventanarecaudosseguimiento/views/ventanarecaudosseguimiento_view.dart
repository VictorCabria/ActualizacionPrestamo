import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/recaudo_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../utils/palette.dart';
import '../controllers/ventanarecaudosseguimiento_controller.dart';

class VentanarecaudosseguimientoView
    extends GetView<VentanarecaudosseguimientoController> {
  const VentanarecaudosseguimientoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: const Text('Todos los Recaudos'),
          backgroundColor: Palette.primary,
          centerTitle: true,
        ),
        body: GetX<VentanarecaudosseguimientoController>(
          builder: (b) => b.isloading.value
              ? const CircularProgressIndicator()
              : ListView(
                  padding: EdgeInsets.only(bottom: 9.h),
                  children: controller.recaudoget
                      .map(
                        (element) => SizedBox(
                          child: Column(
                            children: [
                              CustomCard3(
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
        bottomSheet: Container(
          color: Palette.secondary,
          height: 10.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total monto",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text(controller.montorecaudos.value.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Recaudos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("${controller.recaudo.length}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ],
          ),
        )));
  }
}

class CustomCard3 extends StatelessWidget {
  const CustomCard3({Key? key, required this.controller, required this.s})
      : super(key: key);

  final VentanarecaudosseguimientoController controller;

  final Recaudo s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () {},
          onLongPress: () {},
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cobrador!.nombre!),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(s.fecha != null
                                              ? DateFormat("dd/MM/yyyy").format(
                                                  DateTime.parse("${s.fecha}")
                                                      .toLocal())
                                              : ""),
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.total!.toStringAsFixed(2)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Zona',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: FutureBuilder(
                                      future: controller.getzonaById(s.zoneId!),
                                      builder: (context, snapshot) {
                                        print(snapshot.data);
                                        if (snapshot.hasData) {
                                          Zone zone = snapshot.data as Zone;
                                          return Text(
                                            (zone.nombre!),
                                          );
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                )
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Estado',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.confirmacion == "passed"
                                    ? "Aprobado"
                                    : ""),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Palette.primary)),
                                onPressed: (() => controller.ventanarecaudo(s)),
                                child: const Text("Detalles"))
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
