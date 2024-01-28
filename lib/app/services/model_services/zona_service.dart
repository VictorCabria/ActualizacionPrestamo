import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/models/zone_model.dart';

import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class ZonaService {
  static String zonaReference = firebaseReferences.zona;
  static final ZonaService _instance = ZonaService._internal();

  factory ZonaService() {
    return _instance;
  }
  ZonaService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  Future<bool> savezona({Zone? zona}) async {
    try {
      await database.save(
        zona!.toJson(),
        zonaReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  FirebaseFirestore getlistzona = FirebaseFirestore.instance;
  CollectionReference obtenerlistzonas() {
    return FirebaseFirestore.instance.collection(firebaseReferences.zona);
  }

/*   Future<bool> deletezona(Zone? zona) async {
    try {
      await database.deleteDocument(zona?.id, zonaReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */
  CollectionReference zonadelete =
      FirebaseFirestore.instance.collection(zonaReference);
  Future<void> deletezona(id) {
    return zonadelete.doc(id).delete();
  }

  Future<bool> updatezona(Zone zona) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: zonaReference, documentId: zona.id!);
      await docRef.update(zona.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<List<Zone>> getzones() async {
    try {
      List<Zone> zones = [];
      var querySnapshot = await database.getData(zonaReference);
      zones.addAll(querySnapshot.docs.map((e) => Zone.fromJson(e)).toList());

      return zones;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<List<Zone>> getzonaById(String id) async {
    try {
      print("id $id");
      List<Zone> cobradores = [];
      var querySnapshot = await database.getDataById(id, zonaReference);
      print("query snapshot ${querySnapshot.docs.length}");
      cobradores
          .addAll(querySnapshot.docs.map((e) => Zone.fromJson(e)).toList());

      return cobradores;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

ZonaService zonaService = ZonaService();
