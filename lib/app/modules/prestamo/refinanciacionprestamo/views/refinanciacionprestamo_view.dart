import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/type_prestamo_model.dart';
import 'package:prestamo_mc/app/utils/palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/client_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/refinanciacionprestamo_controller.dart';

class RefinanciacionprestamoView
    extends GetView<RefinanciacionprestamoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: const Text("Refinanciar Prestamo"),
        centerTitle: true,
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
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: DateTimePicker(
                    dateMask: "d/MM/yyyy",
                    cursorColor: Palette.primary,
                    initialValue: controller.fecha.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 665)),
                    dateLabelText: 'Fecha',
                    onChanged: (val) => controller.fecha.value = val,
                    decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
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
                        labelText: "Fecha",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                  ),
                ),
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      Expanded(
                        child: GetBuilder<RefinanciacionprestamoController>(
                          id: 'cliente',
                          builder: (manual) => TextFormField(
                            autofocus: false,
                            onTap: () {
                              controller.onChangecliente();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            cursorColor: Palette.primary,
                            controller: controller.clientecontroller,
                            onSaved: (value) {
                              controller.clientecontroller.text = value!;
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle,
                                    color: Palette.primary),
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
                                labelText: "Cliente",
                                fillColor: Palette.primary,
                                labelStyle: TextStyle(color: Palette.primary)),
                          ),
                        ),
                      ),
                    ])),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.78,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: GetBuilder<RefinanciacionprestamoController>(
                        id: 'zone',
                        builder: (manual) => DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Seleccione una Zona';
                              }
                              return null;
                            },
                            items: controller.zonas.map((items) {
                              return DropdownMenuItem<Zone>(
                                  value: items,
                                  child: Text(
                                    ' ${items.nombre}',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ));
                            }).toList(),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle,
                                  color: Palette.primary),
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
                              labelText: "Zona",
                              fillColor: Palette.primary,
                              labelStyle: TextStyle(color: Palette.primary),
                            ),
                            value: controller.zona,
                            onChanged: controller.onChangeZona),
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.CREATEZONE);
                            },
                            icon: const Icon(
                              Icons.add_outlined,
                              color: Palette.primary,
                            ))),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.78,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: GetBuilder<RefinanciacionprestamoController>(
                        id: 'recorrido',
                        builder: (manual) => DropdownButtonFormField(
                            isExpanded: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Seleccione una recorrido';
                              }
                              return null;
                            },
                            items: controller.clients.map((item) {
                              return DropdownMenuItem<Client>(
                                  value: item,
                                  child: Text(
                                    ' ${item.recorrido}',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ));
                            }).toList(),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle,
                                  color: Palette.primary),
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
                            value: controller.client,
                            onChanged: controller.onChangerecorrido),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.78,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: GetBuilder<RefinanciacionprestamoController>(
                        id: 'tipoprestamo',
                        builder: (manual) => DropdownButtonFormField(
                            isExpanded: true,
                            items: controller.tipoPrestamos.map((items) {
                              return DropdownMenuItem<TypePrestamo>(
                                  value: items,
                                  child: Text(
                                    ' ${items.nombre}',
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ));
                            }).toList(),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle,
                                    color: Palette.primary),
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
                            value: controller.tipoPrestamo,
                            onChanged: controller.onChangeTipoPrestamo),
                      )),
                  Expanded(
                      child: IconButton(
                    icon:
                        const Icon(Icons.add_outlined, color: Palette.primary),
                    onPressed: () {
                      Get.toNamed(Routes.REGISTRARPRESTAMOS);
                    },
                  ))
                ]),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: GetBuilder<RefinanciacionprestamoController>(
                    id: 'monto',
                    builder: (manual) => TextFormField(
                      enabled: false,
                      onTap: () {
                      },

                      autofocus: false,
                      keyboardType: TextInputType.number,
                      controller: controller.montoTextController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese un monto';
                        }
                        if (double.parse(value) <= 0) {
                          return 'El monto no puede ser menor o igual a 0';
                        }
                        return null;
                      },
                      // initialValue: controller.monto.value.toString(),
                      onChanged: controller.onChangeMonto,

                      textInputAction: TextInputAction.next,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
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
                        labelText: "Monto",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    /* initialValue: controller.valorCuota.value, */
                    controller: controller.textController,

                    autofocus: false,
                    keyboardType: TextInputType.number,
                    // controller: controller.nombreconceptocontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese valor de cuota';
                      }
                      if (double.parse(value) <= 0) {
                        return 'La cuota no puede ser menor o igual a 0';
                      }
                      return null;
                    },
                    onChanged: controller.onChangeCuota,

                    textInputAction: TextInputAction.next,

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
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
                      labelText: "Cuota",
                      fillColor: Palette.primary,
                      labelStyle: TextStyle(color: Palette.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: DateTimePicker(
                    dateMask: "d/MM/yyyy",
                    cursorColor: Palette.primary,
                    initialValue: controller.fechadepago.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 665)),
                    dateLabelText: 'Primer recaudo',
                    onChanged: (val) => controller.fechadepago.value = val,
                    decoration: const InputDecoration(
                        focusColor: Palette.primary,
                        hoverColor: Palette.primary,
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
                        labelText: "Primer Prestamo",
                        fillColor: Palette.primary,
                        labelStyle: TextStyle(color: Palette.primary)),
                  ),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => Card(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Palette.primary,
                              borderRadius: BorderRadius.circular(20)),
                          height: 27.h,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Resumen",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Monto:',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.monto.value
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Porcentaje: ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.porcentaje.value
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Total: ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.total.value
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Meses: ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.meses.value
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Cuotas: ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.cuotas.value
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Valor Cuota: ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.valorCuota.value,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.detalle.value,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.h,
                          right: context.width * 0.2,
                          left: context.width * 0.2,
                          child: GestureDetector(
                            onTap: () => controller.refinanciarprestamo(),
                            child: const CircleAvatar(
                              backgroundColor: Palette.primary,
                              radius: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  Icons.save,
                                  color: Palette.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
