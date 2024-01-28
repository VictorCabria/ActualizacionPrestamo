import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../services/model_services/client_service.dart';
import 'package:flutter/services.dart';

import '../../../../models/client_model.dart';
import '../../informerecaudo/controllers/informerecaudo_controller.dart';

class VentanadeinformesrecaudosController extends GetxController {
  pw.Document pdf = pw.Document();
  final InformerecaudoController informesrecaudosController =
      Get.find<InformerecaudoController>();

  final montosuma = 0.0.obs;

  final loadinReciente = true.obs;
  late Uint8List archivoPdf;
  @override
  void onInit() async {
    print("lleno ${informesrecaudosController.recaudosnuevos}");

    super.onInit();
    loadinReciente.value = true;
    monto();
    await initPDF();

    loadinReciente.value = false;
  }

  Future<void> initPDF() async {
    for (var i = 0; i < informesrecaudosController.recaudosnuevos.length; i++) {
      Client response = await getClientById(
          informesrecaudosController.recaudosnuevos[i].idCliente!);
      informesrecaudosController.recaudosnuevos[i].clientName = response.nombre;
    }

    archivoPdf = await generarPdf2();
    print(archivoPdf);
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  monto() async {
    montosuma.value = 0;
    for (var i in informesrecaudosController.recaudosnuevos) {
      montosuma.value += i.monto!.toInt();
    }
  }

  Future<Uint8List> generarPdf2() async {
    pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        header: (context) => pw.Container(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                  pw.Row(children: [
                    pw.Expanded(
                        child: pw.Text("Reportes de Recaudos",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 20))),
                    pw.Expanded(
                        child: pw.Text(
                            "Fecha: ${DateFormat("dd/MM/yyyy").format(
                              DateTime.now(),
                            )}",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 20)))
                  ]),
                  pw.SizedBox(height: 20),
                  pw.Table(
                    border: const pw.TableBorder(
                      horizontalInside: pw.BorderSide(
                        width: 2,
                        color: PdfColors.grey200,
                      ),
                      top: pw.BorderSide(
                        width: 2,
                        color: PdfColors.grey200,
                      ),
                    ),
                    defaultColumnWidth: const pw.FixedColumnWidth(1000.0),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(180),
                      1: const pw.FixedColumnWidth(1150),
                      2: const pw.FixedColumnWidth(500),
                      3: const pw.FixedColumnWidth(500),
                    },
                    // border: pw.TableBorder.symmetric(
                    //     inside: pw.BorderSide(
                    //         width: 1, style: pw.BorderStyle(phase: 5))),
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("N",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              )),
                          pw.Align(
                              alignment: pw.Alignment.topLeft,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("CLIENTE",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              )),
                          pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("FECHA",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              )),
                          pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("VALOR",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              )),
                        ],
                      ),
                    ],
                  ),
                ])),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
              pw.Table(
                border: const pw.TableBorder(
                  horizontalInside: pw.BorderSide(
                    width: 2,
                    color: PdfColors.grey200,
                  ),
                  top: pw.BorderSide(
                    width: 2,
                    color: PdfColors.grey200,
                  ),
                ),
                //ancho por defecto
                defaultColumnWidth: const pw.FixedColumnWidth(1000.0),
                columnWidths: {
                  0: const pw.FixedColumnWidth(180),
                  1: const pw.FixedColumnWidth(1150),
                  2: const pw.FixedColumnWidth(500),
                  3: const pw.FixedColumnWidth(500),
                },
                children: informesrecaudosController.recaudosnuevos
                    .map(
                      (e) => pw.TableRow(
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                                bottom: pw.BorderSide(
                                    width: 1, color: PdfColors.grey200))),
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text((informesrecaudosController
                                          .recaudosnuevos
                                          .indexOf(e) +
                                      1)
                                  .toString()),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text(e.clientName!),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text(DateFormat("dd/MM/yyyy")
                                  .format(DateTime.parse(e.fecha!).toLocal())),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text("${e.monto}"),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              pw.Table(
                border: const pw.TableBorder(
                  horizontalInside: pw.BorderSide(
                    width: 2,
                    color: PdfColors.grey200,
                  ),
                  bottom: pw.BorderSide(
                    width: 2,
                    color: PdfColors.grey200,
                  ),
                ),
                defaultColumnWidth: const pw.FixedColumnWidth(3000.0),
                columnWidths: {
                  0: const pw.FixedColumnWidth(180),
                  1: const pw.FixedColumnWidth(1150),
                  2: const pw.FixedColumnWidth(500),
                  3: const pw.FixedColumnWidth(500),
                  4: const pw.FixedColumnWidth(500),
                },
                // border: pw.TableBorder.symmetric(
                //     inside: pw.BorderSide(
                //         width: 1, style: pw.BorderStyle(phase: 5))),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Align(),
                      pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text("TOTAL RECAUDOS",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          )),
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text("",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          )),
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text(montosuma.toString(),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          )),
                    ],
                  ),
                ],
              ),
            ]));

    /* Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath =
        "${tempDir.path}/Prestamos ${DateFormat("dd/MM/yyyy").format(
      DateTime.now(),
    )}.pdf";
    final File file = File(tempPath);
    file.writeAsBytesSync(await pdf.save()); */
    return pdf.save();
  }

  descargar() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath =
        "${tempDir.path}/Prestamos ${DateFormat("dd/MM/yyyy").format(
      DateTime.now(),
    )}.pdf";
    final File file = File(tempPath);
    file.writeAsBytesSync(archivoPdf);

    return tempPath;
  }
}
