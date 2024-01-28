import 'package:get/get.dart';

import '../controllers/recaudar_controller.dart';

class RecaudarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecaudarController>(
      () => RecaudarController(),
    );
  }
}
