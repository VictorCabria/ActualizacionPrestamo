import 'package:get/get.dart';

import '../controllers/createcobradores_controller.dart';

class CreatecobradoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatecobradoresController>(
      () => CreatecobradoresController(),
    );
  }
}
