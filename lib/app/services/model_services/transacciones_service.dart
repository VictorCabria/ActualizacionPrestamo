import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/models/concepto_model.dart';

import '../../models/transaction_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class TransactionService {
  static String transaccionesReference = firebaseReferences.transacciones;

  static final TransactionService _instance = TransactionService._internal();

  factory TransactionService() {
    return _instance;
  }
  TransactionService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlisttransacciones = FirebaseFirestore.instance;
  CollectionReference obtenerlisttransacciones() {
    return FirebaseFirestore.instance.collection(transaccionesReference);
  }

  Future<String> savetransacciones(Transacciones transacciones) async {
    try {
      var resp = await database.save(
        transacciones.toJson(),
        transaccionesReference,
      );
      return resp;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "error $e";
    }
  }

  Future<bool> updatetransacciones(Transacciones transacciones) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: transaccionesReference, documentId: transacciones.id!);
      await docRef.update(transacciones.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<bool> deletetransacciones(Transacciones? transacciones) async {
    try {
      await database.deleteDocument(transacciones?.id, transaccionesReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
   Future<Transacciones?> gettransacciones() async {
    QuerySnapshot<Object?> querySnapshot = await database.getCollection(
        transaccionesReference, null, null);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Transacciones prestamo = Transacciones.fromJson((element));
      return prestamo;
    }
    return null;
  }

  
}

TransactionService transaccionesService = TransactionService();
