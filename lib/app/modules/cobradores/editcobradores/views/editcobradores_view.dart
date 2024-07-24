import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/palette.dart';
import '../controllers/editcobradores_controller.dart';

class EditcobradoresView extends GetView<EditcobradoresController> {
  const EditcobradoresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: const Text("Editar Cobradores"),
          centerTitle: true,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Form(
          key: controller.formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 27),
            child: Column(
              children: [
                TabBar(
                  controller: controller.tabController,
                  labelColor: Palette.primary,
                  indicatorColor: Palette.primary,
                  tabs: const [
                    Tab(text: "Obligatorio"),
                    Tab(text: "Opcionales"),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Page1(controller: controller),
                    Page2(controller: controller),
                  ],
                ))
              ],
            ),
          ),
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

  final EditcobradoresController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              initialValue: controller.cobrador.nombre,
              onChanged: (value) => controller.nombre.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle, color: Palette.primary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Palette.primary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Palette.primary,
                  ),
                ),
                labelText: "Nombre",
                fillColor: Palette.primary,
                labelStyle: TextStyle(color: Palette.primary),
              )),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.name,
            initialValue: controller.cobrador.correo,
            onChanged: (value) => controller.correo.value = value,
            textInputAction: TextInputAction.next,
            cursorColor: Palette.primary,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.account_circle, color: Palette.primary),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Palette.primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              labelText: "Correo",
              fillColor: Palette.primary,
              labelStyle: TextStyle(color: Palette.primary),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            initialValue: controller.cobrador.pin,
            onChanged: (value) => controller.pin.value = value,
            textInputAction: TextInputAction.next,
            cursorColor: Palette.primary,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.account_circle, color: Palette.primary),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Palette.primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Palette.primary,
                ),
              ),
              labelText: "Pin",
              fillColor: Palette.primary,
              labelStyle: TextStyle(color: Palette.primary),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Atras",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.editcobradores();
              },
              child: const Text(
                "Guardar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final EditcobradoresController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => !controller.loading.value
                ? DropdownButtonFormField<String>(
                    items: controller.edittipocedulacontroller.map((items) {
                      return DropdownMenuItem<String>(
                          value: items.id, child: Text(' ${items.cedula}'));
                    }).toList(),
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.account_circle, color: Palette.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          ),
                        ),
                        labelText: "Tipo de cedula",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.editcedula?.id,
                    onChanged: controller.onChangeDorpdowncedula)
                : const CircularProgressIndicator(),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              initialValue: controller.cobrador.cedula,
              onChanged: (value) => controller.nombre.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.art_track_sharp, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Cedula",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              initialValue: controller.cobrador.apellido,
              onChanged: (value) => controller.apellido.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.art_track_sharp, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Apellidos",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              initialValue: controller.cobrador.direccion,
              onChanged: (value) => controller.direccion.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Direccion",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => !controller.loading.value
                ? DropdownButtonFormField<String>(
                    items: controller.edittipobarriocontroller.map((items) {
                      return DropdownMenuItem<String>(
                          value: items.id, child: Text(' ${items.nombre}'));
                    }).toList(),
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.account_circle, color: Palette.primary),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          borderSide: BorderSide(
                            color: Palette.primary,
                          ),
                        ),
                        labelText: "Barrio",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.editbarrio?.id,
                    onChanged: controller.onChangeDorpdownbarrio)
                : const CircularProgressIndicator(),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              initialValue: controller.cobrador.telefono,
              onChanged: (value) => controller.telefono.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Telefono",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              initialValue: controller.cobrador.cedula,
              onChanged: (value) => controller.cedula.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.add_home_work_sharp, color: Palette.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                    borderSide: BorderSide(
                      color: Palette.primary,
                    ),
                  ),
                  labelText: "Celular",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.tabController.animateTo(0);
              },
              child: const Text(
                "Atras",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.editcobradores();
              },
              child: const Text(
                "Guardar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
