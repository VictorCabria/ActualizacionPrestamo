import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Database {
  var firestore = FirebaseFirestore.instance;

  /// Obtiene todos los registros de una coleccion
  Future<QuerySnapshot> getData(String collection) {
    return firestore.collection(collection).get();
  }

  /// Obtiene el stream de una coleccion
  Stream<QuerySnapshot> getCollectionSnapshot(String collection) {
    return firestore.collection(collection).snapshots();
  }

  /// Obtiene un documento dentro de una coleccion mediante su ID
  Future<QuerySnapshot> getDataById(String documentId, String collection) {
    return firestore
        .collection(collection)
        .where('id', isEqualTo: documentId)
        .get();
  }

  /// Obtiene una subcolección dentro de una coleccion mediante el ID de un documento
  Future<QuerySnapshot<Map<String, dynamic>>> getSubcollectionFromDocument(
      String documentId, String collection, String subcollection) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getSubcollectionFromDocumentordenby(
          String documentId, String collection, String subcollection) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .orderBy('ncuotas')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getSubcollectionFromDocumentordenbydesencente(
          String documentId, String collection, String subcollection) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .orderBy('ncuotas', descending: true)
        .get();
  }

  DocumentReference getDocumentReferenceupdate(
      {required String collection,
      required String documentId,
      required String subcollection,
      required String subdocumentid}) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .doc(subdocumentid);
  }

  /// Obtiene la referencia de un documento
  DocumentReference getDocumentReference({
    required String collection,
    required String documentId,
  }) {
    return firestore.collection(collection).doc(documentId);
  }

  /// Guarda un documento dentro de una coleccion
  Future<String> save(Map<String, dynamic> document, String collection) async {
    try {
      String? _documentId = document['id'];

      if (_documentId != null) {
        firestore.collection(collection).doc(_documentId).set(document);
        return _documentId;
      } else {
        String _id = createId(collection);
        firestore.collection(collection).doc(_id).set({'id': _id, ...document});
        return _id;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return "error $e";
    }
  }

  /// Actualiza un documento ([data] debe ir en formato json {})
  Future updateDocument(documentID, data, collection) {
    return firestore.doc('$collection/$documentID').update(data);
  }

  /// Borra un documento de una coleccion
  deleteDocument(documentId, collection) {
    return firestore.collection(collection).doc(documentId)..delete();
  }

  /// Borra un documento de una subcoleccion dentro de una coleccion
  deleteDocumentFromSubcollection(collectionDocumentId, collection,
      subcollectionDocumentId, subcollection) {
    return firestore
        .collection(collection)
        .doc(collectionDocumentId)
        .collection(subcollection)
        .doc(subcollectionDocumentId)
      ..delete();
  }

  /// Crea un id único en firebase
  createId(collection) {
    CollectionReference _collRef = firestore.collection(collection);
    DocumentReference _docReferance = _collRef.doc();
    return _docReferance.id;
  }

  /// Retorna un documento dado su id y en que coleccion se encuentra
  Future<DocumentSnapshot> getDocument(
      {required String documentId, required String collection}) {
    return firestore.collection(collection).doc(documentId).get();
  }

  /// Obtiene el stream de una coleccion pero filtrada
  Stream<QuerySnapshot> getCollectionSnapshotQuery(
    String collection,
    String property,
    String equal,
  ) {
    return firestore
        .collection(collection)
        .where(property, isEqualTo: equal)
        .snapshots();
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollectionOrderBy(
    String collection,
    String? property,
    dynamic equal,
  ) {
    if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .orderBy('fecha', descending: true)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollection(
    String collection,
    String? property,
    dynamic equal,
  ) {
    if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  Future<QuerySnapshot> getCollectionfiltrado(
    String collection,
    String? property,
    dynamic equal,
  ) {
    if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .where("procesado", isEqualTo: false)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollectionMoreFilter(
      String collection, String? property, dynamic equal,
      [String? property2, dynamic equal2]) {
    if (property2 != null) {
      return firestore
          .collection(collection)
          .where(property!, isEqualTo: equal)
          .where(property2, isEqualTo: equal2)
          .get();
    } else if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollectionMoreFilterMayor(
      String collection, String? property, dynamic equal,
      [String? property2, dynamic equal2]) {
    if (property2 != null) {
      return firestore
          .collection(collection)
          .where(property!, isGreaterThan: equal)
          .where(property2, isEqualTo: equal2)
          .get();
    } else if (property != null) {
      print("mayor a 0");

      return firestore
          .collection(collection)
          .where(property, isGreaterThan: equal)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene una coleccion con una query custom
  Future<QuerySnapshot> getCollectionCustomQuery(Query query) {
    return query.get();
  }

  /// Obtiene el stream de una coleccion pero ordenada
  Stream<QuerySnapshot> getOrderedCollectionSnapshot(
    String collection,
    property,
    bool desc,
  ) {
    return firestore
        .collection(collection)
        .orderBy(property, descending: desc)
        .snapshots();
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    String? filterProperty,
    dynamic filterValue,
  ) async {
    if (filterProperty == null || filterValue == null) {
      var _pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(lastDocument);
      }

      return await _pageUserQuery.get();
    } else {
      var _pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(lastDocument);
      }

      return await _pageUserQuery.get();
    }
  }

  Future<QuerySnapshot> getNextQuerySnapshot(
    DocumentSnapshot? lastDocument,
    Query query,
  ) async {
    var _pageQuery = query;

    if (lastDocument != null) {
      _pageQuery = _pageQuery.startAfterDocument(lastDocument);
    }

    return await _pageQuery.get();
  }

  /// Obtiene la anteriror subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getBackPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    DocumentSnapshot firtsDocument,
    String? filterProperty,
    dynamic filterValue,
  ) async {
    if (filterProperty == null || filterValue == null) {
      var _pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(firtsDocument);
      }

      return await _pageUserQuery.get();
    } else {
      var _pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        _pageUserQuery = _pageUserQuery.startAfterDocument(firtsDocument);
      }

      return await _pageUserQuery.get();
    }
  }

  /// Obtiene el stream de una coleccion
  Stream<DocumentSnapshot> getCollectionByIDSnapshot(
    String collection,
    String id,
  ) {
    return firestore.collection(collection).doc(id).snapshots();
  }

  /// Guarda un documento dentro de una coleccion con un id custom
  // Future<bool> saveWithCustomIdAndSubcollection(
  //   Map<String, dynamic> user,
  //   Map<String, dynamic> subcollectionData,
  //   String collection,
  //   String subCollection,
  //   String customId,
  //   Map<String, dynamic> addressData,
  // ) async {
  //   try {
  //     CollectionReference collRef = firestore.collection(collection);
  //     DocumentReference docReferance = collRef.doc(customId);

  //     await firestore
  //         .collection(collection)
  //         .doc(docReferance.id)
  //         .set({...user});

  //     await firestore
  //         .collection(collection)
  //         .doc(docReferance.id)
  //         .collection(subCollection)
  //         .add(subcollectionData);

  //     await firestore
  //         .collection(collection)
  //         .doc(docReferance.id)
  //         .collection(firebaseReferences.addresses)
  //         .add(addressData);

  //     return true;
  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  /// Guarda un documento dentro de una subcoleccion dado un ID

  Future<bool> saveDocumentInSubcollection({
    required String documentId,
    required String collection,
    required String subcollection,
    required Map<String, dynamic> subcollectionData,
  }) async {
    try {
      // var reference =
      await firestore
          .collection(collection)
          .doc(documentId)
          .collection(subcollection)
          .add(subcollectionData);
      // subcollectionData['id'] = reference.id;
      // await reference.update(subcollectionData);
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}

final Database database = Database();
