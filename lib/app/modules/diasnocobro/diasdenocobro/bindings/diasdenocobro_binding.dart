import 'package:get/get.dart';

import '../controllers/diasdenocobro_controller.dart';

class DiasdenocobroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiasdenocobroController>(
      () => DiasdenocobroController(),
    );
  }
}
