import 'package:get/get.dart';

import '../controllers/listatransacciones_controller.dart';

class ListatransaccionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListatransaccionesController>(
      () => ListatransaccionesController(),
    );
  }
}
