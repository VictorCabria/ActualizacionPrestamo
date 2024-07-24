import 'package:get/get.dart';
import '../../../../models/type_prestamo_model.dart';
import '../../../../services/model_services/tipoprestamo_service.dart';

class SeachtipoprestamoController extends GetxController {
  RxList<TypePrestamo> typeprstamo = RxList<TypePrestamo>([]);
  RxList<TypePrestamo> typeconsulta = RxList<TypePrestamo>([]);
  List<TypePrestamo> get typeprestamoget => typeprstamo;
  late Stream<List<TypePrestamo>> typeprestamoStream;
  RxBool isloading = false.obs;
  RxBool isBuscar = false.obs;
  @override
  void onInit() async {
    /*   await getListPrestamo(); */
    typeprestamoStream = gettypeprestamo();
    super.onInit();
    init();
    print("Typo de prestamo${typeprstamo}");
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      typeprstamo.value = typeconsulta;
    }
  }

  gettypeprestamo() => typePrestamoService
      .obtenerlistprestamo2()
      .snapshots()
      .map((event) => event.docs.map((e) => TypePrestamo.fromJson(e)).toList());

  init() {
    typeprestamoStream.listen((event) async {
      typeprstamo.value = event;
      typeconsulta.value = event;
      searching('');
    });
  }

  searching(String texto) {
    if (texto != '') {
      typeprstamo.value = typeconsulta
          .where((element) => (element.nombre!)
              .toString()
              .toUpperCase()
              .contains(texto.toUpperCase()))
          .toList();
    } else {
      typeprstamo.value = typeconsulta;
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

  void doSelection(TypePrestamo tipoprestamo) {
    Get.back(result: tipoprestamo);
  }
}
