import 'package:get/get.dart';

import '../controllers/edittransacciones_controller.dart';

class EdittransaccionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EdittransaccionesController>(
      () => EdittransaccionesController(),
    );
  }
}
