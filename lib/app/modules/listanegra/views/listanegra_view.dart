import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/client_model.dart';
import '../../../utils/palette.dart';
import '../controllers/listanegra_controller.dart';

final format = DateFormat('yyyy-MM-dd');
final numberFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 1);

class ListanegraView extends GetView<ListanegraController> {
  const ListanegraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Lista Negra'),
            backgroundColor: Palette.primary,
            centerTitle: true,
            bottom: TabBar(
              onTap: (value) => controller.index.value = value,
              tabs: const [
                Tab(
                  text: 'Prestamos',
                ),
                Tab(
                  text: 'Clientes',
                ),
              ],
            ),
          ),
          body: TabBarView(
              /* physics: NeverScrollableScrollPhysics(), */
              /* controller: controller.tabController, */
              children: [prestamos(), clientes()]),
        ),
      ),
    );
  }

  SingleChildScrollView prestamos() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Column(
        children: controller.prestamos
            .map((e) => FutureBuilder(
                future: controller.getClientById(e.clienteId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Client client = snapshot.data as Client;
                    return Card(
                      child: ListTile(
                        onLongPress: () {
                          controller.listnegraprestamos(e);
                        },
                        title: Text(client.nombre!),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Fecha"),
                                      Text(format
                                          .format(DateTime.parse(e.fecha!))),
                                    ]),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Préstamo"),
                                      Text(
                                          numberFormat.format(e.totalPrestamo)),
                                    ]),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Saldo"),
                                      Text(
                                          numberFormat.format(e.saldoPrestamo)),
                                    ]),
                              ),
                            ]),
                        /* trailing: IconButton(
                          onPressed: (() {
                            controller.listnegraprestamos(e);
                          }),
                          icon: Icon(Icons.more_vert),
                        ), */
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }))
            .toList(),
      ),
    );
  }

  SingleChildScrollView clientes() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Column(
        children: controller.clientes
            .map((e) => Card(
                  child: ListTile(
                    onLongPress: () {
                      controller.listnegra(e);
                    },
                    title: Text(
                      e.nombre!,
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Apodo"),
                                  Text(e.apodo!),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Recorrido"),
                                  Text("${e.recorrido}"),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Lista Negra"),
                                  Text("${e.listanegra}"),
                                ]),
                          )
                        ]),
                    /* trailing: IconButton(
                      onPressed: (() {
                        controller.listnegra(e);
                      }),
                      icon: Icon(Icons.close),
                    ), */
                  ),
                ))
            .toList(),
      ),
    );
  }
}
