import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/text_styles.dart';
import '../controllers/panelrecaudos_controller.dart';

class PanelrecaudosView extends GetView<PanelrecaudosController> {
  const PanelrecaudosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.primary,
              title: controller.isBuscar.value
                  ? CustomSearch(controller: controller)
                  : Text(
                      controller.isMultiSelectionEnabled.value
                          ? controller.getSelectedtransacciones()
                          : 'Recaudos',
                    ),
              centerTitle: true,
              actions: <Widget>[
                controller.isBuscar.value
                    ? IconButton(
                        onPressed: () => controller.buscar(),
                        icon: const Icon(Icons.cancel))
                    : IconButton(
                        onPressed: () => controller.buscar(),
                        icon: const Icon(Icons.search)),
                PopupMenuButton(
                  icon: Icon(
                    Icons.filter_list,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 0, child: Text("Autorizados")),
                    const PopupMenuItem(value: 1, child: Text("Pendientes")),
                    const PopupMenuItem(value: 2, child: Text("Todos")),
                  ],
                  onSelected: (value) {
                    controller.filtrarlist(value);
                  },
                ),
                Visibility(
                  visible: controller.selectedItem.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                    "Estas seguro que quieres borrar este Recaudo"),
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
                                      })
                                ],
                              ));
                    },
                  ),
                ),
              ],
              leading: controller.isMultiSelectionEnabled.value
                  ? CustomMultiselector(controller: controller)
                  : BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Get.back();
                      },
                    ),
            ),
            body: Obx(
              () => controller.loading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      color: Palette.secondary,
                      height: 200.h,
                      child: CustomScrollView(
                        controller: controller.scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.h,
                                vertical: 2.h,
                              ),
                              child: GestureDetector(
                                onTap: () =>
                                    controller.homecontroller.session == null
                                        ? Get.dialog(const AlertDialog(
                                            content:
                                                Text("Debes crear una sesion"),
                                          ))
                                        : controller.homecontroller.session!
                                                    .estado !=
                                                StatusSession.closed.name
                                            ? controller.createrecaudo()
                                            : controller.homecontroller.session!
                                                        .estado !=
                                                    StatusSession.open.name
                                                ? Get.dialog(const AlertDialog(
                                                    content: Text(
                                                        "No hay una sesion activa"),
                                                  ))
                                                : "",
                                child: Card(
                                  child: Container(
                                    height: 22.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 2.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "assets/icons/dashboard.png",
                                          scale: 1.5,
                                        ),
                                        SizedBox(width: 5.h),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: controller.isNulll.value
                                                  ? [
                                                      Text(
                                                        "Crear Nueva recaudo",
                                                        style: styles.tittle,
                                                      )
                                                    ]
                                                  : [
                                                      const Spacer(flex: 4),
                                                      FittedBox(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: controller
                                                                  .homecontroller
                                                                  .gestorMode
                                                                  .value
                                                              ? [
                                                                  Text(
                                                                    "Fecha de Recaudo: ${controller.fecha}",
                                                                    style: styles
                                                                        .tittle,
                                                                  ),
                                                                  Text(
                                                                    "Estado: ${controller.getEstado()}",
                                                                    style: styles
                                                                        .tittleSub,
                                                                  ),
                                                                ]
                                                              : [
                                                                  Text(
                                                                    "Fecha de Recaudo: ${controller.fecha}",
                                                                    style: styles
                                                                        .tittle,
                                                                  ),
                                                                  Text(
                                                                    "Estado: ${controller.getEstado()}",
                                                                    style: styles
                                                                        .tittleSub,
                                                                  ),
                                                                  Text(
                                                                    "Cantidad: ${controller.recaudodoLines.length}",
                                                                    style: styles
                                                                        .tittleSub,
                                                                  ),
                                                                  Text(
                                                                    "Total recaudado: ${controller.totalrecaudos}",
                                                                    style: styles
                                                                        .tittleSub,
                                                                  ),
                                                                ],
                                                        ),
                                                      ),
                                                      const Spacer(flex: 1),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          controller
                                                                  .isOpen.value
                                                              ? TextButton(
                                                                  onPressed: () => controller
                                                                              .homecontroller
                                                                              .session ==
                                                                          null
                                                                      ? Get.dialog(
                                                                          const AlertDialog(
                                                                          content:
                                                                              Text("Debes crear una sesion"),
                                                                        ))
                                                                      : controller.homecontroller.session!.estado !=
                                                                              StatusSession.closed.name
                                                                          ? controller.closerecaudo()
                                                                          : controller.homecontroller.session!.estado != StatusSession.open.name
                                                                              ? Get.dialog(const AlertDialog(
                                                                                  content: Text("No hay una sesion activa"),
                                                                                ))
                                                                              : "",
                                                                  child:
                                                                      const Text(
                                                                    "Cerrar Recaudo",
                                                                    style:
                                                                        TextStyle(
                                                                      textBaseline:
                                                                          TextBaseline
                                                                              .ideographic,
                                                                    ),
                                                                  ),
                                                                )
                                                              : TextButton(
                                                                  onPressed: () => controller
                                                                              .homecontroller
                                                                              .session ==
                                                                          null
                                                                      ? Get.dialog(
                                                                          const AlertDialog(
                                                                          content:
                                                                              Text("Debes crear una sesion"),
                                                                        ))
                                                                      : controller.homecontroller.session!.estado !=
                                                                              StatusSession.closed.name
                                                                          ? controller.createrecaudo()
                                                                          : controller.homecontroller.session!.estado != StatusSession.open.name
                                                                              ? Get.dialog(const AlertDialog(
                                                                                  content: Text("No hay una sesion activa"),
                                                                                ))
                                                                              : "",
                                                                  child:
                                                                      const Text(
                                                                    "Crear Nuevo recaudo",
                                                                    style:
                                                                        TextStyle(
                                                                      textBaseline:
                                                                          TextBaseline
                                                                              .ideographic,
                                                                    ),
                                                                  ),
                                                                ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              controller.recaudos!
                                                                          .estado !=
                                                                      StatusRecaudo
                                                                          .closed
                                                                          .name
                                                                  ? TextButton(
                                                                      onPressed: () => controller.homecontroller.session ==
                                                                              null
                                                                          ? Get.dialog(
                                                                              const AlertDialog(
                                                                              content: Text("Debes crear una sesion"),
                                                                            ))
                                                                          : controller.homecontroller.session!.estado != StatusSession.closed.name
                                                                              ? controller.recaudar()
                                                                              : controller.homecontroller.session!.estado != StatusSession.open.name
                                                                                  ? Get.dialog(const AlertDialog(
                                                                                      content: Text("No hay una sesion activa"),
                                                                                    ))
                                                                                  : "",
                                                                      child:
                                                                          const Text(
                                                                        "Recaudar",
                                                                        style:
                                                                            TextStyle(
                                                                          textBaseline:
                                                                              TextBaseline.ideographic,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container()
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // SessionWidget(),
                          // const SizedBox(height: 20),
                          SliverToBoxAdapter(
                              child: Container(
                            margin: const EdgeInsets.fromLTRB(160, 10, 10, 10),
                            child: Row(
                              children: const [
                                Text('Recaudos',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ],
                            ),
                          )),
                          SliverToBoxAdapter(
                              child: Container(
                            child: GetX<PanelrecaudosController>(
                              builder: (b) => b.isloading.value
                                  ? const CircularProgressIndicator()
                                  : SingleChildScrollView(
                                      child: Column(
                                          children: b.recaudoget
                                              .map(
                                                (element) => SizedBox(
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      CustomCard(
                                                        controller: b,
                                                        s: element.obs,
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
                            ),
                          ))
                        ],
                      ),
                    ),
            ),
          ),
          controller.cargando.value == true
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
        ],
      ),
    );
  }
}

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PanelrecaudosController controller;

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

  final PanelrecaudosController controller;

  final Rx<Recaudo> s;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (Container(
        color: controller.selectedItem.contains(s.value) ? Colors.grey : null,
        child: ListTile(
            onTap: () {
              controller.doMultiSelection(s.value);
            },
            onLongPress: () {
              controller.isMultiSelectionEnabled.value = true;
              controller.doMultiSelection(s.value);
            },
            title: FutureBuilder(
                future: controller.getcobradoresId(s.value.cobradorId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Cobradores cobradores = snapshot.data as Cobradores;
                    return Text(cobradores.nombre!,
                        style: const TextStyle(fontSize: 18));
                  } else {
                    return const Text("");
                  }
                }),
            isThreeLine: true,
            subtitle: Text(
                ('Fecha: ${s.value.fecha != null ? DateFormat("dd/MM/yyyy-hh:mm aa").format(DateTime.parse("${s.value.fecha}")) : ""}'
                        "\n") +
                    (s.value.confirmacion! == "passed"
                        ? "Autorizado"
                        : s.value.confirmacion! == "nopassed"
                            ? "Pendiente"
                            : ""),
                style: const TextStyle(fontSize: 15)),
            trailing: FutureBuilder(
                future: controller.monto(s.value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("result snapshot ${snapshot.data}");
                    return Text(
                        ("Recaudos: ${controller.cantidad(s.value) == null ? "0" : "${controller.cantidad(s.value)}"}"
                                "\n") +
                            ("\n" "Recaudado ${snapshot.data.toString()}"));
                  } else {
                    print(snapshot.data.toString());
                    return const Text('0');
                  }
                })
            /* Text(
              ("Recaudos ${controller.numRecaudado} / ${controller.recaudodoLines.length}"
                      "\n"),
                  
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), */
            ),
      )),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PanelrecaudosController controller;

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
