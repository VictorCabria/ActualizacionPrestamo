import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../models/cobradores_modal.dart';
import '../../../../models/concepto_model.dart';

import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/conceptos_service.dart';
import '../../informetransacciones/controllers/informetransacciones_controller.dart';

class VentanadeinformestransaccionesController extends GetxController {
  //TODO: Implement VentanadeinformestransaccionesController

  final InformetransaccionesController informestransaccionesController =
      Get.find<InformetransaccionesController>();
  pw.Document pdf = pw.Document();
  final saldosuma = 0.0.obs;
  final loadinReciente = true.obs;
  late Uint8List archivoPdf;
  @override
  void onInit() async {
    loadinReciente.value = true;
    monto();
    await initPDF();
    loadinReciente.value = false;

    super.onInit();
  }

  Future<void> initPDF() async {
    for (var i = 0;
        i < informestransaccionesController.transaccionesnuevos.length;
        i++) {
      Cobradores response = await getcobradorById(
          informestransaccionesController.transaccionesnuevos[i].cobrador!);
      informestransaccionesController.transaccionesnuevos[i].cobradorname =
          response.nombre;

      Concepto resp = await getconceptoById(
          informestransaccionesController.transaccionesnuevos[i].concept!);
      informestransaccionesController.transaccionesnuevos[i].conceptname =
          resp.nombre;
    }

    archivoPdf = await generarPdf2();
    print(archivoPdf);
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getconceptoById(String id) async {
    var response = await conceptoService.getconceptoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  monto() async {
    saldosuma.value = 0;
    for (var i in informestransaccionesController.transaccionesnuevos) {
      saldosuma.value += i.valor!.toInt();
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
                        child: pw.Text("Reportes de Transacciones",
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
                      bottom: pw.BorderSide(
                        width: 2,
                        color: PdfColors.grey200,
                      ),
                      top: pw.BorderSide(
                        width: 2,
                        color: PdfColors.grey200,
                      ),
                    ),
                    defaultColumnWidth: pw.FixedColumnWidth(1000.0),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(180),
                      1: const pw.FixedColumnWidth(1000),
                      2: const pw.FixedColumnWidth(600),
                      3: const pw.FixedColumnWidth(1150),
                      4: const pw.FixedColumnWidth(600),
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
                                child: pw.Text("TERCERO",
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
                                child: pw.Text("DETALLE",
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
                  bottom: pw.BorderSide(
                    width: 2,
                    color: PdfColors.grey200,
                  ),
                ),
                //ancho por defecto
                defaultColumnWidth: const pw.FixedColumnWidth(1000.0),
                columnWidths: {
                  0: const pw.FixedColumnWidth(180),
                  1: const pw.FixedColumnWidth(1000),
                  2: const pw.FixedColumnWidth(600),
                  3: const pw.FixedColumnWidth(1150),
                  4: const pw.FixedColumnWidth(600),
                },
                children: informestransaccionesController.transaccionesnuevos
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
                              child: pw.Text((informestransaccionesController
                                          .transacciones
                                          .indexOf(e) +
                                      1)
                                  .toString()),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text(e.cobradorname!),
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
                              child: pw.Text(e.detalles == null
                                  ? ""
                                  : e.detalles.toString()),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text("${e.valor}"),
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
                  1: const pw.FixedColumnWidth(1000),
                  2: const pw.FixedColumnWidth(600),
                  3: const pw.FixedColumnWidth(1150),
                  4: const pw.FixedColumnWidth(600),
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
                            child: pw.Text("TOTAL",
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
                      pw.Align(),
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text(saldosuma.toString(),
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
