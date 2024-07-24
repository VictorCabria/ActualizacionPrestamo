import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/cobradores_modal.dart';
import '../../../../models/recaudo_model.dart';
import '../../../../models/zone_model.dart';
import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/zona_service.dart';
import '../../../principal/home/controllers/home_controller.dart';

class CreateRecaudosController extends GetxController {
  String fecha = DateTime.now().toString();

  RxList<Zone> barriocontroller = RxList<Zone>([]);
  Zone? selectZone;
  final formkey = GlobalKey<FormState>();
  final HomeController homecontroller = Get.find<HomeController>();
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);
 late TextEditingController fromDateControler;
 DateTime selectedDate = DateTime.now();
 RxString hoy = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  Cobradores? cobrador;
  Cobradores? cobrador2;
  RxBool tipotransaccion = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fromDateControler = TextEditingController(text: hoy.value);
    
    cobradorescontroller.value = await getListCobrador();
    barriocontroller.value = await getListZona();
    update(['cobradores']);
    await getajustesinicial();
  }

  getListCobrador() async {
    return await cobradoresService.getCobradores();
  }

  Future<void> getajustesinicial() async {
    var res = await cobradoresService.getcobradores();
    if (res != null) {
      cobrador2 = cobradorescontroller
          .where((p0) => p0.id == homecontroller.cobradores!.id)
          .first;

      update(['cobradores']);
    }
  }

  getListZona() async {
    return await zonaService.getzones();
  }

  createrecaudo() async {
    if (formkey.currentState!.validate()) {
      if (kDebugMode) {
        print("Formulario valido ${homecontroller.cobradores!.id}");
      }
      var res = await recaudoService.createrecaudo(
          object: Recaudo.nueva(fromDateControler.text, homecontroller.cobradores!.id,
                  homecontroller.session!.id!, selectZone!.id!)
              .toJson());
      if (res != null) {
        Get.back(result: res);
      }
    }
  }
}
