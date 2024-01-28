import 'package:get/get.dart';

import '../controllers/editconceptos_controller.dart';

class EditconceptosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditconceptosController>(
      () => EditconceptosController(),
    );
  }
}
