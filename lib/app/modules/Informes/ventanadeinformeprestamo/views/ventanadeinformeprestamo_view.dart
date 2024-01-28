import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../../../utils/utils.dart';
import '../controllers/ventanadeinformeprestamo_controller.dart';

class VentanadeinformeprestamoView
    extends GetView<VentanadeinformeprestamoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informes Prestamos'),
        backgroundColor: Palette.primary,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.download),
              onPressed: (() {
                /* controller.descargar(); */

                Printing.sharePdf(
                    bytes: controller.archivoPdf, filename: "prestamo.pdf");
              }))
        ],
      ),
      body: Obx(() => controller.loadinReciente.value
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 5,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 810,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: PdfPreview(
                        build: (format) => controller.archivoPdf,
                        useActions: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
    );
  }
}
