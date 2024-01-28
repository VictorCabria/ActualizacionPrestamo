import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../models/client_model.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../informeprestamo/controllers/informeprestamo_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class VentanadeinformeprestamoController extends GetxController {
  pw.Document pdf = pw.Document();
  final InformeprestamoController reportesController =
      Get.find<InformeprestamoController>();
  final montosuma = 0.0.obs;
  final saldosuma = 0.0.obs;

  final loadinReciente = true.obs;
  late Uint8List archivoPdf;
  @override
  void onInit() async {
    print("lleno ${reportesController.prestamosnuevos}");

    super.onInit();
    loadinReciente.value = true;
    monto();
    await initPDF();
    loadinReciente.value = false;
  }

  Future<void> initPDF() async {
    for (var i = 0; i < reportesController.prestamosnuevos.length; i++) {
      Client response =
          await getClientById(reportesController.prestamosnuevos[i].clienteId!);
      reportesController.prestamosnuevos[i].clientName = response.nombre;

      TypePrestamo respo = await getprestamoById(
          reportesController.prestamosnuevos[i].tipoPrestamoId!);
      reportesController.prestamosnuevos[i].clienttipo = respo.tipo["tipo"];
    }

    archivoPdf = await generarPdf2();
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getprestamoById(String id) async {
    var response = await typePrestamoService.getprestamoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  monto() async {
    montosuma.value = 0;
    saldosuma.value = 0;
    for (var i in reportesController.prestamosnuevos) {
      montosuma.value += i.monto!.toInt();

      saldosuma.value += i.saldoPrestamo!.toInt();
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
                        child: pw.Text("Reportes de Prestamos",
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
                    defaultColumnWidth: const pw.FixedColumnWidth(3000.0),
                    columnWidths: {
                      0: const pw.FixedColumnWidth(180),
                      1: const pw.FixedColumnWidth(1150),
                      2: const pw.FixedColumnWidth(600),
                      3: const pw.FixedColumnWidth(600),
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
                                child: pw.Text("PRÉSTAMO",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              )),
                          pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("SALDO",
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
                defaultColumnWidth: const pw.FixedColumnWidth(4000.0),
                columnWidths: {
                  0: const pw.FixedColumnWidth(180),
                  1: const pw.FixedColumnWidth(1150),
                  2: const pw.FixedColumnWidth(600),
                  3: const pw.FixedColumnWidth(600),
                  4: const pw.FixedColumnWidth(600),
                },
                children: reportesController.prestamosnuevos
                    .map(
                      (e) => pw.TableRow(
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text((reportesController.prestamosnuevos
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
                              child: pw.Text(e.monto.toString()),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child:
                                  pw.Text(e.saldoPrestamo!.toStringAsFixed(2)),
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
                  2: const pw.FixedColumnWidth(600),
                  3: const pw.FixedColumnWidth(600),
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
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text(montosuma.toString(),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          )),
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text(saldosuma.toStringAsFixed(2),
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
}
