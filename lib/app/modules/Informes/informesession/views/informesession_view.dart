
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/palette.dart';
import '../controllers/informesession_controller.dart';
import 'package:pdf/widgets.dart' as pw;

class InformesessionView extends GetView<InformesessionController> {
  const InformesessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "informes de Session",
          ),
          backgroundColor: Palette.primary,
          centerTitle: true,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(
          children: [
            Form(
              key: controller.formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        onTap: () async {
                          final DateTime? pickedTime = await showDatePicker(
                              context: context,
                              initialDate: controller.selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101));
                          if (pickedTime != null) {
                            controller.fromDateControler.text =
                                DateFormat('yyyy-MM-dd').format(pickedTime);
                          }
                        },
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        cursorColor: Palette.primary,
                        controller: controller.fromDateControler,
                        onSaved: (value) {
                          controller.fromDateControler.text = value!;
                        },
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.headset, color: Palette.primary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                              borderSide: BorderSide(color: Palette.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                              borderSide: BorderSide(
                                color: Palette.primary,
                              ),
                            ),
                            labelText: "desde",
                            fillColor: Palette.primary,
                            labelStyle: TextStyle(color: Palette.primary)),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            /*   controller.cargando.value
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 5,
                      )),
                    )
                  : Container() */
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                backgroundColor: Palette.primary,
                child: Icon(
                  Icons.search,
                ),
                onPressed: () => controller.metodobusqueda())
          ],
        ));
  }
}
