import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/type_prestamo_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_services.dart';


class TypePrestamoService {
  static String prestamoReference = firebaseReferences.tipodeprestamo;
  static String prestamoguardadosReference =
      firebaseReferences.prestamosregistrados;
  static final TypePrestamoService _instance = TypePrestamoService._internal();

  factory TypePrestamoService() {
    return _instance;
  }
  TypePrestamoService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttipoprestamo = FirebaseFirestore.instance;
  CollectionReference obtenerlistprestamo() {
    return FirebaseFirestore.instance.collection(prestamoReference);
  }

  FirebaseFirestore getlisttipoprestamo2 = FirebaseFirestore.instance;
  CollectionReference obtenerlistprestamo2() {
    return FirebaseFirestore.instance.collection(prestamoguardadosReference);
  }

  Future<bool> saveprestamo({TypePrestamo? typeprestamo}) async {
    try {
      await database.save(
        typeprestamo!.toJson(),
        prestamoguardadosReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> updateprestamo(TypePrestamo typeprestamo) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: prestamoguardadosReference, documentId: typeprestamo.id!);
      await docRef.update(typeprestamo.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

/*   Future<bool> deleteprestamo(TypePrestamo? typeprestamo) async {
    try {
      await database.deleteDocument(
          typeprestamo?.id, prestamoguardadosReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */
  CollectionReference deleteprestamo =
      FirebaseFirestore.instance.collection(prestamoguardadosReference);
  Future<void> deleteprestamos(id) {
    return deleteprestamo.doc(id).delete();
  }

  Future<List<TypePrestamo>> getTypes() async {
    try {
      List<TypePrestamo> types = [];
      var querySnapshot = await database.getData(prestamoguardadosReference);
      types.addAll(
          querySnapshot.docs.map((e) => TypePrestamo.fromJson(e)).toList());

      return types;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

 
  Future<TypePrestamo?> selecttypeprestamoid(String id) async {
    QuerySnapshot<Object?> querySnapshot = await database.getCollection(
        prestamoguardadosReference, 'id', id);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      TypePrestamo tipoprestamo = TypePrestamo.fromJson((element));
      return tipoprestamo;
    }
    return null;
  }

  Future<List<TypePrestamo>> getprestamoById(String id) async {
    try {
      List<TypePrestamo> tipoprestamo = [];
      var querySnapshot =
          await database.getDataById(id, prestamoguardadosReference);
      tipoprestamo.addAll(
          querySnapshot.docs.map((e) => TypePrestamo.fromJson(e)).toList());

      return tipoprestamo;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

TypePrestamoService typePrestamoService = TypePrestamoService();
