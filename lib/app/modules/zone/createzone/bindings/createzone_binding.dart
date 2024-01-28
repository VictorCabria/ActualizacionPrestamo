import 'package:get/get.dart';

import '../controllers/createzone_controller.dart';

class CreatezoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatezoneController>(
      () => CreatezoneController(),
    );
  }
}
