import 'package:get/get.dart';

import '../controllers/editbarrios_controller.dart';

class EditbarriosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditbarriosController>(
      () => EditbarriosController(),
    );
  }
}
