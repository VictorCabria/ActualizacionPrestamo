import 'package:get/get.dart';

import '../controllers/recaudarprestamo_controller.dart';

class RecaudarprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecaudarprestamoController>(
      () => RecaudarprestamoController(),
    );
  }
}
