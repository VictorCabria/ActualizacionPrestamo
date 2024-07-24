import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ajustes_modal.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class AjustesService {
  static String ajustesReferencia = firebaseReferences.ajustes;

  static final AjustesService _instance = AjustesService._internal();

  factory AjustesService() {
    return _instance;
  }
  AjustesService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  Future<bool> saveajustes({Ajustes? ajustes}) async {
    try {
      await database.save(
        ajustes!.toJson(),
        ajustesReferencia,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<Ajustes?> getajustes() async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollection(ajustesReferencia, null, null);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Ajustes ajustes = Ajustes.fromJson((element));
      return ajustes;
    }
    return null;
  }

  Future<bool> updateajustes(Ajustes ajustes) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: ajustesReferencia, documentId: ajustes.id!);
      await docRef.update(ajustes.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}

AjustesService ajustesservice = AjustesService();
