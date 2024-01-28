import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/cuotas_modal.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class CuotaService {
  static String cuotaReference = firebaseReferences.cuota;

  static final CuotaService _instance = CuotaService._internal();

  factory CuotaService() {
    return _instance;
  }

  CuotaService._internal();
  var firestore = FirebaseFirestore.instance;

  Future<List<Cuotas>> getlistacuotasub({
    required String documentId,
  }) async {
    List<Cuotas> list = [];
    try {
      var subcollection = await database.getSubcollectionFromDocumentordenby(
          documentId, firebaseReferences.prestamos, firebaseReferences.cuota);

      for (var cuotadoc in subcollection.docs) {
        var cuotas = Cuotas.fromJson(cuotadoc.data());
        cuotas.id = cuotadoc.id;
        list.add(cuotas);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }

  Future<List<Cuotas>> getlistacuotasubdesencente({
    required String documentId,
  }) async {
    List<Cuotas> list = [];
    try {
      var subcollection =
          await database.getSubcollectionFromDocumentordenbydesencente(
              documentId,
              firebaseReferences.prestamos,
              firebaseReferences.cuota);

      for (var cuotadoc in subcollection.docs) {
        var cuotas = Cuotas.fromJson(cuotadoc.data());
        cuotas.id = cuotadoc.id;
        list.add(cuotas);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }

  Future<String> savecuota({required List<Cuotas> cuota}) async {
    try {
      for (var cuotas in cuota) {
        var resp = await database.save(
          cuotas.toJson(),
          cuotaReference,
        );
        return resp;
      }
      return "";
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "error $e";
    }
  }

  Future<String> updatecuota({
    required String documentId,
    required Cuotas cuota,
  }) async {
    try {
      DocumentReference docRef = database.getDocumentReferenceupdate(
          collection: firebaseReferences.prestamos,
          documentId: documentId,
          subcollection: cuotaReference,
          subdocumentid: cuota.id!);
      await docRef.update(cuota.toJson());
      return "";
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return "error $e";
    }
  }

  Future<String> savesubcoleccioncuota({
    required String documentId,
    required List<Cuotas> cuotas,
  }) async {
    try {
      for (var cuota in cuotas) {
        await database.saveDocumentInSubcollection(
          collection: firebaseReferences.prestamos,
          subcollection: cuotaReference,
          documentId: documentId,
          subcollectionData: cuota.toJson(),
        );
      }
      return "";
    } on Exception catch (e) {
      print(e);
      return "error $e";
    }
  }

  Future<List<Cuotas>> getcuotaById(String id) async {
    try {
      print("id $id");
      List<Cuotas> cuotas = [];
      var querySnapshot = await database.getDataById(id, cuotaReference);
      print("query snapshot ${querySnapshot.docs.length}");
      cuotas.addAll(querySnapshot.docs.map((e) => Cuotas.fromJson(e)).toList());

      return cuotas;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

CuotaService cuotaService = CuotaService();
