import 'package:get/get.dart';

import '../controllers/ventanadeinformessession_controller.dart';

class VentanadeinformessessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanadeinformessessionController>(
      () => VentanadeinformessessionController(),
    );
  }
}
