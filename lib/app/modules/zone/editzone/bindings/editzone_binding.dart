import 'package:get/get.dart';

import '../controllers/editzone_controller.dart';

class EditzoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditzoneController>(
      () => EditzoneController(),
    );
  }
}
