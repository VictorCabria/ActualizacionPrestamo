import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/concepto_model.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/palette.dart';
import '../controllers/ajustes_controller.dart';

class AjustesView extends GetView<AjustesController> {
  const AjustesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ajustes de ${controller.homeControll.cobrador}",
          ),
          centerTitle: true,
          backgroundColor: Palette.primary,
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Form(
          key: controller.formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                TabBar(
                  labelColor: Palette.primary,
                  controller: controller.tabController,
                  indicatorColor: Palette.primary,
                  tabs: const [
                    Tab(
                      text: "Conf General",
                    ),
                    Tab(text: "Conf de Prestamo"),
                    Tab(text: "Refinanciacion"),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Page1(controller: controller),
                    Page2(controller: controller),
                    Page3(controller: controller)
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

  final AjustesController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GetBuilder<AjustesController>(
                id: 'positivo',
                builder: (manual) => DropdownButtonFormField(
                    items: controller.conceptocontroller.map((items) {
                      return DropdownMenuItem<Concepto>(
                          value: items, child: Text(' ${items.nombre}'));
                    }).toList(),
                    isExpanded: true,
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
                        labelText: "Ajuste Session(+)",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.selectpositiva,
                    onChanged: controller.onChangepositiva),
              )),
          Expanded(
              child: IconButton(
            onPressed: () {
              Get.toNamed(Routes.CREATECONCEPTOS);
            },
            icon: const Icon(
              Icons.add_outlined,
              color: Palette.primary,
            ),
          ))
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GetBuilder<AjustesController>(
                id: 'negativo',
                builder: (manual) => DropdownButtonFormField(
                    items: controller.conceptocontroller.map((items) {
                      return DropdownMenuItem<Concepto>(
                          value: items, child: Text(' ${items.nombre}'));
                    }).toList(),
                    isExpanded: true,
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
                        labelText: "Ajuste Session(-)",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.selectnegativa,
                    onChanged: controller.onChangenegativa),
              )),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.add_outlined, color: Palette.primary),
            onPressed: (() {
              Get.toNamed(Routes.CREATECONCEPTOS);
            }),
          ))
        ]),
        const SizedBox(height: 15),
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
                "Cancelar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.editajustes();
              },
              child: const Text(
                "Aplicar",
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

  final AjustesController controller;

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
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            initialValue: controller.monto.toString(),
            onChanged: (value) {
              controller.monto.value = double.parse(value);
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Palette.primary,
                  ),
                ),
                labelText: "Monto",
                fillColor: Palette.primary,
                labelStyle: TextStyle(color: Palette.primary)),
          ),
        ),
        const SizedBox(height: 15),
        Row(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GetBuilder<AjustesController>(
                id: 'tipoprestamo',
                builder: (manual) => DropdownButtonFormField(
                    isExpanded: true,
                    items: controller.tipoPrestamoscontroller.map((items) {
                      return DropdownMenuItem<TypePrestamo>(
                          value: items,
                          child: Text(
                            ' ${items.nombre}',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ));
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
                        labelText: "Tipo",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.selecttipoPrestamos,
                    onChanged: controller.onChangeDorpdowntipo),
              )),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.add_outlined, color: Palette.primary),
            onPressed: () {
              Get.toNamed(Routes.REGISTRARPRESTAMOS);
            },
          ))
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GetBuilder<AjustesController>(
                id: 'concepto',
                builder: (manual) => DropdownButtonFormField(
                    items: controller.conceptocontroller.map((items) {
                      return DropdownMenuItem<Concepto>(
                          value: items, child: Text(' ${items.nombre}'));
                    }).toList(),
                    isExpanded: true,
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
                        labelText: "Concepto de prestamo",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.selectconcepto,
                    onChanged: controller.onChangeDorpdown),
              )),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.add_outlined, color: Palette.primary),
            onPressed: () {
              Get.toNamed(Routes.CREATECONCEPTOS);
            },
          ))
        ]),
        const SizedBox(height: 15),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            initialValue: controller.diasprimercobro.toString(),
            onChanged: (value) {
              controller.diasprimercobro.value = int.parse(value);
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Palette.primary,
                  ),
                ),
                labelText: "Dias para el primer cobro",
                fillColor: Palette.primary,
                labelStyle: TextStyle(color: Palette.primary)),
          ),
        ),
        const SizedBox(height: 15),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Cobrar Sabados",
              style: TextStyle(color: Palette.primary),
            ),
            value: controller.cobrarsabado.value,
            activeColor: Palette.primary,
            onChanged: ((value) {
              controller.cobrarsabado.value = value!;
            }))),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Cobrar Domingos",
              style: TextStyle(color: Palette.primary),
            ),
            value: controller.cobrardomingo.value,
            activeColor: Palette.primary,
            onChanged: ((value) {
              controller.cobrardomingo.value = value!;
            }))),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {},
              child: const Text(
                "Cancelar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.editajustes();
              },
              child: const Text(
                "Aplicar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final AjustesController controller;

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
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            initialValue: controller.refinacion.toString(),
            onChanged: (value) {
              controller.refinacion.value = int.parse(value);
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(
                    color: Palette.primary,
                  ),
                ),
                labelText: "Nº días vencidos para Refinanciar",
                fillColor: Palette.primary,
                labelStyle: TextStyle(color: Palette.primary)),
          ),
        ),
        const SizedBox(height: 15),
        Row(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GetBuilder<AjustesController>(
                id: 'refinanciacion',
                builder: (manual) => DropdownButtonFormField(
                    items: controller.conceptocontroller.map((items) {
                      return DropdownMenuItem<Concepto>(
                          value: items, child: Text(' ${items.nombre}'));
                    }).toList(),
                    isExpanded: true,
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
                        labelText: "Refinanciacion",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                    value: controller.selectrefinanciacoon,
                    onChanged: controller.onChangerefinanciacion),
              )),
          Expanded(
              child: IconButton(
            icon: const Icon(Icons.add_outlined, color: Palette.primary),
            onPressed: () {
              Get.toNamed(Routes.CREATECONCEPTOS);
            },
          ))
        ]),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {},
              child: const Text(
                "Cancelar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              onPressed: () {
                controller.editajustes();
              },
              child: const Text(
                "Aplicar",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
