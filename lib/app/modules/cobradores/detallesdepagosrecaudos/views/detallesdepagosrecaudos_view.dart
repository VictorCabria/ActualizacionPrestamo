import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/recaudo_line_modal.dart';
import '../../../../utils/palette.dart';
import '../controllers/detallesdepagosrecaudos_controller.dart';

class DetallesdepagosrecaudosView
    extends GetView<DetallesdepagosrecaudosController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos los Recaudos'),
          backgroundColor: Palette.primary,
          centerTitle: true,
        ),
        body: GetX<DetallesdepagosrecaudosController>(
          builder: (b) => b.isloading.value
              ? const CircularProgressIndicator()
              : ListView(
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
        ));
  }
}

class CustomCard3 extends StatelessWidget {
  const CustomCard3({Key? key, required this.controller, required this.s})
      : super(key: key);

  final DetallesdepagosrecaudosController controller;

  final RecaudoLine s;
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
                                  FutureBuilder(
                                      future: controller
                                          .getClientById(s.idCliente!),
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
                                  'Saldo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.saldo!.toStringAsFixed(2)),
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
                                  'Monto',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.monto!.toStringAsFixed(2)),
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
                                  'Valor a pagar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.total!.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
