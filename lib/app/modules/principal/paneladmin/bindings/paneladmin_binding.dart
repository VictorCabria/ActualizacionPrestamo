import 'package:get/get.dart';

import '../controllers/paneladmin_controller.dart';

class PaneladminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaneladminController>(
      () => PaneladminController(),
    );
  }
}
