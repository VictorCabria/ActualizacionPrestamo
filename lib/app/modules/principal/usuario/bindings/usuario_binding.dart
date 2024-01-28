import 'package:get/get.dart';

import '../controllers/usuario_controller.dart';

class UsuarioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsuarioController>(
      () => UsuarioController(),
    );
  }
}
