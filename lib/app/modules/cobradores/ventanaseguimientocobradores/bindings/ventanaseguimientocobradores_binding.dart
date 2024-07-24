import 'package:get/get.dart';

import '../controllers/ventanaseguimientocobradores_controller.dart';

class VentanaseguimientocobradoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanaseguimientocobradoresController>(
      () => VentanaseguimientocobradoresController(),
    );
  }
}
