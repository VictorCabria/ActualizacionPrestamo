import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/utils/utils.dart';

import '../controllers/registrarcliente_controller.dart';

class RegistrarclienteView extends GetView<RegistrarclienteController> {
  const RegistrarclienteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: const Text("Registrar Clientes"),
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

  final RegistrarclienteController controller;

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
              validator: (value) {
                return controller.validateNombre(value!);
              },
              onSaved: (value) {
                controller.nombresController.text = value!;
              },
              textInputAction: TextInputAction.next,
              controller: controller.nombresController,
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
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
              ),
            )),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.name,
              validator: (value) {
                return controller.validatepin(value!);
              },
              onSaved: (value) {
                controller.recorridocontroller.text = value!;
              },
              textInputAction: TextInputAction.next,
              controller: controller.recorridocontroller,
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.red,
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
                labelStyle: TextStyle(color: Palette.primary),
              ),
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
                controller.addclient();
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

  final RegistrarclienteController controller;

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
              keyboardType: TextInputType.phone,
              controller: controller.cedulacontroller,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.cedulacontroller.text = value!;
              },
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
            controller: controller.apodocontroller,
            validator: (value) {
              return controller.validateapodo(value!);
            },
            onSaved: (value) {
              controller.apodocontroller.text = value!;
            },
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
                borderSide: BorderSide(
                  color: Colors.red,
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
              keyboardType: TextInputType.name,
              controller: controller.emaileditController,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.emaileditController.text = value!;
              },
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
              autofocus: false,
              keyboardType: TextInputType.phone,
              controller: controller.telefonocontroller,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.telefonocontroller.text = value!;
              },
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
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.direccioncontroller.text = value!;
              },
              textInputAction: TextInputAction.next,
              controller: controller.direccioncontroller,
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
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => DropdownButtonFormField<Barrio>(
                items: controller.barriocontroller.map((items) {
                  return DropdownMenuItem<Barrio>(
                      value: items, child: Text(' ${items.nombre}'));
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
                onChanged: controller.onChangeDorpdown),
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
                controller.addclient();
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
