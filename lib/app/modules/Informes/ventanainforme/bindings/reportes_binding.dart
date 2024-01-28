import 'package:get/get.dart';

import '../controllers/reportes_controller.dart';

class ReportesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportesController>(
      () => ReportesController(),
    );
  }
}
