import 'package:get/get.dart';

import '../controllers/registrarprestamos_controller.dart';

class RegistrarprestamosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrarprestamosController>(
      () => RegistrarprestamosController(),
    );
  }
}
