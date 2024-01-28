import 'package:get/get.dart';

import '../controllers/detallesdetodassesiones_controller.dart';

class DetallesdetodassesionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallesdetodassesionesController>(
      () => DetallesdetodassesionesController(),
    );
  }
}
