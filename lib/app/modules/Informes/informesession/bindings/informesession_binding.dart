import 'package:get/get.dart';

import '../controllers/informesession_controller.dart';

class InformesessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformesessionController>(
      () => InformesessionController(),
    );
  }
}
