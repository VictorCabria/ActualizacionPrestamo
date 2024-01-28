import 'package:get/get.dart';

import '../controllers/registrarcliente_controller.dart';

class RegistrarclienteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrarclienteController>(
      () => RegistrarclienteController(),
    );
  }
}
