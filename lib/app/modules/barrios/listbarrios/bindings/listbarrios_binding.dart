import 'package:get/get.dart';

import '../controllers/listbarrios_controller.dart';

class ListbarriosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListbarriosController>(
      () => ListbarriosController(),
    );
  }
}
