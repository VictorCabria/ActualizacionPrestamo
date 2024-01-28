import 'package:get/get.dart';

import '../controllers/ventanadeinformeprestamo_controller.dart';

class VentanadeinformeprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanadeinformeprestamoController>(
      () => VentanadeinformeprestamoController(),
    );
  }
}
