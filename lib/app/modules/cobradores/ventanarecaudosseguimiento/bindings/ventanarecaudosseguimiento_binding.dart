import 'package:get/get.dart';

import '../controllers/ventanarecaudosseguimiento_controller.dart';

class VentanarecaudosseguimientoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanarecaudosseguimientoController>(
      () => VentanarecaudosseguimientoController(),
    );
  }
}
