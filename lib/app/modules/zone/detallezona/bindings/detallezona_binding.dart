import 'package:get/get.dart';

import '../controllers/detallezona_controller.dart';

class DetallezonaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallezonaController>(
      () => DetallezonaController(),
    );
  }
}
