import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/cuotas_modal.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/palette.dart';
import '../controllers/ventanacuotaprestamo_controller.dart';

class VentanacuotaprestamoView extends GetView<VentanacuotaprestamoController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
              future: controller.getClientById(controller.prestamo!.clienteId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Client client = snapshot.data as Client;
                  return Text(
                    ("Cuotas de ${client.nombre}"),
                    style: const TextStyle(fontSize: 20),
                  );
                } else {
                  return const Text("");
                }
              }),
          backgroundColor: Palette.primary,
          centerTitle: true,
        ),
        body: GetX<VentanacuotaprestamoController>(
          builder: (b) => b.isloading.value
              ? const CircularProgressIndicator()
              : ListView(
                  padding: EdgeInsets.only(bottom: 9.h),
                  children: controller.cuotaget
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
                      const Text("Cuotas Pagadas",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Container(
                        child: FutureBuilder(
                            future: controller
                                .consultarpagados(controller.prestamo!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print("result snapshot ${snapshot.data}");
                                return Text((" ${snapshot.data.toString()}"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold));
                              } else {
                                print(snapshot.data.toString());
                                return const Text('0',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold));
                              }
                            }),
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cuotas Restantes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Container(
                        child: FutureBuilder(
                            future: controller
                                .consultarrestantes(controller.prestamo!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print("result snapshot ${snapshot.data}");
                                return Text((" ${snapshot.data.toString()}"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold));
                              } else {
                                print(snapshot.data.toString());
                                return const Text('0',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold));
                              }
                            }),
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Monto",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("${controller.montosuma}",
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

  final VentanacuotaprestamoController controller;

  final Cuotas s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'N.cuota',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.ncuotas.toString()),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Valor cuota',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.valorcuota!.toStringAsFixed(1),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Fecha de pago',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(s.fechadepago != null
                                    ? DateFormat("dd/MM/yyyy").format(
                                        DateTime.parse("${s.fechadepago}"))
                                    : ""),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Valor Pagado',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.valorpagado!.toStringAsFixed(1),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Fecha de recaudo',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${s.fechaderecaudo}" == ""
                                    ? ""
                                    : s.fechaderecaudo != null
                                        ? DateFormat("dd/MM/yyyy").format(
                                            DateTime.parse(
                                                    "${s.fechaderecaudo}")
                                                .toLocal())
                                        : ""),
                              ],
                            ),
                            const SizedBox(height: 15),
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
                                Container(
                                    child: s.estado == Statuscuota.nopagado.name
                                        ? Container(
                                            height: 20,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[500],
                                            ),
                                            child: (const Center(
                                              child: Text("No Pagado",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                          )
                                        : s.estado == Statuscuota.pagado.name
                                            ? Container(
                                                height: 20,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[500],
                                                ),
                                                child: (const Center(
                                                  child: Text("Pagado",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )),
                                              )
                                            : s.estado ==
                                                    Statuscuota.incompleto.name
                                                ? Container(
                                                    height: 20,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[500],
                                                    ),
                                                    child: (const Center(
                                                      child: Text("Incompleto",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    )),
                                                  )
                                                : Container())
                              ],
                            ),
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
