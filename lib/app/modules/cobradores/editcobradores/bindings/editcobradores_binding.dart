import 'package:get/get.dart';

import '../controllers/editcobradores_controller.dart';

class EditcobradoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditcobradoresController>(
      () => EditcobradoresController(),
    );
  }
}
