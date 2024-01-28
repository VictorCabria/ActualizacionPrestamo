import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/utils/references.dart';

import '../../models/concepto_model.dart';
import '../firebase_services/database_service.dart';

class ConceptoService {
  static String conceptoReference = firebaseReferences.concepto;
  static String tipoconceptoReference = firebaseReferences.tipoconcepto;
  static String naturalezaReference = firebaseReferences.naturaleza;
  static final ConceptoService _instance = ConceptoService._internal();

  factory ConceptoService() {
    return _instance;
  }
  ConceptoService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttipoconceptos = FirebaseFirestore.instance;
  CollectionReference obtenerlisttipoconcepto() {
    return FirebaseFirestore.instance.collection(tipoconceptoReference);
  }

  FirebaseFirestore getlistnaturaleza = FirebaseFirestore.instance;
  CollectionReference obtenerlistnaturaleza() {
    return FirebaseFirestore.instance.collection(naturalezaReference);
  }

  FirebaseFirestore getlistconcepto = FirebaseFirestore.instance;
  CollectionReference obtenerlistconceptos() {
    return FirebaseFirestore.instance.collection(firebaseReferences.concepto);
  }

  Future<bool> saveconcepto({Concepto? concepto}) async {
    try {
      await database.save(
        concepto!.toJson(),
        conceptoReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> updateconcepto(Concepto concepto) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: conceptoReference, documentId: concepto.id!);
      await docRef.update(concepto.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  CollectionReference conceptodelete =
      FirebaseFirestore.instance.collection(conceptoReference);
  Future<void> deleteconcepto(id) {
    return conceptodelete.doc(id).delete();
  }

  Future<List<Concepto>> getconceptoById(String id) async {
    try {
      List<Concepto> concepto = [];
      var querySnapshot = await database.getDataById(id, conceptoReference);
      concepto
          .addAll(querySnapshot.docs.map((e) => Concepto.fromJson(e)).toList());

      return concepto;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

/* 
  Future<bool> deleteconcepto(Concepto? concepto) async {
    try {
      await database.deleteDocument(concepto?.id, conceptoReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */
}

ConceptoService conceptoService = ConceptoService();
