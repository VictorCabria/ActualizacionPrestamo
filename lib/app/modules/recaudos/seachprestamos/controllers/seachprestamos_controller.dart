import 'package:get/get.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/prestamo_service.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';

class SeachprestamosController extends GetxController {
  //TODO: Implement SeachprestamosController
  RxList<Prestamo> prestamos = RxList<Prestamo>([]);
  RxList<Prestamo> consultar = RxList<Prestamo>([]);
  List<Prestamo> get prestamosget => prestamos;
  late Stream<List<Prestamo>> clientStream;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  @override
  void onInit() async {
    clientStream = getcliente();
    super.onInit();
    init();
  }

  /* getListPrestamo() async {
    isloading.value = true;
    var response = await prestamoService.getPrestamos();
    print(response);
    if (response.isNotEmpty) {
      prestamos.value = response;
      consultar.value = response;
    }
    isloading.value = false;
  } */

  init() {
    clientStream.listen((event) async {
      prestamos.value = event;
      consultar.value = event;
      searching('');
    });
  }

  getcliente() => prestamoService
      .obtenerlistprestamo().orderBy('recorrido')
      .snapshots()
      .map((event) => event.docs.map((e) => Prestamo.fromJson(e)).toList());

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      prestamos.value = consultar;
    }
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  searching(String texto) {
    if (texto != '') {
      prestamos.value = consultar
          .where((element) => (element.recorrido!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      prestamos.value = consultar;
    }
  }

  gettipoprestamoById(String id) async {
    var response = await typePrestamoService.getprestamoById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  void doSelection(Prestamo prestamos) {
    Get.back(result: prestamos);
  }
}
