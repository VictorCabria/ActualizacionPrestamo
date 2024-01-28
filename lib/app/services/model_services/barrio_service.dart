import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/models/barrio_modal.dart';
import 'package:prestamo_mc/app/utils/references.dart';

import '../firebase_services/database_service.dart';

class BarrioService {
  static String barriosReference = firebaseReferences.barrios;
  static final BarrioService _instance = BarrioService._internal();

  factory BarrioService() {
    return _instance;
  }
  BarrioService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  Future<bool> savebarrio({Barrio? barrio}) async {
    try {
      await database.save(
        barrio!.toJson(),
        barriosReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  FirebaseFirestore getlistbarrios = FirebaseFirestore.instance;
  CollectionReference obtenerlistbarrios() {
    return FirebaseFirestore.instance.collection(firebaseReferences.barrios);
  }

  /* Future<bool> deletebarrio(Barrio? barrio) async {
    try {
      await database.deleteDocument(barrio?.id, barriosReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */
  CollectionReference barriodelete =
      FirebaseFirestore.instance.collection(barriosReference);
  Future<void> deletebarrio(id) {
    return barriodelete.doc(id).delete();
  }

  Future<bool> updatebarrio(Barrio barrio) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: barriosReference, documentId: barrio.id!);
      await docRef.update(barrio.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<Barrio?> selectBarrio(String id) async {
    try {
      var querySnapshot =
          await database.getCollection(barriosReference, 'id', id);
      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return Barrio.fromDinamic(querySnapshot.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}

BarrioService barrioService = BarrioService();
