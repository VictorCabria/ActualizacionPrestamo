import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/palette.dart';
import '../controllers/list_prestamo_controller.dart';

final formatFecha = DateFormat("dd/MM/yyyy");

class ListPrestamoView extends GetView<ListPrestamoController> {
  const ListPrestamoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: controller.isBuscar.value
              ? CustomSearch(controller: controller)
              : Text(controller.isMultiSelectionEnabled.value
                  ? controller.getSelectedPrestamos()
                  : "Prestamos"),
          actions: <Widget>[
            controller.isBuscar.value
                ? IconButton(
                    onPressed: () => controller.buscar(),
                    icon: const Icon(Icons.cancel))
                : IconButton(
                    onPressed: () => controller.buscar(),
                    icon: const Icon(Icons.search)),
            PopupMenuButton(
              icon: const Icon(
                Icons.filter_list,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 0, child: Text("Al Dia")),
                const PopupMenuItem(value: 1, child: Text("Atrasado")),
                const PopupMenuItem(value: 2, child: Text("Vencido")),
                const PopupMenuItem(value: 3, child: Text("Refinanciados")),
                const PopupMenuItem(value: 4, child: Text("Renovados")),
                const PopupMenuItem(value: 5, child: Text("Pagados")),
                const PopupMenuItem(value: 6, child: Text("Pendientes")),
                const PopupMenuItem(value: 7, child: Text("Todos")),
              ],
              onSelected: (value) {
                controller.filtrarlist(value);
              },
            ),
            /*     IconButton(
                onPressed: () {
                    controller.agregar(); 
                },
                icon: Icon(Icons.sync)), */
            Visibility(
              visible: controller.selectedItem.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "Estas seguro que quieres borrar este Prestamo?"),
                            content:
                                const Text("esta accion no se puede deshacer"),
                            actions: <Widget>[
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Palette.primary)),
                                  child: const Text("Aceptar"),
                                  onPressed: () {
                                    controller.delete();
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
            ),
            Visibility(
              visible: controller.selectedItem.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.list_alt),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "Estas seguro que quieres añadir este prestamo a la lista negra"),
                            actions: <Widget>[
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Palette.primary)),
                                  child: const Text("Aceptar"),
                                  onPressed: () {
                                    controller.listnegra();
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
                                  })
                            ],
                          ));
                },
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Palette.primary,
          leading: controller.isMultiSelectionEnabled.value
              ? CustomMultiselector(controller: controller)
              : BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
        ),
        body: Stack(children: [
          GetX<ListPrestamoController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    padding: EdgeInsets.only(bottom: 9.h),
                    /*  padding: EdgeInsets.fromLTRB(0, 0, 0, 60),  */
                    children: controller.prestamosget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                CustomCard(
                                  controller: b,
                                  s: element.obs,
                                ),
                                const Divider(
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
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
        ]),
        bottomSheet: Container(
          color: Palette.secondary,
          height: 10.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5.w),
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Palette.primary,
                        child: IconButton(
                            onPressed: () => controller.createPrestamo(),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ]),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Prestamos",
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
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Prestamo + int",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("${controller.montointeres}",
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
                      const Text("Prestamos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("${controller.prestamos.length}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ],
          ),
        )
        /*  floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                  backgroundColor: Palette.primary,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => controller.createPrestamo())
            ],
          ), */
        ));
  }
}

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListPrestamoController controller;

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

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final ListPrestamoController controller;

  final Rx<Prestamo> s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black45,
          ),
        ),
        child: Container(
          color: controller.selectedItem.contains(s.value)
              ? Colors.grey[300]
              : null,
          child: ListTile(
            onTap: () {
              controller.doMultiSelection(s.value);
            },
            onLongPress: () {
              controller.isMultiSelectionEnabled.value = true;
              controller.doMultiSelection(s.value);
            },
            title: FutureBuilder(
                future: controller.getClientById(s.value.clienteId!),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[500],
                                borderRadius: BorderRadius.circular(4)),
                            child: FutureBuilder(
                                future: controller
                                    .getClientById(s.value.clienteId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Client client = snapshot.data as Client;
                                    return Text(
                                      (client.recorrido!),
                                      style: const TextStyle(fontSize: 20),
                                    );
                                  } else {
                                    return const Text("");
                                  }
                                }),
                          ),
                          const SizedBox(width: 10),
                          FutureBuilder(
                              future: controller
                                  .gettipoprestamoById(s.value.tipoPrestamoId!),
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
                    ),
                    const Divider(thickness: 0.5, height: 20),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${s.value.fecha}',
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5, height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cuotas: ${s.value.numeroDeCuota} ',
                                    style: const TextStyle(
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
                                      child: s.value.estado ==
                                              StatusPrestamo.aldia.name
                                          ? Container(
                                              height: 20,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.green[500],
                                              ),
                                              child: (const Center(
                                                child: Text("Al Dia",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                            )
                                          : s.value.estado ==
                                                  StatusPrestamo.atrasado.name
                                              ? Container(
                                                  height: 20,
                                                  width: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 204, 186, 26),
                                                  ),
                                                  child: (const Center(
                                                    child: Text("Atrasado",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  )),
                                                )
                                              : s.value.estado ==
                                                      StatusPrestamo
                                                          .vencido.name
                                                  ? Container(
                                                      height: 20,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red[500],
                                                      ),
                                                      child: (const Center(
                                                        child: Text("Vencido",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      )),
                                                    )
                                                  : s.value.estado ==
                                                          StatusPrestamo
                                                              .refinanciado.name
                                                      ? Container(
                                                          height: 20,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[500],
                                                          ),
                                                          child: (const Center(
                                                            child: Text(
                                                                "Refinanciado",
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
                                                      : s.value.estado ==
                                                              StatusPrestamo
                                                                  .pagado.name
                                                          ? Container(
                                                              height: 20,
                                                              width: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .blue[900],
                                                              ),
                                                              child:
                                                                  (const Center(
                                                                child: Text(
                                                                    "Pagado",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              )),
                                                            )
                                                          : s.value.estado ==
                                                                  StatusPrestamo
                                                                      .renovado
                                                                      .name
                                                              ? Container(
                                                                  height: 20,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                  ),
                                                                  child:
                                                                      (const Center(
                                                                    child: Text(
                                                                        "Renovado",
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${s.value.monto} ',
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5, height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'V. cuota: ${s.value.valorCuota} ',
                                    style: const TextStyle(
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
                                    child: s.value.listanegra == true
                                        ? Container(
                                            height: 20,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.black87,
                                            ),
                                            child: (const Center(
                                              child: Text("Lista Negra",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                              /* Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future:
                                          controller.consultarpagados(s.value),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "Pagadas: ${snapshot.data.toString()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          print(snapshot.data.toString());
                                          return const Text('');
                                        }
                                      })
                                ],
                              ), */
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${s.value.saldoPrestamo!.toStringAsFixed(2)} ',
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5, height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total: ${s.value.totalPrestamo} ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future: controller
                                          .getClientById(s.value.clienteId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Client client =
                                              snapshot.data as Client;
                                          return Text(
                                              (client.barrio!["zona"] ??
                                                  "No asignado"),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold));
                                        } else {
                                          return const Text("");
                                        }
                                      }),
                                ],
                              ),
                              /* Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                      future:
                                          controller.consultarcuotas(s.value),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "Restantes: ${snapshot.data.toString()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          print(snapshot.data.toString());
                                          return const Text('');
                                        }
                                      })
                                ],
                              ), */
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                    /* const SizedBox(height: 10),
                    Container(
                        child: const Text("Proximo Pago",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(height: 5),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${s.fechaPago}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ), */
                    SizedBox(
                      height: 2.h,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListPrestamoController controller;

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
