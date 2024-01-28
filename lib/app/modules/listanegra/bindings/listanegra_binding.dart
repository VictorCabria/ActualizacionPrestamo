import 'package:get/get.dart';

import '../controllers/listanegra_controller.dart';

class ListanegraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListanegraController>(
      () => ListanegraController(),
    );
  }
}
