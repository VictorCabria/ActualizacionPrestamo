import 'package:get/get.dart';

import '../controllers/ventanainforme_controller.dart';

class VentanainformeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanainformeController>(
      () => VentanainformeController(),
    );
  }
}
