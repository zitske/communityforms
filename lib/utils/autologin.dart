import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/utils/signin.dart';

void autologin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String userEmail = prefs.getString("email");
  final String userPassword = prefs.getString("Password");

  if (userPassword != null && userEmail != null) {
    //_signin(_email.text, _password.text,context);
  } else {
    print("No user login saved");
  }
}
