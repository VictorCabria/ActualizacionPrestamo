import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/concepto_model.dart';
import '../../../../models/transaction_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/conceptos_service.dart';
import '../../../../services/model_services/session_service.dart';
import '../../../../services/model_services/transacciones_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/references.dart';
import '../../../principal/home/controllers/home_controller.dart';

class ListatransaccionesController extends GetxController {
  RxList<Transacciones> transacciones = RxList<Transacciones>([]);
  RxList<Transacciones> consulta = RxList<Transacciones>([]);
  late Stream<List<Transacciones>> transaccionesStream;
  final homeControll = Get.find<HomeController>();
  List<Transacciones> get transaccionesget => transacciones;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  RxBool cargando = true.obs;
  RxList<Concepto> conceptos = RxList<Concepto>([]);
  RxList<Concepto> conceptosfiltrados = RxList<Concepto>([]);
  late Stream<List<Concepto>> conceptosStream;
  RxList<Cobradores> cobradores = RxList<Cobradores>([]);
  RxList<Cobradores> cobradoresfiltrados = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradoresStream;
  List<Cobradores> get cobradoresget => cobradores;
  RxList<Transacciones> selectedItem = RxList();
  Transacciones? transaccion;
  final montosuma = 0.0.obs;

  @override
  void onInit() {
    transaccionesStream = gettransacciones();
    cobradoresStream = getcobradores();
    conceptosStream = getconceptos();
    super.onInit();
    init();
  }

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  getconceptos() => conceptoService
      .obtenerlistconceptos()
      .snapshots()
      .map((event) => event.docs.map((e) => Concepto.fromJson(e)).toList());

  gettransacciones() {
    if (homeControll.gestorMode.value) {
      return transaccionesService
          .obtenerlisttransacciones()
          .where('id_session', isEqualTo: homeControll.session!.id)
          .where('cobradorId', isEqualTo: homeControll.cobradores!.id)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Transacciones.fromJson(e)).toList());
    }
    return transaccionesService.obtenerlisttransacciones().snapshots().map(
        (event) => event.docs.map((e) => Transacciones.fromJson(e)).toList());
  }

  init() {
    transaccionesStream.listen((event) async {
      cargando.value = true;
      transacciones.value = event;
      consulta.value = event;
      transacciones.sort((b, a) => a.fecha!.compareTo(b.fecha!));
      searching('');
      monto();
      cargando.value = false;
    });
    cobradoresStream.listen((event) async {
      cobradores.value = event;
      cobradoresfiltrados.value = event;
    });

    conceptosStream.listen((event) {
      conceptos.value = event;
      conceptosfiltrados.value = event;
    });
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      transacciones.value = consulta;
    }
  }

  createtransacciones() async {
    /*  montosuma.value = 0; */
    if (homeControll.session == null) {
      Get.dialog(const AlertDialog(
        content: Text("Debes crear una sesion"),
      ));
      return;
    }
    if (homeControll.session!.estado == StatusSession.closed.name) {
      Get.dialog(const AlertDialog(
        content: Text("No hay una sesion activa"),
      ));
      return;
    }
    var response = await Get.toNamed(Routes.CREATETRANSACCIONES);
    if (response != null) {
      transaccion = response;
/*       montosuma.value += transaccion!.valor!;
      homeControll.session!.gastos = montosuma.value; */

      homeControll.session!
          .updatePyG(TipoOperacion.gasto, transaccion!.tiponaturaleza!);
      homeControll.saldo.value = homeControll.session!.pyg!;
      sessionService.updateSession(homeControll.session!);
    }
  }

  searching(String texto) {
    if (texto != '') {
      conceptos.value = conceptosfiltrados
          .where((p0) => p0.nombre!.toUpperCase().contains(texto.toUpperCase()))
          .toList();
      transacciones.value = consulta.where((transacciones) {
        var lista = conceptos.where((p0) {
          return p0.id == transacciones.concept;
        });
        if (lista.isEmpty) return false;
        return true;
      }).toList();
    } else {
      transacciones.value = consulta;
    }
  }

  monto() async {
    montosuma.value = 0;
    for (var i in transacciones) {
      montosuma.value += i.valor!.toInt();
      print("Monto${montosuma.value}");
    }
  }

/*   searching(String texto) {
    if (texto != '') {
      transacciones.value = consulta
          .where((element) => (element.concept!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      transacciones.value = consulta;
    }
  } */

  void doMultiSelection(Transacciones transacciones) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(transacciones)) {
        selectedItem.remove(transacciones);
      } else {
        selectedItem.add(transacciones);
      }
    } else {
      editartransacciones(transacciones);
    }
  }

  void filtrarlist(String name) {
    if (name != "todos") {
      var c = [];
      c.addAll(cobradoresfiltrados.where((p0) => p0.nombre == name).toList());
      print(cobradores.length);

      transacciones.value = consulta.where((transacciones) {
        var lista = c.where((p0) {
          return p0.id == transacciones.cobrador;
        });

        if (lista.isEmpty) return false;

        /*      c.clear(); */
        return true;
      }).toList();
    } else {
      transacciones.value = consulta.toList();
    }
  }
/* 
  void filtrarlist(String name) {
    if (name != "todos") {
      transacciones.value =
          consulta.where((element) => element.id == name).toList();
    } else {
      transacciones.value = consulta.toList();
    }
  } */

  void filtrarlist2(i) {
    if (i == 0) {
      transacciones.value = consulta.toList();
    }
  }

  getconceptoById(String id) async {
    var response = await conceptoService.getconceptoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  getcobradoresId(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  String getSelectedtransacciones() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  editartransacciones(Transacciones transacciones) {
    Get.toNamed(Routes.EDITTRANSACCIONES,
        arguments: {firebaseReferences.transacciones: transacciones});
  }

  delete() async {
    for (var i = 0; i < selectedItem.length; i++) {
      if (homeControll.session == null) {
        transaccionesService.deletetransacciones(selectedItem[i]);
      } else if (selectedItem[i].tiponaturaleza == null) {
        transaccionesService.deletetransacciones(selectedItem[i]);
      } else {
        homeControll.session!.updatePyG(
            TipoOperacion.gasto, selectedItem[i].tiponaturaleza!,
            crear: false);

        sessionService.updateSession(homeControll.session!);
        homeControll.saldo.value = homeControll.session!.pyg!;
        transaccionesService.deletetransacciones(selectedItem[i]);
      }
    }
  }
}