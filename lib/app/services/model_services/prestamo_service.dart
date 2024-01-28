import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/models/prestamo_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class PrestamoService {
  static String prestamoReference = firebaseReferences.prestamos;
  static String recaudadolineal = firebaseReferences.recaudo_lines;

  static final PrestamoService _instance = PrestamoService._internal();

  factory PrestamoService() {
    return _instance;
  }
  PrestamoService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttipoprestamo = FirebaseFirestore.instance;
  CollectionReference obtenerlistprestamo() {
    return FirebaseFirestore.instance.collection(prestamoReference);
  }

  Future<String> saveprestamo(Prestamo prestamo) async {
    try {
      var resp = await database.save(
        prestamo.toJson(),
        prestamoReference,
      );
      return resp;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "error $e";
    }
  }

  Future<List<Prestamo>> getprestamosById(String id) async {
    try {
      print("id $id");
      List<Prestamo> prestamos = [];
      var querySnapshot = await database.getDataById(id, prestamoReference);
      print("query snapshot ${querySnapshot.docs.length}");
      prestamos
          .addAll(querySnapshot.docs.map((e) => Prestamo.fromJson(e)).toList());

      return prestamos;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<String?> updateprestamo(Prestamo prestamo) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: prestamoReference, documentId: prestamo.id!);
      await docRef.update(prestamo.toJson());
      return "";
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return "";
    }
  }

  Future<bool> deleteprestamo(Prestamo? prestamo) async {
    try {
      await database.deleteDocument(prestamo?.id, prestamoReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  CollectionReference prestamodelete =
      FirebaseFirestore.instance.collection(prestamoReference);
  Future<void> deleteprestamoid(id) {
    return prestamodelete.doc(id).delete();
  }

  Future<bool> deleteprestamosubcoleccion({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
  }) async {
    try {
      await database.deleteDocumentFromSubcollection(
        collectionDocumentId,
        prestamoReference,
        subcollectionDocumentId,
        firebaseReferences.cuota,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

/*   Future<List<Prestamo>> getPrestamos() async {
    try {
      List<Prestamo> prestamos = [];
      var querySnapshot = await database.getCollectionMoreFilterMayor(
          prestamoReference, 'saldo_prestamo', 0);
      prestamos
          .addAll(querySnapshot.docs.map((e) => Prestamo.fromJson(e)).toList());

      return prestamos;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
 */
  Future<List<Prestamo>> getPrestamos() async {
    try {
      List<Prestamo> prestamos = [];
      var querySnapshot = await database.getCollectionMoreFilterMayor(
          prestamoReference, 'saldo_prestamo', 0);
      prestamos
          .addAll(querySnapshot.docs.map((e) => Prestamo.fromJson(e)).toList());

      return prestamos;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<Prestamo?> getprestamo() async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollection(prestamoReference, null, null);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Prestamo prestamo = Prestamo.fromJson((element));
      return prestamo;
    }
    return null;
  }

  Future<List<Prestamo>> getLineaprestamo(String id) async {
    try {
      List<Prestamo> prestamos = [];
      var querySnapshot = await database.getCollectionMoreFilterMayor(
          prestamoReference, 'saldo_prestamo', 0, 'zonaId', id);
      prestamos
          .addAll(querySnapshot.docs.map((e) => Prestamo.fromJson(e)).toList());

      return prestamos;
    } catch (e) {
      if (kDebugMode) {
        print("error en getLineaRecaudo $e}");
      }
      return [];
    }
  }

  Future<List<Prestamo>> getprestamoconsulta() async {
    try {
      List<Prestamo> types = [];
      var querySnapshot = await database.getData(prestamoReference);
      types
          .addAll(querySnapshot.docs.map((e) => Prestamo.fromJson(e)).toList());

      return types;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

PrestamoService prestamoService = PrestamoService();
