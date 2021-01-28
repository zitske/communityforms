import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/utils/firebaseexeptions.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
String inputData() {
  final User user = _auth.currentUser;
  final uid = user.uid;
  return uid;
}

Future<String> register(String _email, String _password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );

    firestore.collection("users").doc(inputData()).set({
      'name': _auth.currentUser.displayName.toString(),
      'email': _auth.currentUser.email.toString(),
    });
    print("The user has been successfully registered.");
    return "true";
  } on FirebaseAuthException catch (e) {
    debugPrint(getFirebaseAuthExceptions(e.code));
    return getFirebaseAuthExceptions(e.code);
  }
}
