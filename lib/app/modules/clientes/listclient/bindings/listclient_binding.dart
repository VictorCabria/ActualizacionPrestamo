import 'package:get/get.dart';

import '../controllers/listclient_controller.dart';

class ListclientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListclientController>(
      () => ListclientController(),
    );
  }
}
