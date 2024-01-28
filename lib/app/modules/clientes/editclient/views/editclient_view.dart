import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/palette.dart';
import '../controllers/editclient_controller.dart';

class EditclientView extends GetView<EditclientController> {
  const EditclientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Editar Cliente"),
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
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final EditclientController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              initialValue: controller.client.nombre,
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) => controller.nombre.value = value,
              cursorColor: Palette.primary,
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
                  labelText: "Nombre",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              initialValue: controller.client.recorrido,
              autofocus: false,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) => controller.recorrido.value = value,
              cursorColor: Palette.primary,
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
                  labelText: "Recorrido",
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
                controller.editclient();
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

  final EditclientController controller;

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
              initialValue: controller.client.cedula,
              autofocus: false,
              keyboardType: TextInputType.phone,
              onChanged: (value) => controller.cedula.value = value,
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
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              initialValue: controller.client.apodo,
              autofocus: false,
              keyboardType: TextInputType.name,
              onChanged: (value) => controller.apodo.value = value,
              textInputAction: TextInputAction.next,
              cursorColor: Palette.primary,
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
                  labelText: "Apodo",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              initialValue: controller.client.correo,
              autofocus: false,
              keyboardType: TextInputType.name,
              onChanged: (value) => controller.email.value = value,
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
                  labelText: "Email",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              initialValue: controller.client.telefono,
              autofocus: false,
              keyboardType: TextInputType.phone,
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
              initialValue: controller.client.direccion,
              autofocus: false,
              keyboardType: TextInputType.name,
              onChanged: (value) => controller.direccion.value = value,
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
                  labelText: "Direccion",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Obx(
          () => !controller.loading.value
              ? DropdownButtonFormField<String>(
                  items: controller.barriocontroller.map((items) {
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
                  value: controller.selectbarrio?.id,
                  onChanged: controller.onChangeDorpdown)
              : const CircularProgressIndicator(),
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
                controller.editclient();
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
