import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/prestamo_model.dart';
import 'package:prestamo_mc/app/models/recaudo_line_modal.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';
import 'package:prestamo_mc/app/utils/utils.dart';
import '../../../../models/client_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../utils/palette.dart';
import '../../../principal/home/controllers/home_controller.dart';

class LineasrecaudosController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<RecaudoLine> recaudarLines = RxList<RecaudoLine>([]);
  RxList<Client> cliente = RxList<Client>([]);
  RxList<Client> clientefiltrados = RxList<Client>([]);
  RxList<RecaudoLine> recaudosconsultar = RxList<RecaudoLine>([]);
  RxList<RecaudoLine> recaudodoLines = RxList<RecaudoLine>([]);
  /*  RxList<Prestamo> prestamos = RxList<Prestamo>([]); */
  RxList<RecaudoLine> selectedItem = RxList([]);
  late Stream<List<Client>> clientStream;
  final homecontroller = Get.find<HomeController>();
  Recaudo? recaudo;
  RecaudoLine? recaudolinea;
  RxBool isMultiSelectionEnabled = false.obs;
  late TabController tabController;

  final loading = false.obs;
  final punto = false.obs;
  final value = 0.0.obs;
  final cargando = false.obs;
  RxBool isBuscar = false.obs;
  final total = 0.0.obs;
  final totalrecaudados = 0.0.obs;
  final numRecaudado = 0.obs;
  final recaudonuevo = 0.0.obs;
  final montosuma = 0.0.obs;

  final index = 0.obs;

  @override
  void onInit() async {
    recaudo = Get.arguments;
    /* tabController = TabController(length: 2, vsync: this); */
    await getPrestamos();
    clientStream = getclient();
    init();
    /* await getListPrestamo(); */
    await getlistarecaudados();
    await mapearRecaudado();

    /* getcalculardatos(); */

    print("presatmos");

    super.onInit();

    /*  tabController.addListener(() {
      print(tabController.index);
    }); */
  }

  /* getListPrestamo() async {
    var response = await prestamoService.getprestamoconsulta();
    prestamos.value = response;
  }
 */
  getPrestamos() async {
    cargando.value = true;
    var response = await prestamoService.getLineaprestamo(recaudo!.zoneId!);

    RxList<Prestamo> response3 = RxList<Prestamo>([]);
    for (var i in response) {
      if (i.estado == StatusPrestamo.pagado.name) {
      } else if (i.fechaPago == "") {
      } else {
        response3.add(i);
      }
      cargando.value = true;
    }

    var response2 = response3.where((element) =>
        DateTime.parse(element.fechaPago!).isAtSameMomentAs(DateTime.now()) ||
        DateTime.parse(element.fechaPago!).isBefore(DateTime.now()));
    recaudarLines.value =
        response2.map((e) => RecaudoLine.fromPrestamo(e, recaudo!)).toList();

    recaudosconsultar.value =
        response2.map((e) => RecaudoLine.fromPrestamo(e, recaudo!)).toList();

    cargando.value = false;
    print("Recaudar $recaudarLines");
  }

  getclient() => clientService
      .obtenerlist()
      .snapshots()
      .map((event) => event.docs.map((e) => Client.fromJsonMap(e)).toList());

  init() {
    clientStream.listen((event) async {
      cliente.value = event;
      clientefiltrados.value = event;
    });
  }

  getlistarecaudados() async {
    var response = await recaudoService.getLineaRecaudado(recaudo!.id!);
    for (int i = 0; i < recaudarLines.length; i++) {
      for (var u in response) {
        if (recaudarLines[i].idPrestamo == u.idPrestamo) {
          recaudarLines[i] = u;
        }
      }
    }

    recaudarLines.refresh();
    monto();
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      recaudarLines.value = recaudosconsultar;
    }
  }

  searching(String texto) {
    RxList<RecaudoLine> recaudosnuevos = RxList<RecaudoLine>([]);
    recaudosnuevos.addAll(recaudarLines);

    if (texto != '') {
      cliente.value = clientefiltrados
          .where((p0) => p0.nombre!.toUpperCase().contains(texto.toUpperCase()))
          .toList();

      recaudarLines.value = recaudosnuevos.where((recaudo) {
        var lista = cliente.where((p0) {
          return p0.id == recaudo.idCliente;
        });

        if (lista.isEmpty) return false;

        return true;
      }).toList();
    } else {
      recaudarLines.value = recaudosconsultar;
    }
  }

  /*  getcalculardatos() {
    for (var i in recaudodoLines) {
      var response =
          recaudarLines.where((p0) => p0.idPrestamo == i.idPrestamo).toList();

      for (var u in response) {
        u.monto = i.monto;
        u.saldo = u.saldo! - i.monto!;
      }
    }
  } */

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  void doMultiSelection(RecaudoLine recaudados) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(recaudados)) {
        selectedItem.remove(recaudados);
      } else {
        selectedItem.add(recaudados);
      }
    } else {}
  }

  String getselesctionrecaudos() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  deleterecaudos() async {
    for (var i in selectedItem) {
      /*  homecontroller.session!
          .updatePyG(TipoOperacion.ingreso, i.monto!, crear: false);
      sessionService.updateSession(homecontroller.session!);
      homecontroller.saldo.value = homecontroller.session!.pyg.toString(); */
      recaudo!.total = recaudo!.total! - i.monto!;
      recaudoService.updaterecaudo(recaudo!);
      recaudoService.deleterecaudados(i);
    }
    await getPrestamos();
    await getlistarecaudados();
    mapearRecaudado();
  }

  agregarSuma(int val) async {
    if (punto.value) {
      value.value = value.value + (val / 10);

      punto.value = false;
    } else {
      value.value = value.value + val;
    }
    print("vaue suma ${value.value}");
  }

  agregarAcumula(int val) async {
    if (punto.value) {
      value.value = value.value + (val / 10);

      punto.value = false;
    } else {
      var texto = value.value.toString();
      var punto = texto.split('.').last;
      var numero = texto.split('.').first;
      print(punto);
      value.value = double.parse("$numero$val.$punto");
    }
    print("vaue ${value.value}");
  }

  puntoMode() {
    punto.value = true;
  }

  delete() async {
    var texto = value.value.toString();
    print(texto.length);
    if (texto.length > 3) {
      texto = texto.substring(0, texto.length - 3);
      value.value = double.parse(texto);
    } else {
      value.value = 0;
    }
    // value.value = double.parse(texto.substring(0, texto.length - 1));
  }

  aceptar(RecaudoLine line) async {
    print("valor2 ${value.value}");

    if (value.value > line.saldo!) {
      Get.dialog(AlertDialog(
        title: const Text("Saldo superior"),
        content: const Text(
            "Estas superando el saldo del prestamo estas seguro que quieres continuar"),
        actions: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              child: const Text("Aceptar"),
              onPressed: () {
                if (value.value <= 0.0) {
                  line.monto = 0.0;
                  line.saldo = line.saldoAnterior;
                  value.value = 0.0;
                } else {
                  line.monto = value.value;
                  line.saldo = line.saldo! - line.monto!;
                  value.value = 0.0;
                }
                mapearRecaudado();
                procesar(line);
                Get.back();
              }),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary)),
              child: const Text("Cancelar"),
              onPressed: () {
                Get.back();
              }),
        ],
      ));
      return;
    } else {
      if (value.value <= 0.0) {
        line.monto = 0.0;
        line.saldo = line.saldoAnterior;
        value.value = 0.0;
      } else {
        line.monto = value.value;
        line.saldo = line.saldo! - line.monto!;
        value.value = 0.0;
      }
      mapearRecaudado();
      procesar(line);
      recaudarLines.refresh();
    }

    Get.back();
  }

  mapearRecaudado() {
    if (recaudarLines.isNotEmpty) {
      numRecaudado.value =
          recaudarLines.where((e) => e.monto! > 0.0).toList().length;
      total.value = recaudarLines
          .map((e) => e.monto)
          .reduce((value, element) => value! + element!)!;
    }
  }

  procesar(RecaudoLine line) async {
    loading.value = true;
    print("Recaudos${recaudarLines}");
    line.procesado = true;
    var response = await recaudoService.saveRecaudoLine(line);
    if (response != null) {
      line.id = response;
    }
    recaudo!.total = total.value;
    recaudoService.updaterecaudo(recaudo!);
    loading.value = false;
  }

  monto() async {
    totalrecaudados.value = 0;

    for (var i in recaudarLines) {
      if (i.procesado == true) {
        totalrecaudados.value += i.saldo!.toInt();
      }

      print(total.value);
      recaudarLines.refresh();
    }
  }

  /*  mapearRecaudadonuevos() {
    recaudonuevo.value = 0;
    recaudonuevo.value = recaudarLines
        .map((e) => e.monto)
        .reduce((value, element) => value! + element!)!;
  } */
}
