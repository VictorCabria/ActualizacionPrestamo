import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../models/client_model.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../informesession/controllers/informesession_controller.dart';

class VentanadeinformessessionController extends GetxController {
  //TODO: Implement VentanadeinformessessionController
  pw.Document pdf = pw.Document();
  final InformesessionController reportessessionController =
      Get.find<InformesessionController>();
  late Uint8List archivoPdf;
  final loadinReciente = true.obs;
  final montosuma = 0.0.obs;
  final saldosuma = 0.0.obs;
  final recaudosuma = 0.0.obs;
  final transaccionessuma = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    loadinReciente.value = true;
    monto();
    await initPDF();
    loadinReciente.value = false;
  }

  Future<void> initPDF() async {
    for (var i = 0; i < reportessessionController.sessionnuevos.length; i++) {
      Cobradores response = await getcobradorById(
          reportessessionController.sessionnuevos[i].cobradorId!);
      reportessessionController.sessionnuevos[i].cobradorname = response.nombre;

      /*  Client resp = await getClientById(
          reportessessionController.prestamosnuevos[i].clienteId!);
      reportessessionController.prestamosnuevos[i].clientName = resp.nombre; */
    }
    for (var i = 0; i < reportessessionController.prestamosnuevos.length; i++) {
      Client resp = await getClientById(
          reportessessionController.prestamosnuevos[i].clienteId!);
      reportessessionController.prestamosnuevos[i].clientName = resp.nombre;
    }

    for (var i = 0;
        i < reportessessionController.transaccionesnuevos.length;
        i++) {
      Cobradores transa = await getcobradorById(
          reportessessionController.transaccionesnuevos[i].cobrador!);
      reportessessionController.transaccionesnuevos[i].cobradorname =
          transa.nombre;
    }

    for (var i = 0; i < reportessessionController.recaudosnuevos.length; i++) {
      Client respo = await getClientById(
          reportessessionController.recaudosnuevos[i].idCliente!);
      reportessessionController.recaudosnuevos[i].clientName = respo.nombre;
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

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  monto() async {
    montosuma.value = 0;
    saldosuma.value = 0;
    for (var i in reportessessionController.prestamosnuevos) {
      montosuma.value += i.monto!.toInt();
      saldosuma.value += i.saldoPrestamo!.toInt();
    }
    for (var i in reportessessionController.recaudosnuevos) {
      recaudosuma.value += i.monto!.toInt();
    }
    for (var i in reportessessionController.transacciones) {
      transaccionessuma.value += i.valor!.toInt();
    }
  }

  Future<Uint8List> generarPdf2() async {
    pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          maxPages: 100,
          header: (context) => pw.Container(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(children: [
                        pw.Expanded(
                            child: pw.Text("Reportes de Session",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20))),
                        pw.Expanded(
                            child: pw.Text(
                                "Fecha: ${DateFormat("dd/MM/yyyy").format(
                                  DateTime.now(),
                                )}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20)))
                      ]),
                      pw.SizedBox(height: 20),
                    ]),
              ),
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [
                pw.SizedBox(height: 30),
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
                  defaultColumnWidth: pw.FixedColumnWidth(4000.0),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(180),
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
                              child: pw.Text(
                                  "SESION ${reportessessionController.sessionnuevos.first.fecha}- ${reportessessionController.sessionnuevos.first.cobradorname}",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
                ),
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
                  defaultColumnWidth: const pw.FixedColumnWidth(4000.0),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(1100),
                    1: const pw.FixedColumnWidth(650),
                    2: const pw.FixedColumnWidth(1100),
                    3: const pw.FixedColumnWidth(650),
                  },
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                                  width: 1, color: PdfColors.grey600))),
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text("FECHA DE APERTURA",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text(DateFormat("dd/MM/yyyy").format(
                                DateTime.parse(reportessessionController
                                        .sessionnuevos.first.fecha!)
                                    .toLocal())),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                            margin: const pw.EdgeInsets.all(10),
                            child: pw.Text("FECHA DE CIERRE",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Text("2022-11-29")),
                        ),
                      ],
                    ),
                  ],
                ),
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
                    0: const pw.FixedColumnWidth(1150),
                    1: const pw.FixedColumnWidth(650),
                    2: const pw.FixedColumnWidth(1150),
                    3: const pw.FixedColumnWidth(650),
                  },
                  children: reportessessionController.sessionnuevos
                      .map(
                        (e) => pw.TableRow(
                          decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                  bottom: pw.BorderSide(
                                      width: 1, color: PdfColors.grey200))),
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.topLeft,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("SALDO INICIAL",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text(e.valorInicial.toString()),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text("SALDO FINAL",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text(e.pyg.toString()),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                pw.SizedBox(height: 30),
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
                  defaultColumnWidth: pw.FixedColumnWidth(4000.0),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(180),
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
                              child: pw.Text("PRESTAMOS",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
                ),
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
                  children: reportessessionController.prestamosnuevos
                      .map(
                        (e) => pw.TableRow(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Container(
                                margin: const pw.EdgeInsets.all(10),
                                child: pw.Text((reportessessionController
                                            .prestamosnuevos
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
                                child: pw.Text(DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(e.fecha!).toLocal())),
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
                                child: pw.Text(e.saldoPrestamo.toString()),
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
                              child: pw.Text(saldosuma.toString(),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 30),
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
                  defaultColumnWidth: pw.FixedColumnWidth(4000.0),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(180),
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
                              child: pw.Text("RECAUDOS",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
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
                    top: pw.BorderSide(
                      width: 2,
                      color: PdfColors.grey200,
                    ),
                  ),
                  defaultColumnWidth: pw.FixedColumnWidth(1000.0),
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
                    1: const pw.FixedColumnWidth(1150),
                    2: const pw.FixedColumnWidth(500),
                    3: const pw.FixedColumnWidth(500),
                  },
                  children: reportessessionController.recaudosnuevos
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
                                child: pw.Text((reportessessionController
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
                                child: pw.Text(DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(e.fecha!).toLocal())),
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
                              child: pw.Text(recaudosuma.toString(),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 30),
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
                  defaultColumnWidth: pw.FixedColumnWidth(4000.0),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(180),
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
                              child: pw.Text("TRANSACCIONES",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
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
                  children: reportessessionController.transaccionesnuevos
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
                                child: pw.Text((reportessessionController
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
                                child: pw.Text(DateFormat("dd/MM/yyyy").format(
                                    DateTime.parse(e.fecha!).toLocal())),
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
                              child: pw.Text(transaccionessuma.toString(),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                      ],
                    ),
                  ],
                ),
              ]),
    );

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
    file.writeAsBytesSync(await pdf.save());

    return tempPath;
  }
}
