//contantes de la app

class AppConstants {
  int localVersion = 1; //version del codigo
  String labelVersion = "0.0.1"; //version de la app
  late String termsUrl; // Link términos y condiciones
  late String policiesUrl; // Link políticas y tratamiento de datos

}

enum Role { admin, adminCobrador, cobrador, visor }

enum TipoPrestamo { diario, semanal, quincenal, mensual }

enum StatusPrestamo {
  nuevo,
  aldia,
  atrasado,
  pagado,
  refinanciado,
  vencido,
  renovado,
  listanegra
}

enum Statuscuota { nopagado, pagado, incompleto }

enum StatusSession { open, progress, closed }

enum StatusRecaudo { open, passed, closed, nopassed }

enum TipoOperacion { ingreso, costo, gasto }

AppConstants constants = AppConstants();
