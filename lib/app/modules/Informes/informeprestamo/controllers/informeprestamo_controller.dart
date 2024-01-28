import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/cobradores_modal.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../models/prestamo_model.dart';

class InformeprestamoController extends GetxController {
  //TODO: Implement InformeprestamoController

  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  late Stream<List<Prestamo>> prestamosStream;

  RxList<Map> items = RxList<Map>([
    {'General': 'General'},
    {'Cobrador': 'Cobrador'},
  ]);
  final selectdatos = ''.obs;
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradores2Stream;
  Cobradores? selectobradores;
  final formkey = GlobalKey<FormState>();
  RxList<Prestamo> consultar = RxList<Prestamo>([]);
  RxList<Prestamo> prestamosnuevos = RxList<Prestamo>([]);
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString fechafinal = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  @override
  void onInit() {
    prestamosStream = getorestamos();
    cobradores2Stream = getcobradores();
    init();
    super.onInit();
  }

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  getorestamos() => prestamoService
      .obtenerlistprestamo()
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  init() {
    prestamosStream.listen((event) async {
      prestamos.value = event;
      consultar.value = event;
      print(event);
    });
    cobradores2Stream.listen((event) async {
      cobradorescontroller.value = event;
    });
  }

  void onChangeDorpdowncobradores(Cobradores? cobradores) {
    selectobradores = cobradores!;
    print(cobradores.nombre);
  }

  void dropdowndatos(String? datos) async {
    selectdatos.value = datos!;
    print(selectdatos);
  }

  metodobusqueda() {
    prestamosnuevos.clear();
    final fechainicio = DateTime.parse(fecha.value);
    final fechaultima = DateTime.parse(fechafinal.value);

    var response = prestamos.value = consultar
        .where((element) =>
            DateTime.parse(element.fecha!).isAtSameMomentAs(fechainicio) ||
            DateTime.parse(element.fecha!).isAfter(fechainicio) &&
                DateTime.parse(element.fecha!).isBefore(fechaultima))
        .toList();

    prestamosnuevos.addAll(response);
    Get.toNamed(Routes.VENTANADEINFORMEPRESTAMO);
  }

  metodobusquedacobrador() {
    prestamosnuevos.clear();
    final fechainicio = DateTime.parse(fecha.value);
    final fechaultima = DateTime.parse(fechafinal.value);
    final cobradorid = selectobradores;

    var response = prestamos.value = consultar
        .where((element) =>
            DateTime.parse(element.fecha!).isAtSameMomentAs(fechainicio) ||
            DateTime.parse(element.fecha!).isAfter(fechainicio) &&
                DateTime.parse(element.fecha!).isBefore(fechaultima))
        .toList();

    /*  for (var i in response) {
      if (i.cobrador == cobradorid!.id) {
        transaccionesnuevos.add(i);
      }
    } */

    var prestamosfiltradas =
        response.where((element) => element.cobradorId == cobradorid!.id);
    prestamosnuevos.addAll(prestamosfiltradas);
    Get.toNamed(Routes.VENTANADEINFORMEPRESTAMO);
  }

  Future<dynamic> buscarlistas(String tipo) async {
    switch (tipo) {
      case 'General':
        return metodobusqueda();
      case 'Cobrador':
        return metodobusquedacobrador();
    }
  }
}
