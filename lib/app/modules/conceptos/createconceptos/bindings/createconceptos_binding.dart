import 'package:get/get.dart';

import '../controllers/createconceptos_controller.dart';

class CreateconceptosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateconceptosController>(
      () => CreateconceptosController(),
    );
  }
}
