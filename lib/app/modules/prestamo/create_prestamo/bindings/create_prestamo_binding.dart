import 'package:get/get.dart';

import '../controllers/create_prestamo_controller.dart';

class CreatePrestamoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePrestamoController>(
      () => CreatePrestamoController(),
    );
  }
}
