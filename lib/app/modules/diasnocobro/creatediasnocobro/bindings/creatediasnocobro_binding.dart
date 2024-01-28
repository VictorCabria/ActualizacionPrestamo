import 'package:get/get.dart';

import '../controllers/creatediasnocobro_controller.dart';

class CreatediasnocobroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatediasnocobroController>(
      () => CreatediasnocobroController(),
    );
  }
}
