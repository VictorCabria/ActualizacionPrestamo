import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../utils/palette.dart';
import '../controllers/lineasrecaudos_controller.dart';
import '../widgets/number_box.dart';

final format = DateFormat('yyyy-MM-dd');
final numberFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 1);

class LineasrecaudosView extends GetView<LineasrecaudosController> {
  const LineasrecaudosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: controller.isBuscar.value
                  ? CustomSearch(controller: controller)
                  : Text(controller.isMultiSelectionEnabled.value
                      ? controller.getselesctionrecaudos()
                      : 'Lista de los Recaudos'),
              backgroundColor: Palette.primary,
              centerTitle: true,
              actions: <Widget>[
                controller.isBuscar.value
                    ? IconButton(
                        onPressed: () => controller.buscar(),
                        icon: const Icon(Icons.cancel))
                    : IconButton(
                        onPressed: () => controller.buscar(),
                        icon: const Icon(Icons.search)),
                Visibility(
                  visible: controller.selectedItem.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "Estas seguro que quieres borrar este recaudo"),
                                content: const Text(
                                    "esta accion no se puede deshacer"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Palette.primary)),
                                      child: const Text("Aceptar"),
                                      onPressed: () {
                                        controller.deleterecaudos();
                                        controller.selectedItem.clear();
                                        Get.back();
                                      }),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Palette.primary)),
                                      child: const Text("Cancelar"),
                                      onPressed: () {
                                        Get.back();
                                      }),
                                ],
                              ));
                    },
                  ),
                )
              ],
              leading: controller.isMultiSelectionEnabled.value
                  ? CustomMultiselector(controller: controller)
                  : BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                    ),
              bottom: TabBar(
                onTap: (value) => controller.index.value = value,
                tabs: const [
                  Tab(
                    text: 'Recaudar',
                  ),
                  Tab(
                    text: 'Recaudados',
                  ),
                ],
              ),
            ),
            body: Stack(children: [
              TabBarView(
                  /* physics: NeverScrollableScrollPhysics(), */
                  /* controller: controller.tabController, */
                  children: [recaudar(), recaudados()]),
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
            ]),
            bottomSheet: controller.index.value == 0
                ? Container(
                    color: Palette.secondary,
                    height: 10.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Total Recaudado",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    numberFormat.format(controller.total.value),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Recaudos",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "${controller.numRecaudado} / ${controller.recaudarLines.length}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Palette.secondary,
                    height: 10.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Total Recaudado",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    numberFormat.format(controller.total.value),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Recaudos",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "${controller.recaudarLines.where((p0) => p0.procesado == true).length}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  SingleChildScrollView recaudar() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Column(
        children: controller.recaudarLines
            .where((p0) => p0.procesado == false)
            .map((e) => FutureBuilder(
                future: controller.getClientById(e.idCliente!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Client client = snapshot.data as Client;
                    return Card(
                      child: ListTile(
                        selectedTileColor: Colors.green[100],
                        selected: e.monto! > 0,
                        title: Text(client.nombre!),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.homecontroller.gestorMode.value
                                ? [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fecha"),
                                            Text(format.format(
                                                DateTime.parse(e.fecha!))),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Cuota"),
                                            Text(numberFormat.format(e.monto)),
                                          ]),
                                    ),
                                  ]
                                : [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fecha"),
                                            Text(format.format(
                                                DateTime.parse(e.fecha!))),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Préstamo"),
                                            Text(numberFormat.format(e.total)),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Saldo"),
                                            Text(numberFormat.format(e.saldo)),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Cuota"),
                                            Text(numberFormat.format(e.monto)),
                                          ]),
                                    ),
                                  ]),
                        onTap: () {
                          if (e.saldo! < 0) {
                          } else {
                            showNumericPanel(context, client, e, controller);
                          }
                        },
                      ),
                    );
                  }
                  return Container();
                }))
            .toList(),
      ),
    );
  }

  SingleChildScrollView recaudados() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 9.h),
      child: Column(
        children: controller.recaudarLines
            .where((p0) => p0.procesado == true)
            .map(
              (e) => FutureBuilder(
                future: controller.getClientById(e.idCliente!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Client client = snapshot.data as Client;
                    return Card(
                      color: controller.selectedItem.contains(e)
                          ? Colors.grey[300]
                          : null,
                      child: ListTile(
                        onTap: () {
                          controller.doMultiSelection(e);
                        },
                        onLongPress: () {
                          controller.isMultiSelectionEnabled.value = true;
                          controller.doMultiSelection(e);
                        },
                        title: Text(
                          client.nombre!,
                        ),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.homecontroller.gestorMode.value
                                ? [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fecha"),
                                            Text(format.format(
                                                DateTime.parse(e.fecha!))),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Cuota"),
                                            Text(numberFormat.format(e.monto)),
                                          ]),
                                    )
                                  ]
                                : [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fecha"),
                                            Text(format.format(
                                                DateTime.parse(e.fecha!))),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Préstamo"),
                                            Text(numberFormat.format(e.total)),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Saldo"),
                                            Text(numberFormat.format(e.saldo)),
                                          ]),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Cuota"),
                                            Text(numberFormat.format(e.monto)),
                                          ]),
                                    )
                                  ]),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LineasrecaudosController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          controller.selectedItem.clear();
          controller.isMultiSelectionEnabled.value = false;
        },
        icon: const Icon(Icons.close));
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LineasrecaudosController controller;

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
