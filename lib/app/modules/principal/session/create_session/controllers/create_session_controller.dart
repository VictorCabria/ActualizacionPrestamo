import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../models/cobradores_modal.dart';
import '../../../../../models/session_model.dart';
import '../../../../../models/transaction_model.dart';
import '../../../../../models/zone_model.dart';
import '../../../../../services/model_services/cobradores_service.dart';
import '../../../../../services/model_services/session_service.dart';
import '../../../../../services/model_services/transacciones_service.dart';
import '../../../../../services/model_services/zona_service.dart';
import '../../../ajustes/controllers/ajustes_controller.dart';
import '../../../home/controllers/home_controller.dart';

class CreateSessionController extends GetxController {
  //controles de formulario
  final loading = false.obs;
  final scrollController = ScrollController();

  //inicializar variables
  Session? session;
  final homeControll = Get.find<HomeController>();
  final ajustscontroller = Get.find<AjustesController>();
  Cobradores? cobrador;
  Cobradores? cobrador2;
  final cobradores = [].obs;
  Zone? zona;
  DateTime selectedDate = DateTime.now();
  final obtenervalorinicial = 0.0.obs;
  late TextEditingController fromDateControler;
  final zonas = [].obs;
  RxString hoy = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  late TextEditingController controller, controller2;
  final valorInicial = 0.0.obs;
  final formkey = GlobalKey<FormState>();
  @override
  void onInit() async {
    getinicialvalorinicial();
   fromDateControler = TextEditingController(text: hoy.value);
    controller2 = TextEditingController(text: valorInicial.toString());
    /* controller = TextEditingController(text: valorInicial.toString())
      ..selection = TextSelection(
          baseOffset: 0, extentOffset: valorInicial.toString().length); */
    super.onInit();

    cobradores.value = await getListCobrador();
    zonas.value = await getListZona();
    update(['cobradores']);
    await getajustesinicial();
  }

  getinicialvalorinicial() {
    if (homeControll.session != null) {
      valorInicial.value = homeControll.session!.pyg!;
    }
  }

  getListCobrador() async {
    return await cobradoresService.getCobradores();
  }

  getListZona() async {
    return await zonaService.getzones();
  }

  Future<void> getajustesinicial() async {
    var res = await cobradoresService.getcobradores();
    if (res != null) {
      cobrador2 =
          cobradores.where((p0) => p0.id == homeControll.cobradores!.id).first;

      update(['cobradores']);
    }
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  createSession() async {
    if (formkey.currentState!.validate()) {
      if (kDebugMode) {
        print("Formulario valido ");
      }
      var res = await sessionService.createSession(
          object: Session.nueva(fromDateControler.text, cobrador2!.id, valorInicial.value,
                  zona!.id, homeControll.sessionAnterior)
              .toJson());
      if (res != null) {
        if (homeControll.sessionAnterior != null) {
          if (res.pyg != homeControll.sessionAnterior!.pyg) {
            final total = res.pyg! - homeControll.sessionAnterior!.pyg!;
            var idConcept;
            if (total > 0) {
              idConcept = ajustscontroller.ajustes!.positivo;
            } else {
              idConcept = ajustscontroller.ajustes!.negativo;
            }

            Transacciones transacciones = Transacciones(
                cobrador: cobrador2!.id,
                valor: total,
                concept: idConcept,
                idSession: homeControll.sessionAnterior!.id,
                fecha: fromDateControler.text);
            transaccionesService.savetransacciones(transacciones);
          }
        }

        Get.back(result: res);
      } else {
        Get.snackbar(
          "Error",
          "No se pudo crear la sesión",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  /* selectAll() {
    if (valorInicial.toString().isNotEmpty) return;
    controller = TextEditingController(text: valorInicial.toString())
      ..selection = TextSelection(
          baseOffset: 0, extentOffset: valorInicial.toString().length);
  } */

  void selectAll2() {
    if (controller2.text.isEmpty) return;
    controller2.selection = TextSelection(
      baseOffset: 0,
      affinity: TextAffinity.downstream,
      extentOffset: controller2.text.length,
    );
  }
}
