import 'package:get/get.dart';

import '../controllers/refinanciacionprestamo_controller.dart';

class RefinanciacionprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefinanciacionprestamoController>(
      () => RefinanciacionprestamoController(),
    );
  }
}
