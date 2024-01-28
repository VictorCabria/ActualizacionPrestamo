import 'package:get/get.dart';

import '../controllers/renovacionprestamo_controller.dart';

class RenovacionprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RenovacionprestamoController>(
      () => RenovacionprestamoController(),
    );
  }
}
