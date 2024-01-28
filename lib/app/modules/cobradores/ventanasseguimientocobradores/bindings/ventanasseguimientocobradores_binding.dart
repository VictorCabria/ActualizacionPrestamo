import 'package:get/get.dart';

import '../controllers/ventanasseguimientocobradores_controller.dart';

class VentanasseguimientocobradoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanasseguimientocobradoresController>(
      () => VentanasseguimientocobradoresController(),
    );
  }
}
