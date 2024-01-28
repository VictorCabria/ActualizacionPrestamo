import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/session_model.dart';
import 'package:prestamo_mc/app/routes/app_pages.dart';
import 'package:prestamo_mc/app/services/model_services/cobradores_service.dart';
import 'package:prestamo_mc/app/utils/references.dart';

import '../../../../../services/model_services/session_service.dart';
import '../../../home/controllers/home_controller.dart';

class ListasesionController extends GetxController {
  //TODO: Implement ListasesionController

  RxList<Session> session = RxList<Session>([]);
  RxList<Session> selectedItem = RxList<Session>([]);

  List<Session> get sessionget => session;
  final homeControll = Get.find<HomeController>();
  late Stream<List<Session>> sessionStream;
  RxBool isMultiSelectionEnabled = false.obs;
  RxBool isloading = false.obs;
  @override
  void onInit() {
    sessionStream = getsession();
    super.onInit();
    init();
  }

  getsession() => sessionService
      .obtenerlistsesion()
      .snapshots()
      .map((event) => event.docs.map((e) => Session.fromJson(e)).toList());

  init() {
    sessionStream.listen((event) async {
      session.value = event;
    });
  }

  getcobradorById(String id) async {
    var response = await cobradoresService.getcobradoresById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  void doMultiSelection(Session session) {
    if (isMultiSelectionEnabled.value) {
      if (selectedItem.contains(session)) {
        selectedItem.remove(session);
      } else {
        selectedItem.add(session);
      }
    } else {
      detallessesion(session);
    }
  }

  String getSelectedsession() {
    return selectedItem.isNotEmpty ? "${selectedItem.length}" : "";
  }

  detallessesion(Session sesion) {
    Get.toNamed(Routes.DETALLESDETODASSESIONES,
        arguments: {firebaseReferences.sessions: sesion});
  }

  delete() async {
    for (var i in selectedItem) {
      sessionService.deletesession(i);
    }
  }
}
