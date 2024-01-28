import 'package:get/get.dart';

import '../controllers/ventanadeinformesrecaudos_controller.dart';

class VentanadeinformesrecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanadeinformesrecaudosController>(
      () => VentanadeinformesrecaudosController(),
    );
  }
}
