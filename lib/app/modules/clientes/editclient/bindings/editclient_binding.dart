import 'package:get/get.dart';

import '../controllers/editclient_controller.dart';

class EditclientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditclientController>(
      () => EditclientController(),
    );
  }
}
