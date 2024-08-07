import 'package:get/get.dart';

import '../modules/barrios/createbarrios/bindings/createbarrios_binding.dart';
import '../modules/barrios/createbarrios/views/createbarrios_view.dart';
import '../modules/barrios/editbarrios/bindings/editbarrios_binding.dart';
import '../modules/barrios/editbarrios/views/editbarrios_view.dart';
import '../modules/barrios/listbarrios/bindings/listbarrios_binding.dart';
import '../modules/barrios/listbarrios/views/listbarrios_view.dart';
import '../modules/clientes/editclient/bindings/editclient_binding.dart';
import '../modules/clientes/editclient/views/editclient_view.dart';
import '../modules/clientes/listclient/bindings/listclient_binding.dart';
import '../modules/clientes/listclient/views/listclient_view.dart';
import '../modules/clientes/registrarcliente/bindings/registrarcliente_binding.dart';
import '../modules/clientes/registrarcliente/views/registrarcliente_view.dart';
import '../modules/cobradores/createcobradores/bindings/createcobradores_binding.dart';
import '../modules/cobradores/createcobradores/views/createcobradores_view.dart';
import '../modules/cobradores/detallesdepagorecaudos/bindings/detallesdepagorecaudos_binding.dart';
import '../modules/cobradores/detallesdepagorecaudos/views/detallesdepagorecaudos_view.dart';
import '../modules/cobradores/editcobradores/bindings/editcobradores_binding.dart';
import '../modules/cobradores/editcobradores/views/editcobradores_view.dart';
import '../modules/cobradores/listacobradores/bindings/listacobradores_binding.dart';
import '../modules/cobradores/listacobradores/views/listacobradores_view.dart';
import '../modules/cobradores/ventanarecaudosseguimiento/bindings/ventanarecaudosseguimiento_binding.dart';
import '../modules/cobradores/ventanarecaudosseguimiento/views/ventanarecaudosseguimiento_view.dart';
import '../modules/cobradores/ventanaseguimientocobradores/bindings/ventanaseguimientocobradores_binding.dart';
import '../modules/cobradores/ventanaseguimientocobradores/views/ventanaseguimientocobradores_view.dart';
import '../modules/conceptos/createconceptos/bindings/createconceptos_binding.dart';
import '../modules/conceptos/createconceptos/views/createconceptos_view.dart';
import '../modules/conceptos/editconceptos/bindings/editconceptos_binding.dart';
import '../modules/conceptos/editconceptos/views/editconceptos_view.dart';
import '../modules/conceptos/listaconceptos/bindings/listaconceptos_binding.dart';
import '../modules/conceptos/listaconceptos/views/listaconceptos_view.dart';
import '../modules/diasnocobro/creatediasnocobro/bindings/creatediasnocobro_binding.dart';
import '../modules/diasnocobro/creatediasnocobro/views/creatediasnocobro_view.dart';
import '../modules/diasnocobro/diasdenocobro/bindings/diasdenocobro_binding.dart';
import '../modules/diasnocobro/diasdenocobro/views/diasdenocobro_view.dart';
import '../modules/informes/informeprestamo/bindings/informeprestamo_binding.dart';
import '../modules/informes/informeprestamo/views/informeprestamo_view.dart';
import '../modules/informes/informerecaudo/bindings/informerecaudo_binding.dart';
import '../modules/informes/informerecaudo/views/informerecaudo_view.dart';
import '../modules/informes/informesession/bindings/informesession_binding.dart';
import '../modules/informes/informesession/views/informesession_view.dart';
import '../modules/informes/informetransacciones/bindings/informetransacciones_binding.dart';
import '../modules/informes/informetransacciones/views/informetransacciones_view.dart';
import '../modules/introduccion/landing/bindings/landing_binding.dart';
import '../modules/introduccion/landing/views/landing_view.dart';
import '../modules/introduccion/login/bindings/login_binding.dart';
import '../modules/introduccion/login/views/login_view.dart';
import '../modules/listanegra/listasnegra/bindings/listasnegra_binding.dart';
import '../modules/listanegra/listasnegra/views/listasnegra_view.dart';
import '../modules/prestamo/create_prestamo/bindings/create_prestamo_binding.dart';
import '../modules/prestamo/create_prestamo/views/create_prestamo_view.dart';
import '../modules/prestamo/detalleprestamo/bindings/detalleprestamo_binding.dart';
import '../modules/prestamo/detalleprestamo/views/detalleprestamo_view.dart';
import '../modules/prestamo/editprestamo/bindings/editprestamo_binding.dart';
import '../modules/prestamo/editprestamo/views/editprestamo_view.dart';
import '../modules/prestamo/list_prestamo/bindings/list_prestamo_binding.dart';
import '../modules/prestamo/list_prestamo/views/list_prestamo_view.dart';
import '../modules/prestamo/recaudarprestamo/bindings/recaudarprestamo_binding.dart';
import '../modules/prestamo/recaudarprestamo/views/recaudarprestamo_view.dart';
import '../modules/prestamo/refinanciacionprestamo/bindings/refinanciacionprestamo_binding.dart';
import '../modules/prestamo/refinanciacionprestamo/views/refinanciacionprestamo_view.dart';
import '../modules/prestamo/renovacionprestamo/bindings/renovacionprestamo_binding.dart';
import '../modules/prestamo/renovacionprestamo/views/renovacionprestamo_view.dart';
import '../modules/prestamo/seachcliente2/bindings/seachcliente2_binding.dart';
import '../modules/prestamo/seachcliente2/views/seachcliente2_view.dart';
import '../modules/prestamo/seachtipoprestamo/bindings/seachtipoprestamo_binding.dart';
import '../modules/prestamo/seachtipoprestamo/views/seachtipoprestamo_view.dart';
import '../modules/prestamo/ventanacuotaprestamo/bindings/ventanacuotaprestamo_binding.dart';
import '../modules/prestamo/ventanacuotaprestamo/views/ventanacuotaprestamo_view.dart';
import '../modules/prestamo/ventanarecaudosprestamo/bindings/ventanarecaudosprestamo_binding.dart';
import '../modules/prestamo/ventanarecaudosprestamo/views/ventanarecaudosprestamo_view.dart';
import '../modules/principal/ajustes/bindings/ajustes_binding.dart';
import '../modules/principal/ajustes/views/ajustes_view.dart';
import '../modules/principal/home/bindings/home_binding.dart';
import '../modules/principal/home/views/home_view.dart';
import '../modules/principal/paneladmin/bindings/paneladmin_binding.dart';
import '../modules/principal/paneladmin/views/paneladmin_view.dart';
import '../modules/principal/session/create_session/bindings/create_session_binding.dart';
import '../modules/principal/session/create_session/views/create_session_view.dart';
import '../modules/principal/session/detallesdetodassesiones/bindings/detallesdetodassesiones_binding.dart';
import '../modules/principal/session/detallesdetodassesiones/views/detallesdetodassesiones_view.dart';
import '../modules/principal/session/detallessession/bindings/detallessession_binding.dart';
import '../modules/principal/session/detallessession/views/detallessession_view.dart';
import '../modules/principal/session/listasesion/bindings/listasesion_binding.dart';
import '../modules/principal/session/listasesion/views/listasesion_view.dart';
import '../modules/principal/usuario/bindings/usuario_binding.dart';
import '../modules/principal/usuario/views/usuario_view.dart';
import '../modules/recaudos/create_recaudos/bindings/create_recaudos_binding.dart';
import '../modules/recaudos/create_recaudos/views/create_recaudos_view.dart';
import '../modules/recaudos/detallesrecaudos/bindings/detallesrecaudos_binding.dart';
import '../modules/recaudos/detallesrecaudos/views/detallesrecaudos_view.dart';
import '../modules/recaudos/edit_recaudos/bindings/edit_recaudos_binding.dart';
import '../modules/recaudos/edit_recaudos/views/edit_recaudos_view.dart';
import '../modules/recaudos/lineasrecaudos/bindings/lineasrecaudos_binding.dart';
import '../modules/recaudos/lineasrecaudos/views/lineasrecaudos_view.dart';
import '../modules/recaudos/panelrecaudos/bindings/panelrecaudos_binding.dart';
import '../modules/recaudos/panelrecaudos/views/panelrecaudos_view.dart';
import '../modules/recaudos/recaudar/bindings/recaudar_binding.dart';
import '../modules/recaudos/recaudar/views/recaudar_view.dart';
import '../modules/recaudos/seachprestamos/bindings/seachprestamos_binding.dart';
import '../modules/recaudos/seachprestamos/views/seachprestamos_view.dart';
import '../modules/recaudos/ventanarecaudotodo/bindings/ventanarecaudotodo_binding.dart';
import '../modules/recaudos/ventanarecaudotodo/views/ventanarecaudotodo_view.dart';
import '../modules/tipo_prestamos/editarprestamos/bindings/editarprestamos_binding.dart';
import '../modules/tipo_prestamos/editarprestamos/views/editarprestamos_view.dart';
import '../modules/tipo_prestamos/listadeprestamos/bindings/listadeprestamos_binding.dart';
import '../modules/tipo_prestamos/listadeprestamos/views/listadeprestamos_view.dart';
import '../modules/tipo_prestamos/registrarprestamos/bindings/registrarprestamos_binding.dart';
import '../modules/tipo_prestamos/registrarprestamos/views/registrarprestamos_view.dart';
import '../modules/transacciones/createtransacciones/bindings/createtransacciones_binding.dart';
import '../modules/transacciones/createtransacciones/views/createtransacciones_view.dart';
import '../modules/transacciones/edittransacciones/bindings/edittransacciones_binding.dart';
import '../modules/transacciones/edittransacciones/views/edittransacciones_view.dart';
import '../modules/transacciones/listatransacciones/bindings/listatransacciones_binding.dart';
import '../modules/transacciones/listatransacciones/views/listatransacciones_view.dart';
import '../modules/informes/ventanadeinformeprestamo/bindings/ventanadeinformeprestamo_binding.dart';
import '../modules/informes/ventanadeinformeprestamo/views/ventanadeinformeprestamo_view.dart';
import '../modules/informes/ventanadeinformesrecaudos/bindings/ventanadeinformesrecaudos_binding.dart';
import '../modules/informes/ventanadeinformesrecaudos/views/ventanadeinformesrecaudos_view.dart';
import '../modules/informes/ventanadeinformessession/bindings/ventanadeinformessession_binding.dart';
import '../modules/informes/ventanadeinformessession/views/ventanadeinformessession_view.dart';
import '../modules/informes/ventanadeinformestransacciones/bindings/ventanadeinformestransacciones_binding.dart';
import '../modules/informes/ventanadeinformestransacciones/views/ventanadeinformestransacciones_view.dart';
import '../modules/informes/ventanainforme/bindings/ventanainforme_binding.dart';
import '../modules/informes/ventanainforme/views/ventanainforme_view.dart';
import '../modules/zona/createzone/bindings/createzone_binding.dart';
import '../modules/zona/createzone/views/createzone_view.dart';
import '../modules/zona/detallezona/bindings/detallezona_binding.dart';
import '../modules/zona/detallezona/views/detallezona_view.dart';
import '../modules/zona/editzone/bindings/editzone_binding.dart';
import '../modules/zona/editzone/views/editzone_view.dart';
import '../modules/zona/listzonas/bindings/listzonas_binding.dart';
import '../modules/zona/listzonas/views/listzonas_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.AJUSTES,
      page: () => const AjustesView(),
      binding: AjustesBinding(),
    ),
    GetPage(
      name: _Paths.PANELADMIN,
      page: () => const PaneladminView(),
      binding: PaneladminBinding(),
    ),
    GetPage(
      name: _Paths.USUARIO,
      page: () => const UsuarioView(),
      binding: UsuarioBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PRESTAMO,
      page: () => const ListPrestamoView(),
      binding: ListPrestamoBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PRESTAMO,
      page: () => const CreatePrestamoView(),
      binding: CreatePrestamoBinding(),
    ),
    GetPage(
      name: _Paths.LISTATRANSACCIONES,
      page: () => const ListatransaccionesView(),
      binding: ListatransaccionesBinding(),
    ),
    GetPage(
      name: _Paths.CREATETRANSACCIONES,
      page: () => const CreatetransaccionesView(),
      binding: CreatetransaccionesBinding(),
    ),
    GetPage(
      name: _Paths.EDITTRANSACCIONES,
      page: () => const EdittransaccionesView(),
      binding: EdittransaccionesBinding(),
    ),
    GetPage(
      name: _Paths.PANELRECAUDOS,
      page: () => const PanelrecaudosView(),
      binding: PanelrecaudosBinding(),
    ),
    GetPage(
      name: _Paths.RECAUDAR,
      page: () => const RecaudarView(),
      binding: RecaudarBinding(),
    ),
    GetPage(
      name: _Paths.DETALLESSESSION,
      page: () => const DetallessessionView(),
      binding: DetallessessionBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_SESSION,
      page: () => const CreateSessionView(),
      binding: CreateSessionBinding(),
    ),
    GetPage(
      name: _Paths.DETALLESDETODASSESIONES,
      page: () => const DetallesdetodassesionesView(),
      binding: DetallesdetodassesionesBinding(),
    ),
    GetPage(
      name: _Paths.LISTASESION,
      page: () => const ListasesionView(),
      binding: ListasesionBinding(),
    ),
    GetPage(
      name: _Paths.LISTBARRIOS,
      page: () => const ListbarriosView(),
      binding: ListbarriosBinding(),
    ),
    GetPage(
      name: _Paths.EDITBARRIOS,
      page: () => const EditbarriosView(),
      binding: EditbarriosBinding(),
    ),
    GetPage(
      name: _Paths.CREATEBARRIOS,
      page: () => const CreatebarriosView(),
      binding: CreatebarriosBinding(),
    ),
    GetPage(
      name: _Paths.LISTCLIENT,
      page: () => const ListclientView(),
      binding: ListclientBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRARCLIENTE,
      page: () => const RegistrarclienteView(),
      binding: RegistrarclienteBinding(),
    ),
    GetPage(
      name: _Paths.EDITCLIENT,
      page: () => const EditclientView(),
      binding: EditclientBinding(),
    ),
    GetPage(
      name: _Paths.CREATECOBRADORES,
      page: () => const CreatecobradoresView(),
      binding: CreatecobradoresBinding(),
    ),
    GetPage(
      name: _Paths.DETALLESDEPAGORECAUDOS,
      page: () => const DetallesdepagorecaudosView(),
      binding: DetallesdepagorecaudosBinding(),
    ),
    GetPage(
      name: _Paths.EDITCOBRADORES,
      page: () => const EditcobradoresView(),
      binding: EditcobradoresBinding(),
    ),
    GetPage(
      name: _Paths.LISTACOBRADORES,
      page: () => const ListacobradoresView(),
      binding: ListacobradoresBinding(),
    ),
    GetPage(
      name: _Paths.VENTANARECAUDOSSEGUIMIENTO,
      page: () => const VentanarecaudosseguimientoView(),
      binding: VentanarecaudosseguimientoBinding(),
    ),
    GetPage(
      name: _Paths.VENTANASEGUIMIENTOCOBRADORES,
      page: () => const VentanaseguimientocobradoresView(),
      binding: VentanaseguimientocobradoresBinding(),
    ),
    GetPage(
      name: _Paths.CREATECONCEPTOS,
      page: () => const CreateconceptosView(),
      binding: CreateconceptosBinding(),
    ),
    GetPage(
      name: _Paths.EDITCONCEPTOS,
      page: () => const EditconceptosView(),
      binding: EditconceptosBinding(),
    ),
    GetPage(
      name: _Paths.LISTACONCEPTOS,
      page: () => const ListaconceptosView(),
      binding: ListaconceptosBinding(),
    ),
    GetPage(
      name: _Paths.DIASDENOCOBRO,
      page: () => const DiasdenocobroView(),
      binding: DiasdenocobroBinding(),
    ),
    GetPage(
      name: _Paths.CREATEDIASNOCOBRO,
      page: () => const CreatediasnocobroView(),
      binding: CreatediasnocobroBinding(),
    ),
    GetPage(
      name: _Paths.LISTASNEGRA,
      page: () => const ListasnegraView(),
      binding: ListasnegraBinding(),
    ),
    GetPage(
      name: _Paths.DETALLEPRESTAMO,
      page: () => const DetalleprestamoView(),
      binding: DetalleprestamoBinding(),
    ),
    GetPage(
      name: _Paths.EDITPRESTAMO,
      page: () => const EditprestamoView(),
      binding: EditprestamoBinding(),
    ),
    GetPage(
      name: _Paths.RECAUDARPRESTAMO,
      page: () => const RecaudarprestamoView(),
      binding: RecaudarprestamoBinding(),
    ),
    GetPage(
      name: _Paths.REFINANCIACIONPRESTAMO,
      page: () => const RefinanciacionprestamoView(),
      binding: RefinanciacionprestamoBinding(),
    ),
    GetPage(
      name: _Paths.RENOVACIONPRESTAMO,
      page: () => const RenovacionprestamoView(),
      binding: RenovacionprestamoBinding(),
    ),
    GetPage(
      name: _Paths.SEACHCLIENTE2,
      page: () => const Seachcliente2View(),
      binding: Seachcliente2Binding(),
    ),
    GetPage(
      name: _Paths.SEACHTIPOPRESTAMO,
      page: () => const SeachtipoprestamoView(),
      binding: SeachtipoprestamoBinding(),
    ),
    GetPage(
      name: _Paths.VENTANACUOTAPRESTAMO,
      page: () => const VentanacuotaprestamoView(),
      binding: VentanacuotaprestamoBinding(),
    ),
    GetPage(
      name: _Paths.VENTANARECAUDOSPRESTAMO,
      page: () => const VentanarecaudosprestamoView(),
      binding: VentanarecaudosprestamoBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_RECAUDOS,
      page: () => const CreateRecaudosView(),
      binding: CreateRecaudosBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_RECAUDOS,
      page: () => const EditRecaudosView(),
      binding: EditRecaudosBinding(),
    ),
    GetPage(
      name: _Paths.DETALLESRECAUDOS,
      page: () => const DetallesrecaudosView(),
      binding: DetallesrecaudosBinding(),
    ),
    GetPage(
      name: _Paths.SEACHPRESTAMOS,
      page: () => const SeachprestamosView(),
      binding: SeachprestamosBinding(),
    ),
    GetPage(
      name: _Paths.VENTANARECAUDOTODO,
      page: () => const VentanarecaudotodoView(),
      binding: VentanarecaudotodoBinding(),
    ),
    GetPage(
      name: _Paths.LINEASRECAUDOS,
      page: () => const LineasrecaudosView(),
      binding: LineasrecaudosBinding(),
    ),
    GetPage(
      name: _Paths.EDITARPRESTAMOS,
      page: () => const EditarprestamosView(),
      binding: EditarprestamosBinding(),
    ),
    GetPage(
      name: _Paths.LISTADEPRESTAMOS,
      page: () => const ListadeprestamosView(),
      binding: ListadeprestamosBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRARPRESTAMOS,
      page: () => const RegistrarprestamosView(),
      binding: RegistrarprestamosBinding(),
    ),
    GetPage(
      name: _Paths.CREATEZONE,
      page: () => const CreatezoneView(),
      binding: CreatezoneBinding(),
    ),
    GetPage(
      name: _Paths.DETALLEZONA,
      page: () => const DetallezonaView(),
      binding: DetallezonaBinding(),
    ),
    GetPage(
      name: _Paths.EDITZONE,
      page: () => const EditzoneView(),
      binding: EditzoneBinding(),
    ),
    GetPage(
      name: _Paths.LISTZONAS,
      page: () => const ListzonasView(),
      binding: ListzonasBinding(),
    ),
    GetPage(
      name: _Paths.INFORMEPRESTAMO,
      page: () => const InformeprestamoView(),
      binding: InformeprestamoBinding(),
    ),
    GetPage(
      name: _Paths.INFORMERECAUDO,
      page: () => const InformerecaudoView(),
      binding: InformerecaudoBinding(),
    ),
    GetPage(
      name: _Paths.INFORMESESSION,
      page: () => const InformesessionView(),
      binding: InformesessionBinding(),
    ),
    GetPage(
      name: _Paths.INFORMETRANSACCIONES,
      page: () => const InformetransaccionesView(),
      binding: InformetransaccionesBinding(),
    ),
    GetPage(
      name: _Paths.VENTANADEINFORMEPRESTAMO,
      page: () => const VentanadeinformeprestamoView(),
      binding: VentanadeinformeprestamoBinding(),
    ),
    GetPage(
      name: _Paths.VENTANADEINFORMESRECAUDOS,
      page: () => const VentanadeinformesrecaudosView(),
      binding: VentanadeinformesrecaudosBinding(),
    ),
    GetPage(
      name: _Paths.VENTANADEINFORMESSESSION,
      page: () => const VentanadeinformessessionView(),
      binding: VentanadeinformessessionBinding(),
    ),
    GetPage(
      name: _Paths.VENTANADEINFORMESTRANSACCIONES,
      page: () => const VentanadeinformestransaccionesView(),
      binding: VentanadeinformestransaccionesBinding(),
    ),
    GetPage(
      name: _Paths.VENTANAINFORME,
      page: () => const VentanainformeView(),
      binding: VentanainformeBinding(),
    ),
  ];
}
