import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/session_model.dart';
import '../../utils/references.dart';
import '../firebase_services/database_services.dart';

class SessionService {
  static String sessionReference = firebaseReferences.sessions;

  Future<Session?> createSession({
    required Map<String, dynamic> object,
  }) async {
    try {
      print(object['cobradorId']);

      var isOpen = await verificarSession(object['cobradorId']);
      if (isOpen != null) return null;
      var firestore = FirebaseFirestore.instance;

      final result = await firestore.collection(sessionReference).add(object);

      Session aux = Session.fromJson(object);
      aux.id = result.id;

      await firestore
          .collection(sessionReference)
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

  Future<bool> updateSession(Session session) async {
    try {
      var response = database.updateDocument(
          session.id, session.toJson(), sessionReference);
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

  Future<Session?> getLastSession(String cobradorId) async {
    QuerySnapshot<Object?> querySnapshot = await database.getCollectionOrderBy(
        sessionReference, 'cobradorId', cobradorId);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Session session = Session.fromJson((element));
      return session;
    }
    return null;
  }

  Future<Session?> getLastSessiontodos() async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollectionOrderBy(sessionReference, '', null);

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Session session = Session.fromJson((element));
      return session;
    }
    return null;
  }

  Future<Session?> verificarSession(String cobradorId) async {
    QuerySnapshot<Object?> querySnapshot =
        await database.getCollectionMoreFilter(
            sessionReference, 'cobradorId', cobradorId, 'estado', 'Abierta');

    if (querySnapshot.docs.isEmpty) return null;
    for (var element in querySnapshot.docs) {
      Session session = Session.fromJson((element));
      return session;
    }
    return null;
  }

  Future<bool> deletesession(Session? session) async {
    try {
      await database.deleteDocument(session?.id, sessionReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<List<Session>> getSessions(String cobradorId) async {
    List<Session> sessions = [];
    QuerySnapshot<Object?> querySnapshot = await database.getCollection(
        sessionReference, 'cobradorId', cobradorId);

    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      sessions.add(Session.fromJson((element)));
      return sessions;
    }
    return [];
  }

  FirebaseFirestore getlistsesion = FirebaseFirestore.instance;
  CollectionReference obtenerlistsesion() {
    return FirebaseFirestore.instance.collection(sessionReference);
  }
}

SessionService sessionService = SessionService();
