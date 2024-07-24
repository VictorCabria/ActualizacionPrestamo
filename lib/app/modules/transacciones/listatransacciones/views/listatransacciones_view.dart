import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/concepto_model.dart';
import '../../../../models/transaction_model.dart';
import '../../../../utils/palette.dart';
import '../controllers/listatransacciones_controller.dart';

class ListatransaccionesView extends GetView<ListatransaccionesController> {
  const ListatransaccionesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: controller.isBuscar.value
              ? CustomSearch(controller: controller)
              : Text(controller.isMultiSelectionEnabled.value
                  ? controller.getSelectedtransacciones()
                  : "Lista de Transacciones"),
          actions: <Widget>[
            controller.isBuscar.value
                ? IconButton(
                    onPressed: () => controller.buscar(),
                    icon: const Icon(Icons.cancel))
                : IconButton(
                    onPressed: () => controller.buscar(),
                    icon: const Icon(Icons.search)),
            PopupMenuButton(
              icon: const Icon(Icons.filter_list),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PopupMenuButton>>[
                PopupMenuItem(
                  child: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return controller.cobradoresget.map((choice) {
                          return PopupMenuItem(
                            value: choice.nombre,
                            child: Text("${choice.nombre}"),
                          );
                        }).toList();
                      },
                      onSelected: controller.filtrarlist,
                      child: const Text('Cobradores')),
                ),
                PopupMenuItem(
                    child: PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'todos',
                                child: Text("Todos"),
                              )
                            ],
                        onSelected: controller.filtrarlist,
                        child: const Text('Todos')))
              ],
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
                                "Estas seguro que quieres borrar esta transaccion"),
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
          GetX<ListatransaccionesController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    padding: EdgeInsets.only(bottom: 9.h),
                    children: b.transaccionesget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 1,
                                ),
                                CustomCard(
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
                            onPressed: () => controller.createtransacciones(),
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
                      const Text("Total Transacciones",
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
                      const Text("Transacciones",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      Text("${controller.transacciones.length}",
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

class CustomMultiselector extends StatelessWidget {
  const CustomMultiselector({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ListatransaccionesController controller;

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

  final ListatransaccionesController controller;

  final Transacciones s;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: ListTile(
        onTap: () {
          controller.doMultiSelection(s);
        },
        onLongPress: () {
          controller.isMultiSelectionEnabled.value = true;
          controller.doMultiSelection(s);
        },
        title: FutureBuilder(
            future: controller.getconceptoById(s.concept!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Concepto concepto = snapshot.data as Concepto;
                return Text(
                  (concepto.nombre!),
                  style: const TextStyle(fontSize: 18),
                );
              } else {
                return const Text("");
              }
            }),
        isThreeLine: true,
        subtitle: FutureBuilder(
            future: controller.getcobradoresId(s.cobrador!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Cobradores cobradores = snapshot.data as Cobradores;
                return Text(
                    ('''Tercero: ${cobradores.nombre}''' "\n") +
                        ('''Fecha: ${s.fecha != null ? DateFormat("dd/MM/yyyy").format(DateTime.parse("${s.fecha}").toLocal()) : ""}'''
                            "\n") +
                        ('''Valor: ${s.valor!}'''),
                    style: const TextStyle(fontSize: 15));
              } else {
                return const Text("");
              }
            }),
        trailing: SizedBox(
          width: 100,
          child: Stack(alignment: Alignment.centerRight, children: <Widget>[
            Visibility(
                visible: controller.isMultiSelectionEnabled.value,
                child: Icon(
                  controller.selectedItem.contains(s)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  size: 30,
                  color: Palette.primary,
                )),
          ]),
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

  final ListatransaccionesController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
