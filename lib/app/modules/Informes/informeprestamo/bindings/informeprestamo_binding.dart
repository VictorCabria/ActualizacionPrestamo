import 'package:get/get.dart';

import '../controllers/informeprestamo_controller.dart';

class InformeprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformeprestamoController>(
      () => InformeprestamoController(),
    );
  }
}
