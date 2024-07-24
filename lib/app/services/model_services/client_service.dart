import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prestamo_mc_2_0/app/services/firebase_services/database_services.dart';


import '../../models/client_model.dart';
import '../../utils/references.dart';

class ClientService {
  static String clientReference = firebaseReferences.client;
  static String typepresyamos = firebaseReferences.tipodeprestamo;
  static final ClientService _instance = ClientService._internal();

  factory ClientService() {
    return _instance;
  }
  ClientService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  Future<bool> saveclient({Client? client}) async {
    try {
      await database.save(
        client!.toJson(),
        clientReference,
      );
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  FirebaseFirestore getlistclient2 = FirebaseFirestore.instance;
  CollectionReference obtenerlist() {
    return FirebaseFirestore.instance.collection(clientReference);
  }

/*   Future<bool> deleteclient(Client? client) async {
    try {
      await database.deleteDocument(client?.id, clientReference);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } */
  CollectionReference clientedelete =
      FirebaseFirestore.instance.collection(clientReference);
  Future<void> deleteclient(id) {
    return clientedelete.doc(id).delete();
  }

  Future<bool> updateclient(Client client) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
          collection: clientReference, documentId: client.id!);
      await docRef.update(client.toJson());
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  Future<List<Client>> getClients() async {
    try {
      List<Client> cobradores = [];
      var querySnapshot = await database.getData(clientReference);
      cobradores.addAll(
          querySnapshot.docs.map((e) => Client.fromJsonMap(e)).toList());

      return cobradores;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<List<Client>> getClientById(String id) async {
    try {
      List<Client> cliente = [];
      var querySnapshot = await database.getDataById(id, clientReference);
      cliente.addAll(
          querySnapshot.docs.map((e) => Client.fromJsonMap(e)).toList());

      return cliente;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

ClientService clientService = ClientService();
