import 'package:get/get.dart';

import '../controllers/detallesdepagorecaudos_controller.dart';

class DetallesdepagorecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallesdepagorecaudosController>(
      () => DetallesdepagorecaudosController(),
    );
  }
}
