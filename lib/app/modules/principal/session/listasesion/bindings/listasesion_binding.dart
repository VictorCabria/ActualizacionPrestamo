import 'package:get/get.dart';

import '../controllers/listasesion_controller.dart';

class ListasesionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListasesionController>(
      () => ListasesionController(),
    );
  }
}
