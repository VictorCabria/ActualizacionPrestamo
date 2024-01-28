import 'package:get/get.dart';

import '../../../../models/cuotas_modal.dart';
import '../../../../models/prestamo_model.dart';
import '../../../../services/model_services/client_service.dart';
import '../../../../services/model_services/cuota_service.dart';
import '../../../../utils/app_constants.dart';
import '../../../principal/home/controllers/home_controller.dart';

class VentanacuotaprestamoController extends GetxController {
  final homeControll = Get.find<HomeController>();
  RxList<Cuotas> cuotas = RxList<Cuotas>([]);
  RxList<Cuotas> cuotasrestantes = RxList<Cuotas>([]);
  late Stream<List<Cuotas>> cuotaStream;
  List<Cuotas> get cuotaget => cuotas;
  RxBool isloading = false.obs;
  final loadinReciente = true.obs;
  final pagados = 0.obs;
  final nopagados = 0.obs;
  final montosuma = 0.0.obs;
  Prestamo? prestamo;
  @override
  void onInit() {
    prestamo = Get.arguments['prestamos'];
    /*  cuotaStream = getrecaudo(); */

    getcuota2();
    monto();
    super.onInit();
  }

  /* getrecaudo() => cuotaService
      .obtenerlistcuota()
      .where('idprestmo', isEqualTo: prestamo!.id)
      .orderBy('fechadepago')
      .snapshots()
      .map((event) => event.docs.map((e) => Cuotas.fromJson(e)).toList()); */

  getcuota2() async {
    print("Id de prestamo${prestamo!.id}");

    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);
    if (response.isNotEmpty) {
      loadinReciente.value = true;
      cuotas.value = response;
    }
    loadinReciente.value = false;
    print(cuotas);
  }

  getClientById(String id) async {
    var response = await clientService.getClientById(id);
    if (response.isNotEmpty) {
      return response.first;
    }
  }

  consultarpagados(Prestamo prestamocuota) async {
    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);

    var listacuota =
        response.where((p0) => p0.idprestmo == prestamocuota.id).toList();
    if (listacuota.isNotEmpty) {
      pagados.value = response
          .where((e) => e.estado! == Statuscuota.pagado.name)
          .toList()
          .length;
      return pagados;
    }
  }

  consultarrestantes(Prestamo prestamocuota) async {
    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);

    var listacuota =
        response.where((p0) => p0.idprestmo == prestamocuota.id).toList();
    if (listacuota.isNotEmpty) {
      nopagados.value = response
          .where((e) => e.estado! == Statuscuota.nopagado.name)
          .toList()
          .length;
      return nopagados;
    }
  }

  monto() async {
    var response =
        await cuotaService.getlistacuotasub(documentId: prestamo!.id!);
    montosuma.value = 0;
    for (var i in response) {
      montosuma.value += i.valorpagado!.toInt();
    }
  }
}
