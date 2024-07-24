import 'package:get/get.dart';

import '../controllers/ventanarecaudotodo_controller.dart';

class VentanarecaudotodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentanarecaudotodoController>(
      () => VentanarecaudotodoController(),
    );
  }
}
