import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc/app/models/recaudo_line_modal.dart';
import 'package:prestamo_mc/app/models/recaudo_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_service.dart';

class RecaudosService {
  static String recaudosReference = firebaseReferences.recaudos;
  static String recaudarreference = firebaseReferences.recaudo_lines;

  static final RecaudosService _instance = RecaudosService._internal();

  factory RecaudosService() {
    return _instance;
  }
  RecaudosService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  FirebaseFirestore getlistrecaudos = FirebaseFirestore.instance;
  CollectionReference obtenerlistrecaudos() {
    return FirebaseFirestore.instance.collection(recaudosReference);
  }

  Future<Recaudo?> createrecaudo({
    required Map<String, dynamic> object,
  }) async {
    try {
      print(object['id_cobrador']);

      var isOpen = await verificarrecaudo(object['id_cobrador']);
      if (isOpen != null) return null;
      var firestore = FirebaseFirestore.instance;

      // CollectionReference collRef = firestore.collection(sessionReference);

      final result = await firestore.collection(recaudosReference).add(object);

      // DocumentReference docReferance = collRef.doc(result.id);

      Recaudo aux = Recaudo.fromJson(object);
      aux.id = result.id;

      await firestore
          .collection(recaudosReference)
          .doc(aux.id)
          .set({...aux.toJson()});

      return aux;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<bool> updaterecaudo(Recaudo recaudo) async {
    try {
      var response = database.updateDocument(
          recaudo.id, recaudo.toJson(), recaudosReference);
      if (kDebugMode) {
        print(response);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<Recaudo?> getLast(String cobradorId) async {
    QuerySnapshot<Object?> querySnapshot = await database.getCollectionOrderBy(
        recaudosReference, 'id_cobrador', cobradorId);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Recaudo session = Recaudo.fromJson((element));
      return session;
    }
    return null;
  }

  Future<List<Recaudo>> getSessions(String cobradorId) async {
    List<Recaudo> sessions = [];
    QuerySnapshot<Object?> querySnapshot = await database.getCollection(
        recaudosReference, 'cobradorId', cobradorId);

    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      sessions.add(Recaudo.fromJson((element)));
      return sessions;
    }
    return [];
  }

  Future<Recaudo?> verificarrecaudo(String cobradorId) async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollectionMoreFilter(
            recaudosReference, 'cobradorId', cobradorId, 'estado', 'Abierta');

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Recaudo session = Recaudo.fromJson((element));
      return session;
    }
    return null;
  }

  Future<bool> deleterecaudos(Recaudo? recaudo) async {
    try {
      await database.deleteDocument(recaudo?.id, recaudosReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<String?> saveRecaudoLine(RecaudoLine line) async {
    try {
      var resp = await database.save(
        line.toJson(),
        recaudarreference,
      );
      return resp;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<RecaudoLine>> getLineaRecaudado(String id) async {
    try {
      print("id session $id");
      List<RecaudoLine> recaudoline = [];
      var querySnapshot = await database.getCollection(
        recaudarreference,
        'id_recaudo',
        id,
      );

      print("query ${querySnapshot.docs}");
      recaudoline.addAll(
          querySnapshot.docs.map((e) => RecaudoLine.fromJson(e)).toList());

      return recaudoline;
    } catch (e) {
      if (kDebugMode) {
        print("error en getLinearecaudado ${e.toString()}");
      }
      return [];
    }
  }

  Future<bool> deleterecaudados(RecaudoLine? recaudados) async {
    try {
      await database.deleteDocument(recaudados?.id, recaudarreference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> updaterecaudados(RecaudoLine recaudados) async {
    try {
      var response = database.updateDocument(
          recaudados.id, recaudados.toJson(), recaudarreference);
      if (kDebugMode) {
        print(response);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<RecaudoLine?> selectrecaudo(String id) async {
    try {
      var querySnapshot =
          await database.getCollection(recaudarreference, 'id', id);
      if (querySnapshot.docs.isNotEmpty) {
        print(querySnapshot.docs.first.data());
        return RecaudoLine.fromJson(querySnapshot.docs.first.data());
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

  Future<List<RecaudoLine>> getrecaudolineById(String id) async {
    try {
      print("id $id");
      List<RecaudoLine> recaudoline = [];
      var querySnapshot =
          await database.getCollection(recaudarreference, "id_recaudo", id);

      recaudoline.addAll(
          querySnapshot.docs.map((e) => RecaudoLine.fromJson(e)).toList());

      return recaudoline;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<List<RecaudoLine>> getLineaRecaudadoprestamos(String id) async {
    try {
      print("id session $id");
      List<RecaudoLine> recaudoline = [];
      var querySnapshot = await database.getCollection(
        recaudarreference,
        'prestamo',
        id,
      );

      print("query ${querySnapshot.docs}");
      recaudoline.addAll(
          querySnapshot.docs.map((e) => RecaudoLine.fromJson(e)).toList());

      return recaudoline;
    } catch (e) {
      if (kDebugMode) {
        print("error en getLinearecaudado ${e.toString()}");
      }
      return [];
    }
  }

  FirebaseFirestore getlistrecaudar = FirebaseFirestore.instance;
  CollectionReference obtenerlistrecaudo() {
    return FirebaseFirestore.instance
        .collection(firebaseReferences.recaudo_lines);
  }
}

RecaudosService recaudoService = RecaudosService();
