import 'package:get/get.dart';

import '../controllers/ventanarecaudotodos_controller.dart';

class VentanarecaudotodosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanarecaudotodosController>(
      () => VentanarecaudotodosController(),
    );
  }
}
