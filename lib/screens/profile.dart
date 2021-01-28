import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_app/screens/myapp.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Future getData() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore
          .collection("users")
          .doc(widget.uid)
          .collection("devices")
          .get();
      return qn.docs;
    }

    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("UserName"),
        RaisedButton(
          color: Colors.red[700],
          onPressed: () {
            setState(() {
              _signOut();
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            });
          },
          child: const Text('Sair', style: TextStyle(fontSize: 20)),
        ),
      ],
    ));
  }
}
