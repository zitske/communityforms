import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

String validateforms(
    TextEditingController _email, TextEditingController _password) {
  print("Validate Forms Started!");

  if (_email.text.isEmpty == true) {
    //email is empty
    print("email is empty");
    return "Email is empty";
  } else if (_password.text.isEmpty == true) {
    //password is empty
    print("password is empty");
    return "Password is empty";
  } else if (_password.text.length < 6) {
    //password is < 6 char
    print("password is < 6 char");
    return "Password is < 6 char";
  } else if (EmailValidator.validate(_email.text) == false) {
    //email has invalid format
    print("email has invalid format");
    return "Email has invalid format";
  } else if (_email.text.isEmpty == false &&
      _password.text.isEmpty == false &&
      _password.text.length >= 6 &&
      EmailValidator.validate(_email.text) == true) {
    //remail and password validated
    print("Email and password validated");
    return "true";
  } else {
    //something went wrong
    print("Unknown ERROR");
  }
}
