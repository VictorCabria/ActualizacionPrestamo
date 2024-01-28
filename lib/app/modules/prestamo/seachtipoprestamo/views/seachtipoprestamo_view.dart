import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/palette.dart';
import '../controllers/seachtipoprestamo_controller.dart';

class SeachtipoprestamoView extends GetView<SeachtipoprestamoController> {
  const SeachtipoprestamoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.isBuscar.value
                ? CustomSearch(controller: controller)
                : Text('Buscar tipo de prestamo'),
            centerTitle: true,
            backgroundColor: Palette.primary,
            actions: <Widget>[
              controller.isBuscar.value
                  ? IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.cancel))
                  : IconButton(
                      onPressed: () => controller.buscar(),
                      icon: const Icon(Icons.search)),
            ],
          ),
          body: GetX<SeachtipoprestamoController>(
            builder: (b) => b.isloading.value
                ? const CircularProgressIndicator()
                : ListView(
                    children: b.typeprestamoget
                        .map(
                          (element) => SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 1,
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Palette.primary,
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                   Get.toNamed(Routes.REGISTRARPRESTAMOS); 
                },
              ),
            ],
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.controller, required this.s})
      : super(key: key);

  final SeachtipoprestamoController controller;

  final Rx<TypePrestamo> s;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: ListTile(
        onTap: () {
          controller.doSelection(s.value);
        },
        title: Text(s.value.nombre!, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SeachtipoprestamoController controller;

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
