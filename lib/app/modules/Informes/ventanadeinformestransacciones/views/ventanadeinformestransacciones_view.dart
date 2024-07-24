import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../../../utils/palette.dart';
import '../controllers/ventanadeinformestransacciones_controller.dart';

class VentanadeinformestransaccionesView
    extends GetView<VentanadeinformestransaccionesController> {
  const VentanadeinformestransaccionesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informes Transacciones'),
        backgroundColor: Palette.primary,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.download),
              onPressed: (() {
                /* controller.descargar(); */

                Printing.sharePdf(
                    bytes: controller.archivoPdf,
                    filename: "transacciones.pdf");
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
