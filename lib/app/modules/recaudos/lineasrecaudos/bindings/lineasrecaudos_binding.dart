import 'package:get/get.dart';

import '../controllers/lineasrecaudos_controller.dart';

class LineasrecaudosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LineasrecaudosController>(
      () => LineasrecaudosController(),
    );
  }
}
