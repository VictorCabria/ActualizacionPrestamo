import 'package:get/get.dart';

import '../controllers/ventanadeinformestransacciones_controller.dart';

class VentanadeinformestransaccionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanadeinformestransaccionesController>(
      () => VentanadeinformestransaccionesController(),
    );
  }
}
