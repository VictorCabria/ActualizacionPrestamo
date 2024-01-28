import 'package:get/get.dart';

import '../controllers/detallesdepagosrecaudos_controller.dart';

class DetallesdepagosrecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallesdepagosrecaudosController>(
      () => DetallesdepagosrecaudosController(),
    );
  }
}
