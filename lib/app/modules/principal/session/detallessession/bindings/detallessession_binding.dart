import 'package:get/get.dart';

import '../controllers/detallessession_controller.dart';

class DetallessessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetallessessionController>(
      () => DetallessessionController(),
    );
  }
}
