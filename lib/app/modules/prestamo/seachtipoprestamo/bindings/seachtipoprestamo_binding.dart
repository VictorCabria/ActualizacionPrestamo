import 'package:get/get.dart';

import '../controllers/seachtipoprestamo_controller.dart';

class SeachtipoprestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeachtipoprestamoController>(
      () => SeachtipoprestamoController(),
    );
  }
}
