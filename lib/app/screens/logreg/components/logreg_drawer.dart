import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/screens/home/home_screen.dart';
import 'package:flutter_app/app/screens/logreg/components/recover.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogRegDrawer extends StatefulWidget {
  @override
  _LogRegDrawer createState() => _LogRegDrawer();
}

class _LogRegDrawer extends State<LogRegDrawer> {
  String tipo = "LOGIN";
  bool _toggled = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _emailvalidate = true;
  bool _passwordvalidate = true;
  bool _obscureText = true;
  String passwordvalidadeerror = "";
  String emailvalidadeerror = "";
  bool _successlogin;
  String loggedUser;
  String errorMessage;

//For show/hide password
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

//For check if user are logged in when app initialize
  void _autologin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString("email");
    final String userPassword = prefs.getString("Password");

    if (userPassword != null && userEmail != null) {
      _signin(_email.text, _password.text);
    } else {
      print("No user login saved");
    }
  }

//For validation of user and password texts
  void _validateforms() {
    int _exeption;
    print("Validate Forms Started!");

    if (_email.text.isEmpty == true) {
      //email is empty
      _emailvalidate = false;
      _exeption = 0;
      _exeptionset(_exeption);
    } else if (_password.text.isEmpty == true) {
      //password is empty
      _passwordvalidate = false;
      _exeption = 1;
      _exeptionset(_exeption);
    } else if (_password.text.length < 6) {
      //password is < 6 char
      _passwordvalidate = false;
      _exeption = 2;
      _exeptionset(_exeption);
    } else if (EmailValidator.validate(_email.text) == false) {
      //email has invalid format
      _emailvalidate = false;
      _exeption = 3;
      _exeptionset(_exeption);
    } else if (_email.text.isEmpty == false &&
        _password.text.isEmpty == false &&
        _password.text.length >= 6 &&
        EmailValidator.validate(_email.text) == true) {
      //remail and password validated
      _emailvalidate = true;
      _passwordvalidate = true;
      _exeption = 5;
      _exeptionset(_exeption);
      print("Email and password validated");
    } else {
      //something went wrong
      print("Unknown ERROR");
    }
  }

  void _exeptionset(int _error) {
    print("Exeption found");

    switch (_error) {
      case 0:
        print("Case 0");
        passwordvalidadeerror = "Email value Can\'t Be Empty";
        break;
      case 1:
        print("Case 1");
        passwordvalidadeerror = "Password value Can\'t Be Empty";
        break;
      case 2:
        print("Case 2");
        passwordvalidadeerror =
            "The password must contain at least 6 characters";
        break;
      case 3:
        print("Case 3");
        emailvalidadeerror = "Invalid email format";
        break;
      case 4:
        print("Case 4");
        passwordvalidadeerror = "Wrong credentials/not registred";
        break;
      case 5:
        print("Case 5");
        print("All right");
        break;
    }
  }

//For register a new user
  void _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _toggled = false;
        _successlogin = true;
        tipo = "LOGIN";
        print("Register OK");
        firestore.collection("users").doc(inputData()).set({
          'name': _auth.currentUser.displayName.toString(),
          'email': _auth.currentUser.email.toString(),
          'profimg': _auth.currentUser.photoURL.toString()
        });
        //_userEmail = user.email;
      });
    } else {
      setState(() {
        print("Register ERROR");
        _successlogin = false;
      });
    }
  }

  String getFirebaseAuthExceptions(String code) {
    switch (code) {
      case "INVALID_EMAIL":
        return "Your email address appears to be malformed.";

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

  String inputData() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }

//For login user
  void _signin(String _useremail, String _userpassword) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
        email: _useremail,
        password: _userpassword,
      );
      if (res != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', _useremail);
        prefs.setString('password', _userpassword);
        print("Saved lg inf");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(uid: inputData())));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(getFirebaseAuthExceptions(e.code));
    }
  }

  @override
  void initState() {
    _autologin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Email input
          Container(
            color: Theme.of(context).canvasColor,
            width: width * 0.8,
            //height: height * 0.05,
            child: TextFormField(
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
                  errorText: _emailvalidate ? null : '$emailvalidadeerror',
                  hintText: 'Email'),
            ),
          ),
          //Spacer
          SizedBox(
            height: height * 0.01,
          ),
          //Password input
          Container(
            width: width * 0.8,
            //height: height * 0.05,
            child: TextFormField(
              controller: _password,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.visiblePassword,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                  ),
                  errorText:
                      _passwordvalidate ? null : '$passwordvalidadeerror',
                  hintText: 'Password'),
              obscureText: _obscureText,
            ),
          ),
          //Visibility
          Container(
            width: width * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextButton(
                      onPressed: _toggle,
                      child: Row(
                        children: [
                          new Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          SizedBox(
                            width: 10,
                          ),
                          new Text(_obscureText ? "Show" : "Hide")
                        ],
                      )),
                ),
                Expanded(child: Container()),
                Container(
                    child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecoverScreen()));
                  },
                  child: new Text(
                    "Forgot the password?",
                    style: TextStyle(fontSize: 10),
                  ),
                ))
              ],
            ),
          ),
          //Spacer
          SizedBox(
            height: height * 0.04,
          ),
          //Login/Register button
          Container(
            height: height * 0.05,
            width: width * 0.8,
            child: Center(
              child: RaisedButton(
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  setState(
                    () {
                      _validateforms();
                      if ((_emailvalidate && _passwordvalidate) == true) {
                        if (_toggled != false) {
                          //register
                          _register();
                        } else {
                          //login
                          _signin(_email.text, _password.text);
                        }
                      }
                    },
                  );
                },
                child: Center(child: Text("$tipo")),
              ),
            ),
          ),
          //Spacer
          SizedBox(
            height: height * 0.07,
          ),
          //Mode switch
          FlutterSwitch(
            activeColor: Colors.green,
            inactiveColor: Colors.grey[300],
            toggleColor: Colors.blueGrey[700],
            width: width * 0.15,
            height: height * 0.04,
            valueFontSize: 25.0,
            toggleSize: height * 0.03,
            value: _toggled,
            borderRadius: 30.0,
            padding: 4.0,
            showOnOff: false,
            onToggle: (val) {
              _toggled = val;
              setState(() {
                if (_toggled == false) {
                  tipo = "LOGIN";
                  DynamicTheme.of(context).setBrightness(Brightness.light);
                } else {
                  tipo = "REGISTER";
                  DynamicTheme.of(context).setBrightness(Brightness.dark);
                }
              });
            },
          )
        ],
      ),
    ));
  }
}
