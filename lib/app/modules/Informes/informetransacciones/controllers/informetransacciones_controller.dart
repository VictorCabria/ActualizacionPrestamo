import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/transaction_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/transacciones_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class InformetransaccionesController extends GetxController {
  RxList<Transacciones> transacciones = RxList<Transacciones>([]);
  final homecontroller = Get.find<HomeController>();
  RxList<Map> items = RxList<Map>([
    {'General': 'General'},
    {'Cobrador': 'Cobrador'},
  ]);
  final selectdatos = ''.obs;
  late Stream<List<Transacciones>> transaccionesStream;
  Cobradores? selectobradores;
  final formkey = GlobalKey<FormState>();
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
  late Stream<List<Cobradores>> cobradores2Stream;
  RxList<Transacciones> consultar = RxList<Transacciones>([]);
  RxList<Transacciones> transaccionesnuevos = RxList<Transacciones>([]);
  RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString fechafinal = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  late TextEditingController fromDateControler;
  late TextEditingController fromDateControler2;

  @override
  void onInit() {
    transaccionesStream = gettransacciones();
    cobradores2Stream = getcobradores();
    fromDateControler = TextEditingController(text: fecha.value);
    fromDateControler2 = TextEditingController(text: fechafinal.value);
    init();
    init();
    super.onInit();
  }

  void dropdowndatos(String? datos) async {
    selectdatos.value = datos!;
    print(selectdatos);
  }

  getcobradores() => cobradoresService
      .obtenerlistcobradores()
      .snapshots()
      .map((event) => event.docs.map((e) => Cobradores.fromJson(e)).toList());

  gettransacciones() =>
      transaccionesService.obtenerlisttransacciones().snapshots().map(
          (event) => event.docs.map((e) => Transacciones.fromJson(e)).toList());

  init() {
    transaccionesStream.listen((event) async {
      transacciones.value = event;
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

  metodobusqueda() {
    transaccionesnuevos.clear();
    final fechainicio = DateTime.parse(fromDateControler.text);
    final fechaultima = DateTime.parse(fromDateControler2.text);

    var response = transacciones.value = consultar
        .where((element) =>
            DateTime.parse(element.fecha!).isAtSameMomentAs(fechainicio) ||
            DateTime.parse(element.fecha!).isAfter(fechainicio) &&
                DateTime.parse(element.fecha!).isBefore(fechaultima))
        .toList();

    transaccionesnuevos.addAll(response);
    Get.toNamed(Routes.VENTANADEINFORMESTRANSACCIONES);
  }

  metodobusquedacobrador() {
    transaccionesnuevos.clear();
    final fechainicio = DateTime.parse(fromDateControler.text);
    final fechaultima = DateTime.parse(fromDateControler2.text);
    final cobradorid = selectobradores;

    var response = transacciones.value = consultar
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

    var transaccionesfiltradas =
        response.where((element) => element.cobrador == cobradorid!.id);
    transaccionesnuevos.addAll(transaccionesfiltradas);
    Get.toNamed(Routes.VENTANADEINFORMESTRANSACCIONES);
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
