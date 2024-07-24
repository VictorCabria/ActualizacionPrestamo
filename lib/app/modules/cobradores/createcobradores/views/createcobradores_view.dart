import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../models/barrio_modal.dart';
import '../../../../models/cedula_modal.dart';
import '../../../../utils/palette.dart';
import '../controllers/createcobradores_controller.dart';

class CreatecobradoresView extends GetView<CreatecobradoresController> {
  const CreatecobradoresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          title: const Text("Registrar Cobradores"),
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

  final CreatecobradoresController controller;

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
            controller: controller.nombresController,
            validator: ((value) {
              return controller.validateNombre(value!);
            }),
            onSaved: (value) {
              controller.nombresController.text = value!;
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
              labelText: "Nombre",
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
            validator: ((value) {
              return controller.validateEmailedit(value!);
            }),
            onSaved: (value) {
              controller.correocontroller.text = value!;
            },
            textInputAction: TextInputAction.next,
            controller: controller.correocontroller,
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
              maxLength: 4,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                controller.pincontroller.text = value!;
              },
              validator: (value) {
                final intNumber = int.tryParse(value!);
                if (intNumber != null && intNumber == 4) {
                  return null;
                }
                return ('Ingrese 4 digitos');
              },
              textInputAction: TextInputAction.next,
              controller: controller.pincontroller,
              cursorColor: Palette.primary,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.pin, color: Palette.primary),
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
                labelText: "Pin",
                fillColor: Palette.primary,
                labelStyle: TextStyle(color: Palette.primary),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
        ),
        const SizedBox(height: 20),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Admin",
              style: TextStyle(color: Palette.primary),
            ),
            value: controller.admincobrador.value,
            activeColor: Palette.primary,
            onChanged: ((value) {
              controller.admincobrador.value = value!;
            }))),
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
                controller.addcobradores();
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

  final CreatecobradoresController controller;

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
            () => DropdownButtonFormField(
                items: controller.cedulalistcontroller.map((items) {
                  return DropdownMenuItem<Cedula>(
                      value: items, child: Text(' ${items.cedula}'));
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
                onChanged: controller.onChangeDorpdown),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              controller: controller.cedulacontroller,
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
              controller: controller.apellidocontroller,
              onSaved: (value) {
                controller.apellidocontroller.text = value!;
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
              controller: controller.direccioncontroller,
              onSaved: (value) {
                controller.direccioncontroller.text = value!;
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
                  labelText: "Direccion",
                  fillColor: Palette.primary,
                  labelStyle: TextStyle(color: Palette.primary)),
            )),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => DropdownButtonFormField(
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
                onChanged: controller.onChangeDorpdown2),
          ),
        ),
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
              keyboardType: TextInputType.phone,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                controller.celularcontroller.text = value!;
              },
              textInputAction: TextInputAction.next,
              controller: controller.celularcontroller,
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
                controller.addcobradores();
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
