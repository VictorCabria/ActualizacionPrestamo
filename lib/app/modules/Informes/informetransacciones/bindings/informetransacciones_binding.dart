import 'package:get/get.dart';

import '../controllers/informetransacciones_controller.dart';

class InformetransaccionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformetransaccionesController>(
      () => InformetransaccionesController(),
    );
  }
}
