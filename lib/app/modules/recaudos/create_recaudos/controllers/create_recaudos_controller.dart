import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/cobradores_modal.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';
import 'package:prestamo_mc/app/models/zone_model.dart';
import 'package:prestamo_mc/app/modules/principal/home/controllers/home_controller.dart';

import '../../../../services/model_services/cobradores_service.dart';
import '../../../../services/model_services/recaudos_service.dart';
import '../../../../services/model_services/zona_service.dart';

class CreateRecaudosController extends GetxController {
  String fecha = DateTime.now().toString();

  RxList<Zone> barriocontroller = RxList<Zone>([]);
  Zone? selectZone;
  final formkey = GlobalKey<FormState>();
  final HomeController homecontroller = Get.find<HomeController>();
  RxList<Cobradores> cobradorescontroller = RxList<Cobradores>([]);

  Cobradores? cobrador;
  Cobradores? cobrador2;
  RxBool tipotransaccion = false.obs;

  @override
  void onInit() async {
    super.onInit();
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
          object: Recaudo.nueva(fecha, homecontroller.cobradores!.id,
                  homecontroller.session!.id!, selectZone!.id!)
              .toJson());
      if (res != null) {
        Get.back(result: res);
      }
    }
  }
}
