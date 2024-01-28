import 'package:get/get.dart';
import 'package:prestamo_mc/app/models/client_model.dart';

import '../../../../services/model_services/client_service.dart';

class Seachcliente2Controller extends GetxController {
  //TODO: Implement Seachcliente2Controller

  RxList<Client> client = RxList<Client>([]);
  RxList<Client> consultar = RxList<Client>([]);
  List<Client> get clientget => client;
  late Stream<List<Client>> clientStream;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  @override
  void onInit() async {
    /*   await getListPrestamo(); */
    clientStream = getcliente();

    super.onInit();
    init();
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      client.value = consultar;
    }
  }

  getcliente() => clientService
      .obtenerlist()
      .snapshots()
      .map((event) => event.docs.map((e) => Client.fromJsonMap(e)).toList());

  init() {
    clientStream.listen((event) async {
      client.value = event;
      consultar.value = event;
      searching('');
    });
  }

  searching(String texto) {
    if (texto != '') {
      client.value = consultar
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      client.value = consultar;
    }
  }

/* 
  getListPrestamo() async {
    isloading.value = true;
    var response = await clientService.getClients();
    print(response);
    if (response.isNotEmpty) {
      client.value = response;
      consultar.value = response;
      searching('');
    }
    isloading.value = false;
  } */

  void doSelection(Client client) {
    Get.back(result: client);
  }
}
