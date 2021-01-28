import 'package:flutter/material.dart';
import 'package:flutter_app/app/screens/logreg/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'logreg_drawer.dart';

class RecoverScreen extends StatefulWidget {
  @override
  _RecoverScreenState createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final _email = TextEditingController();
    String emailvalidadeerror = "";
    bool _emailvalidate = true;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String getFirebaseAuthExceptions(String code) {
      switch (code) {
        case "user-not-found":
          return "Usuario nao cadastrado";

        case "WRONG_PASSWORD":
          return "Your password is wrong.";

        case "SER_NOT_FOUND":
          return "User with this email doesn't exist.";

        case "USER_DISABLED":
          return "User with this email has been disabled.";

        case "TOO_MANY_REQUESTS":
          return "Muitas tentativas. Tente mais tarde.";

        case "OPERATION_NOT_ALLOWED":
          return "Signing in with Email and Password is not enabled.";

        default:
          return 'Erro desconhecido';
      }
    }

    void _recover(String email) async {
      try {
        await _auth.sendPasswordResetEmail(email: _email.text);
        showAlertDialog(context);
      } on FirebaseAuthException catch (e) {
        debugPrint(getFirebaseAuthExceptions(e.code));
        setState(() {
          emailvalidadeerror = getFirebaseAuthExceptions(e.code);
          _emailvalidate = false;
        });
      }
    }

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Theme.of(context).canvasColor,
            width: width * 0.8,
            //height: height * 0.05,
            child: TextField(
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                  ),
                  errorText: _emailvalidate ? '$emailvalidadeerror' : null,
                  hintText: 'Email'),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.4,
            child: Center(
              child: RaisedButton(
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  setState(
                    () {
                      _recover(_email.text);
                    },
                  );
                },
                child: Center(child: Text("Recuperar")),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogRegDrawer()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sucesso!"),
    content: Text(
        "Voce recebera um email com as intrucoes para a recuperacao da senha."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
