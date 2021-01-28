import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebaseexeptions.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> signin(String _email, String _password) async {
  try {
    final res = await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    if (res != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', _email);
      prefs.setString('password', _password);
      print("The login information has been saved.");
      return "true";
    }
  } on FirebaseAuthException catch (e) {
    debugPrint(getFirebaseAuthExceptions(e.code));

    return getFirebaseAuthExceptions(e.code);
  }
}
