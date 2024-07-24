import 'package:get/get.dart';

import '../controllers/listasnegra_controller.dart';

class ListasnegraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListasnegraController>(
      () => ListasnegraController(),
    );
  }
}
