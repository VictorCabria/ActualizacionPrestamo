import 'package:get/get.dart';

import '../controllers/ventanarecaudosprestamo_controller.dart';

class VentanarecaudosprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanarecaudosprestamoController>(
      () => VentanarecaudosprestamoController(),
    );
  }
}
