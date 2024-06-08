import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginRepo extends ChangeNotifier with DiagnosticableTreeMixin {
  String? err;
  Future<bool> login(String email, String password) async {
    err = null;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password,
          
          );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        err = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        err = ('Wrong password provided for that user.');
      } else {
        err = e.message;
      }
      notifyListeners();
      return false;
    }
  }
}
