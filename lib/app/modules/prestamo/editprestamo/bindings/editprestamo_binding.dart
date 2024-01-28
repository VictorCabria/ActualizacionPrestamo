import 'package:get/get.dart';

import '../controllers/editprestamo_controller.dart';

class EditprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditprestamoController>(
      () => EditprestamoController(),
    );
  }
}
