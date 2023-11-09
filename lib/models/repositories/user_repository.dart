import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../db/database_manager.dart';

class UserRepository{
  final DatabaseManager dbManager;
  UserRepository({required this.dbManager});
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<bool> isSingIn() async {
    final firebaseUser = _auth.currentUser;
    if(firebaseUser != null) {
      return true;
    }
    return false;
  }
}