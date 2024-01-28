import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/cobradores_modal.dart';
import '../../models/session_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class CobradoresService {
  static String cobradoresReference = firebaseReferences.cobradores;
  static String cedulasReference = firebaseReferences.tipodecedula;
  static String sesionreference = firebaseReferences.sessions;

  static final CobradoresService _instance = CobradoresService._internal();

  factory CobradoresService() {
    return _instance;
  }
  CobradoresService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttipoconceptos = FirebaseFirestore.instance;
  CollectionReference obtenerlistcobradores() {
    return FirebaseFirestore.instance.collection(cobradoresReference);
  }

  FirebaseFirestore getlistcedula = FirebaseFirestore.instance;
  CollectionReference obtenerlisttipocedula() {
    return FirebaseFirestore.instance.collection(cedulasReference);
  }

  Future<String> savecobradores({Cobradores? cobradores}) async {
    try {
      var resp = await database.save(
        cobradores!.toJson(),
        cobradoresReference,
      );
      return resp;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "error $e";
    }
  }

  Future<bool> updatecobrador(Cobradores cobradores) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: cobradoresReference, documentId: cobradores.id!);
      await docRef.update(cobradores.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<Cobradores?> loginCobradores(String pin) async {
    try {
      List<Cobradores> cobradores = [];
      var querySnapshot =
          await database.getCollection(cobradoresReference, 'pin', pin);
      cobradores.addAll(
          querySnapshot.docs.map((e) => Cobradores.fromJson(e)).toList());

      return cobradores.first;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }



  Future<Cobradores?> loginCobradorAdmin(String id) async {
    // try {
    print("id: $id");
    List<Cobradores> cobradores = [];
    var querySnapshot =
        await database.getCollection(cobradoresReference, 'id', id);
    print("querySnapshot ${querySnapshot.docs.length}");
    cobradores
        .addAll(querySnapshot.docs.map((e) => Cobradores.fromJson(e)).toList());

    return cobradores.first;
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("error ${e.toString()}");
    //   }
    //   return null;
    // }
  }

  Future<List<Cobradores>> getCobradores() async {
    try {
      List<Cobradores> cobradores = [];
      var querySnapshot = await database.getData(cobradoresReference);
      cobradores.addAll(
          querySnapshot.docs.map((e) => Cobradores.fromJson(e)).toList());

      return cobradores;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<Cobradores?> getcobradores() async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollection(cobradoresReference, null, null);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Cobradores cobradores = Cobradores.fromJson((element));
      return cobradores;
    }
    return null;
  }

  Future<List<Cobradores>> getcobradoresById(String id) async {
    try {
      print("id $id");
      List<Cobradores> cobradores = [];
      var querySnapshot = await database.getDataById(id, cobradoresReference);
      print("query snapshot ${querySnapshot.docs.length}");
      cobradores.addAll(
          querySnapshot.docs.map((e) => Cobradores.fromJson(e)).toList());

      return cobradores;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  /* Future<bool> deletecobrador(Cobradores? cobradores) async {
    try {
      await database.deleteDocument(cobradores?.id, cobradoresReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */

  CollectionReference cobradordelete =
      FirebaseFirestore.instance.collection(cobradoresReference);
  Future<void> deletecobradores(id) {
    return cobradordelete.doc(id).delete();
  }
}

CobradoresService cobradoresService = CobradoresService();
