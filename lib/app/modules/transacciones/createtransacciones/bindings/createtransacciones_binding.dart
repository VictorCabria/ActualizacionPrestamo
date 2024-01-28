import 'package:get/get.dart';

import '../controllers/createtransacciones_controller.dart';

class CreatetransaccionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatetransaccionesController>(
      () => CreatetransaccionesController(),
    );
  }
}
