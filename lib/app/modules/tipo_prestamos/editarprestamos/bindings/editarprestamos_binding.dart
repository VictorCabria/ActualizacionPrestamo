import 'package:get/get.dart';

import '../controllers/editarprestamos_controller.dart';

class EditarprestamosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditarprestamosController>(
      () => EditarprestamosController(),
    );
  }
}
