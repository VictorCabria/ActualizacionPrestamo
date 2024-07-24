import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/diasnocobro_modal.dart';
import '../../utils/references.dart';
import '../firebase_services/database_services.dart';

class DiasnocobroService {
  static String diasnocobroReference = firebaseReferences.diasnocobro;
  static final DiasnocobroService _instance = DiasnocobroService._internal();

  factory DiasnocobroService() {
    return _instance;
  }
  DiasnocobroService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttipoprestamo = FirebaseFirestore.instance;
  CollectionReference obtenerlistcobrorefernce() {
    return FirebaseFirestore.instance.collection(diasnocobroReference);
  }

  Future<bool> savediasnocobro({Diasnocobro? diasnocobro}) async {
    try {
      await database.save(
        diasnocobro!.toJson(),
        diasnocobroReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deletediasnocobro(Diasnocobro? diasnocobro) async {
    try {
      await database.deleteDocument(diasnocobro?.id, diasnocobroReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}

DiasnocobroService diasnocobroServiceService = DiasnocobroService();
