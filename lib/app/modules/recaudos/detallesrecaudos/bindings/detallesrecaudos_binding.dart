import 'package:get/get.dart';

import '../controllers/detallesrecaudos_controller.dart';

class DetallesrecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallesrecaudosController>(
      () => DetallesrecaudosController(),
    );
  }
}
