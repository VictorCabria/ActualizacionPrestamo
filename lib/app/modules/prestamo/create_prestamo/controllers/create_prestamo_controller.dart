import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/ajustes_modal.dart';
import '../../../../models/barrio_modal.dart';
import '../../../../models/client_model.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/diasnocobro_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/model_services/ajustes_services.dart';
import '../../../../services/model_services/barrio_service.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/diascobro_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/date_utils.dart';
import '../../../principal/home/controllers/home_controller.dart';



class CreatePrestamoController extends GetxController {
  final homeControll = Get.find<HomeController>();
DateTime selectedDate = DateTime.now();
  final loading = false.obs;
  final scrollController = ScrollController();
  TextEditingController? textController = TextEditingController();

  //inicializar variables
  Client? client;
  late TextEditingController clientecontroller,
      recorridocontroller,
      tipodeprestamocontroller,
      montoTextController;
  Zone? zona;
  Ajustes? ajustes;
  TypePrestamo? tipoPrestamo;
  TypePrestamo? tipoPrestam2;
  Cobradores? cobrador;
  Barrio? barrio;
  RxBool isRefinan = false.obs;
  RxBool isrenovado = false.obs;
  late Stream<List<Diasnocobro>> diasnocobroStream;
  RxList<Diasnocobro> diasnocobros = RxList<Diasnocobro>([]);
  Diasnocobro? diasnocobro;
   RxString fecha = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs; 
  Timestamp primerrecaudo = Timestamp.now();
  late TextEditingController fromDateControler;

  //inicializar listas
  final clients = [].obs;
  final zonas = [].obs;
  final tipoPrestamos = [].obs;

//calculos
  final monto = 0.0.obs;
  final porcentaje = 0.0.obs;
  final total = 0.0.obs;
  final cuotas = 0.obs;
  final meses = 0.obs;
  final valorCuota = '0.0'.obs;
  final detalle = ''.obs;
  final tipodeprestamos = "".obs;
  final cobrarsabado = false.obs;
  final cobrardomingo = false.obs;
  final formkey = GlobalKey<FormState>();
  @override
  void onInit() async {
    cobrador = homeControll.cobradores;
    clientecontroller = TextEditingController();
    recorridocontroller = TextEditingController();
    montoTextController = TextEditingController();
    tipodeprestamocontroller = TextEditingController();
    fromDateControler = TextEditingController(text: fecha.value);
    textController!.text = valorCuota.value;
    clients.value = await getListClients();
    zonas.value = await getListZona();
    diasnocobroStream = getdiasnocobro();
    tipoPrestamos.value = await getListTypePrestamo();
    await getajustesinicial();
    update(['recorrido', 'zone', 'tipoprestamo', 'monto']);

    super.onInit();
  }

  //init data
  getListClients() async {
    return await clientService.getClients();
  }

  getListZona() async {
    return await zonaService.getzones();
  }

  getListTypePrestamo() async {
    return await typePrestamoService.getTypes();
  }

  getdiasnocobro() => diasnocobroServiceService
      .obtenerlistcobrorefernce()
      .snapshots()
      .map((event) => event.docs.map((e) => Diasnocobro.fromJson(e)).toList());

  //onchange events
  onChangeClient(Client? client) async {
    if (client != null) {
      this.client = client;
      String idBarrio = client.barrio['id'];
      barrio = await barrioService.selectBarrio(idBarrio);
      update(['recorrido']);
      if (barrio != null) {
        zona = zonas.where((z) => z.id == barrio!.zona['id']).first;
        update(['zone']);
      }
    }
  }

  onChangecliente() async {
    try {
      var res = await Get.toNamed(Routes.SEACHCLIENTE2);
      print("res ${res.recorrido}");
      if (res != null) {
        client = res;
        var lista = clients.where((c) => c.id == res.id).toList();
        client = lista.isNotEmpty ? lista.first : res;
        clientecontroller.text = client!.nombre!;

        var idBarrio = client!.barrio['id'];
        barrio = await barrioService.selectBarrio(idBarrio);
        print("Tipo prestamo${barrio}");

        if (barrio != null) {
          zona = zonas.where((z) => z.id == barrio!.zona['id']).first;
          update(['zone', 'recorrido']);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  onChangetypeprestamo() async {
    try {
      var res = await Get.toNamed(Routes.SEACHTIPOPRESTAMO);
      print("res ${res.nombre}");
      if (res != null) {
        tipoPrestamo = res;
        var lista = tipoPrestamos.where((c) => c.id == res.id).toList();
        tipoPrestamo = lista.isNotEmpty ? lista.first : res;
        tipodeprestamocontroller.text = tipoPrestamo!.nombre!;
        calculoPrestamo(tipoPrestamo, null, null);
      }
    } catch (error) {
      print(error);
    }
  }

  onChangeZona(Zone? zona) {
    if (zona != null) {
      this.zona = zona;
    }
  }

  onChangerecorrido(Client? client) {
    if (client != null) {
      this.client = client;
    }
  }

  Future<void> getajustesinicial() async {
    var res = await ajustesservice.getajustes();
    if (res != null) {
      ajustes = res;
      cobrarsabado.value = ajustes!.cobrarsabados!;
      cobrardomingo.value = ajustes!.cobrardomingos!;
      tipoPrestamo =
          tipoPrestamos.where((p0) => p0.id == ajustes!.tipoprestamoid).first;
      monto.value = ajustes!.monto!;
      montoTextController.text = monto.value.toString();
      tipodeprestamocontroller.text = tipoPrestamo!.nombre!;
      calculoPrestamo(tipoPrestamo, monto.value, null);
    }
  }

  onChangeTipoPrestamo(TypePrestamo? tipoPrestamo) {
    if (tipoPrestamo != null) {
      this.tipoPrestamo = tipoPrestamo;
      calculoPrestamo(this.tipoPrestamo, null, null);
    }
  }

  onChangeMonto(String monto) {
    this.monto.value = double.parse(monto);
    calculoPrestamo(null, this.monto.value, null);
  }

  onChangeCuota(String cuota) {
    valorCuota.value = double.parse(cuota).toString();
    calculoPrestamo(null, null, double.parse(cuota));
  }

  //calculo de prestamo
  void calculoPrestamo(TypePrestamo? tipo, double? monto, double? cuota) {
    if (tipo != null) {
      print("tipo");
      cuotas.value = tipo.cuotas!;
      porcentaje.value = tipo.porcentaje!;
      meses.value = tipo.meses!;
      total.value =
          this.monto.value + (this.monto.value * (porcentaje.value / 100));
      valorCuota.value = (total.value / cuotas.value).toStringAsFixed(1);
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      textController!.text = valorCuota.value;
      calcularDetalle();
    }
    if (monto != null) {
      print("monto");
      total.value =
          this.monto.value + (this.monto.value * (porcentaje.value / 100));
      valorCuota.value = (total.value / cuotas.value).toStringAsFixed(1);
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      textController!.text = valorCuota.value;
      calcularDetalle();
    }

    if (cuota != null) {
      cuotas.value = (total.value / double.parse(valorCuota.value)).round();
      double auxTotal = cuotas.value * double.parse(valorCuota.value);
      cuotas.value += total.value - auxTotal > 0 ? 1 : 0;
      calcularDetalle();
    }
  }

  calcularDetalle() {
    try {
      int aux = 0;
      int aux2 = 0;
      double auxTotal = total.value;
      double auxCuota = double.parse(valorCuota.value);

      for (int i = 0; i < cuotas.value; i++) {
        if (double.parse(auxTotal.toStringAsFixed(1)) >=
            double.parse(auxCuota.toStringAsFixed(1))) {
          aux++;
          auxTotal = auxTotal - auxCuota;
        } else {
          print("total $auxTotal cuota $auxCuota");
          aux2++;
        }
      }
      if (aux2 > 0) {
        detalle.value =
            '$aux cuotas de $valorCuota y $aux2 cuotas de ${auxTotal.toStringAsFixed(1)}';
      } else {
        detalle.value = '$aux cuotas de $valorCuota';
      }
    } catch (error) {
      print(error);
    }
  }

  void createPrestamo() async {
    print("Fecha inicial para el limite${fromDateControler.text}");
     final fechavencido = getfechadevencimiento(
        DateTime.parse(fromDateControler.text), tipoPrestamo!.meses!); 

    tipoPrestam2 =
        await typePrestamoService.selecttypeprestamoid(tipoPrestamo!.id!);

    var aux = DateTime.parse(fromDateControler.text);

    final fechaactualizada = "".obs;
    if (tipoPrestam2!.tipo['tipo'] == "Diario") {
      aux = aux.add(const Duration(days: 1));
      if (cobrarsabado.value != true) {
        if (aux.weekday == DateTime.saturday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (cobrardomingo.value != true) {
        if (aux.weekday == DateTime.sunday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (diasnocobros.isNotEmpty) {
        print("Dias no cobro$aux");
        final res = diasnocobros
            .where(
                (element) => DateTime.parse(element.dia!).isAtSameMomentAs(aux))
            .toList();
        print("resultado dias no cobro $res");
        if (res.isNotEmpty) {
          aux = aux.add(const Duration(days: 1));
        }
      }

      fechaactualizada.value = aux.toString();
    }
    if (tipoPrestam2!.tipo['tipo'] == "Semanal") {
      aux = aux.add(const Duration(days: 7));

      if (cobrarsabado.value != true) {
        if (aux.weekday == DateTime.saturday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (cobrardomingo.value != true) {
        if (aux.weekday == DateTime.sunday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (diasnocobros.isNotEmpty) {
        print("Dias no cobro$aux");
        final res = diasnocobros
            .where(
                (element) => DateTime.parse(element.dia!).isAtSameMomentAs(aux))
            .toList();
        print("resultado dias no cobro $res");
        if (res.isNotEmpty) {
          aux = aux.add(const Duration(days: 1));
        }
      }

      fechaactualizada.value = aux.toString();
    }
    if (tipoPrestam2!.tipo['tipo'] == "Quincenal") {
      aux = aux.add(const Duration(days: 15));

      if (cobrarsabado.value != true) {
        if (aux.weekday == DateTime.saturday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (cobrardomingo.value != true) {
        if (aux.weekday == DateTime.sunday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (diasnocobros.isNotEmpty) {
        print("Dias no cobro$aux");
        final res = diasnocobros
            .where(
                (element) => DateTime.parse(element.dia!).isAtSameMomentAs(aux))
            .toList();
        print("resultado dias no cobro $res");
        if (res.isNotEmpty) {
          aux = aux.add(const Duration(days: 1));
        }
      }

      fechaactualizada.value = aux.toString();
    }
    if (tipoPrestam2!.tipo['tipo'] == "Mensual") {
      aux = aux.add(const Duration(days: 30));

      if (cobrarsabado.value != true) {
        if (aux.weekday == DateTime.saturday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (cobrardomingo.value != true) {
        if (aux.weekday == DateTime.sunday) {
          aux = aux.add(const Duration(days: 1));
        }
      }
      if (diasnocobros.isNotEmpty) {
        print("Dias no cobro$aux");
        final res = diasnocobros
            .where(
                (element) => DateTime.parse(element.dia!).isAtSameMomentAs(aux))
            .toList();
        print("resultado dias no cobro $res");
        if (res.isNotEmpty) {
          aux = aux.add(const Duration(days: 1));
        }
      }

      fechaactualizada.value = aux.toString();
    }

    Prestamo prestamo = Prestamo(
      clienteId: client!.id,
      cobradorId: cobrador!.id,
      detalle: detalle.value,
      fecha: fromDateControler.text,
      monto: monto.value,
      zonaId: zona!.id,
      estado: StatusPrestamo.aldia.name,
      fechalimite: fechavencido.toString(),
      refinanciado: isRefinan.value,
      renovado: isrenovado.value,
      fechaPago: fechaactualizada.value,
      recorrido: client!.id,
      listanegra: false,
      numeroDeCuota: cuotas.value,
      porcentaje: porcentaje.value,
      saldoPrestamo: total.value,
      sesionId: homeControll.session!.id,
      tipoPrestamoId: tipoPrestamo!.id,
      totalPrestamo: total.value,
      valorCuota: double.parse(valorCuota.value),
    );

    if (homeControll.session!.id != null) {
      if (formkey.currentState!.validate()) {
        if (kDebugMode) {
          print("Formulario valido ${cobrador!.nombre}");
        }
        var response = await prestamoService.saveprestamo(prestamo);
        prestamo.id = response;

        Get.back(result: prestamo);
        print("Prestamo${response}");
      } else {
        print("no validado");
      }
    } else {
      print("no hay session");
    }
  }


    getfechadevencimiento(DateTime fechainicial, int numerodemeses) {
    var init = fechainicial;
    for (int i = 1; i <= numerodemeses; i++) {
      final fechas = DateUtils2.daysInMonth(init);
      fechas.removeWhere((element) => element.month != init.month);
      int dias = fechas.length;

      init = init.add(Duration(days: dias));
    }

    return init;
  }  


}
