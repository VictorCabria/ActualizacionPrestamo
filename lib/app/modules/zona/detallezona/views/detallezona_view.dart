import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../models/barrio_modal.dart';
import '../../../../utils/palette.dart';
import '../controllers/detallezona_controller.dart';

class DetallezonaView extends GetView<DetallezonaController> {
  const DetallezonaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del zona'),
        backgroundColor: Palette.primary,
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isloading.value
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  const SizedBox(width: 3),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.primary)),
                          onPressed: () {
                            controller.editarzone(controller.zone!);
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
                    child: Container(
                      child: ListTile(
                        title: Text("Nombre: ${controller.zone!.nombre!}"),
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
                                  Tab(text: "Barrios"),
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
                        ))),
                  ))
                ],
              ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final DetallezonaController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<DetallezonaController>(
      builder: (b) => b.isloading.value
          ? const CircularProgressIndicator()
          : ListView(
              children: controller.barriosget
                  .map(
                    (element) => SizedBox(
                      child: Column(
                        children: [
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
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final DetallezonaController controller;
  final Barrio s;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            )),
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
                                'Nombre',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${s.nombre} ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
