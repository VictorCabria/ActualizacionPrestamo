import 'package:get/get.dart';

import '../controllers/ventanacuotaprestamo_controller.dart';

class VentanacuotaprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanacuotaprestamoController>(
      () => VentanacuotaprestamoController(),
    );
  }
}
