import 'package:get/get.dart';

import '../controllers/panelrecaudos_controller.dart';

class PanelrecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanelrecaudosController>(
      () => PanelrecaudosController(),
    );
  }
}
