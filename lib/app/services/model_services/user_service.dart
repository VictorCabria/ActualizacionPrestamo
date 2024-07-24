import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/references.dart';
import '../firebase_services/database_services.dart';

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
}
UserService userService = UserService();
