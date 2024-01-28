import 'package:get/get.dart';

import '../controllers/detalleprestamo_controller.dart';

class DetalleprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetalleprestamoController>(
      () => DetalleprestamoController(),
    );
  }
}
