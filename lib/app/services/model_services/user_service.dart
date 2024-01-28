import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';
import '../firebase_services/database_service.dart';
import '/app/utils/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static String userReference = firebaseReferences.users;
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }
  UserService._internal();
  var firestore = FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  Future<Usuarios?> loginusuariosemail(String email) async {
    try {
      List<Usuarios> usuarios = [];
      var querySnapshot =
          await database.getCollection(userReference, 'correo', email);
      usuarios
          .addAll(querySnapshot.docs.map((e) => Usuarios.fromJson(e)).toList());

      return usuarios.first;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
  // Future<bool> save({
  //   required User user,
  //   required String customId,
  //   required Address address,
  //   Bussiness? bussiness,
  //   Client? client,
  // }) async {
  //   try {
  //     user.created = DateTime.now();
  //     switch (user.userType) {
  //       case 'CLIENT':
  //         await database.saveWithCustomIdAndSubcollection(
  //           user.toJson(),
  //           client!.toJson(),
  //           usersReference,
  //           firebaseReferences.client,
  //           customId,
  //           address.toJson(),
  //         );
  //         break;
  //       case 'BUSSINESS':
  //         await database.saveWithCustomIdAndSubcollection(
  //           user.toJson(),
  //           bussiness!.toJson(),
  //           usersReference,
  //           firebaseReferences.bussiness,
  //           customId,
  //           address.toJson(),
  //         );
  //         break;
  //       default:
  //     }
  //     return true;
  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // Future<bool> delete(User user) async {
  //   try {
  //     await database.deleteDocument(user.id, usersReference);
  //     return true;
  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // Future<bool> update(User user) async {
  //   try {
  //     DocumentReference _docRef = database.getDocumentReference(
  //       collection: usersReference,
  //       documentId: user.id!,
  //     );

  //     await _docRef.update(user.toJson());
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  // Future<bool> addBankAccount({
  //   required String documentId,
  //   required BankAccount bankAccount,
  // }) async {
  //   try {
  //     await database.saveDocumentInSubcollection(
  //       collection: firebaseReferences.users,
  //       subcollection: firebaseReferences.bankAccounts,
  //       documentId: documentId,
  //       subcollectionData: bankAccount.toJson(),
  //     );

  //     return true;
  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // Future<bool> deleteBankAccount({
  //   required String collectionDocumentId,
  //   required String subcollectionDocumentId,
  // }) async {
  //   try {
  //     await database.deleteDocumentFromSubcollection(
  //       collectionDocumentId,
  //       firebaseReferences.users,
  //       subcollectionDocumentId,
  //       firebaseReferences.bankAccounts,
  //     );

  //     return true;
  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // Future<List<BankAccount>> getUserBankAccounts({
  //   required String documentId,
  // }) async {
  //   List<BankAccount> list = [];
  //   try {
  //     var subcollection = await database.getSubcollectionFromDocument(
  //         documentId,
  //         firebaseReferences.users,
  //         firebaseReferences.bankAccounts);

  //     for (var bankAccountDoc in subcollection.docs) {
  //       var newBankAccount = BankAccount.fromJson(bankAccountDoc.data());
  //       newBankAccount.id = bankAccountDoc.id;
  //       list.add(newBankAccount);
  //     }
  //     return list;
  //   } on Exception catch (e) {
  //     print(e);
  //     return list;
  //   }
  // }

  // Future<List<Address>> getUserAddresses({
  //   required String documentId,
  // }) async {
  //   List<Address> list = [];
  //   try {
  //     var subcollection = await database.getSubcollectionFromDocument(
  //         documentId, firebaseReferences.users, firebaseReferences.addresses);

  //     for (var addressDoc in subcollection.docs) {
  //       var address = Address.fromJson(addressDoc.data());
  //       address.id = addressDoc.id;
  //       list.add(address);
  //     }
  //     return list;
  //   } on Exception catch (e) {
  //     print(e);
  //     return list;
  //   }
  // }

  // Future<List<User>> getNextPaginated(
  //   int paginationNum,
  //   String filterPropery,
  //   dynamic filterValue,
  // ) async {
  //   var _query = await database.getNextPaginatedCollectionSnapshot(
  //     usersReference,
  //     "createdAt",
  //     paginationNum,
  //     lastDocument!,
  //     filterPropery,
  //     filterValue,
  //   );

  //   if (_query.docs.isNotEmpty) {
  //     lastDocument = _query.docs.last;
  //     // return _query.docs.map((e) => User.fromJson(e.data())).toList();
  //   }

  //   return [];
  // }

  // clearPaginatedReferences() {
  //   lastDocument = null;
  // }

  // Future<User?> getUserDocumentById(
  //   String documentId,
  // ) async {
  //   var _querySnapshot = await database.getDocument(
  //     collection: 'users',
  //     documentId: documentId,
  //   );

  //   if (!_querySnapshot.exists) return null;

  //   return User.fromJson(
  //     _querySnapshot.data() as Map<String, dynamic>,
  //   );
  // }

  // /// Gets an user by phone number
  // Future<User?> getUserDocumentByPhoneNumber(
  //   String phoneNumber,
  // ) async {
  //   dynamic userJson;

  //   var _querySnapshot = await database.getCollection(
  //     'users',
  //     'contactInfo.phoneNumber.basePhoneNumber',
  //     phoneNumber,
  //   );
  //   if (_querySnapshot.docs.isEmpty) return null;

  //   // Loops through response although there should only be one user per phone number
  //   for (var user in _querySnapshot.docs) {
  //     userJson = user.data();
  //   }
  //   return User.fromJson(
  //     userJson as Map<String, dynamic>,
  //   );
  // }

  // Future<User?> getCurrentUser() async {
  //   var _currentFirebaseUser = auth.getCurrentUser();
  //   var user = await getUserDocumentById(
  //     _currentFirebaseUser!.uid,
  //   );
  //   return user;
  // }
}

UserService userService = UserService();
