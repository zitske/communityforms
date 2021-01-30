import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/recover.dart';
import 'package:flutter_app/utils/signin.dart';
import 'package:flutter_app/utils/toggle.dart';
import 'package:flutter_app/utils/validateforms.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_app/utils/register.dart';
import 'package:flutter_app/utils/autologin.dart';

class LogRegDrawer extends StatefulWidget {
  final Brightness deviceTheme;
  LogRegDrawer({Key key, this.deviceTheme}) : super(key: key);
  @override
  _LogRegDrawer createState() => _LogRegDrawer();
}

class _LogRegDrawer extends State<LogRegDrawer> {
  String tipo = "LOGIN";
  bool _toggled = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _emailvalidate = false;
  bool _passwordvalidate = false;
  bool obscureText = true;
  String validadeerror = "";
  String loggedUser;
  String errorMessage;
  bool showProgress = false;
  String status;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    autologin();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => DynamicTheme.of(context).setBrightness(widget.deviceTheme));
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).brightness);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
            // use ternary operator to decide when to show progress indicator
            child: showProgress
                ? CircularProgressIndicator()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("lib/assets/zits.png"),
                                  width: 250,
                                ),
                              ]),
                        ),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5.0),
                                        ),
                                        errorText: _emailvalidate
                                            ? '$validadeerror'
                                            : null,
                                        hintText: 'Email'),
                                  ),
                                ),
                                //Spacer
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Visibility(
                                  child: Text("$validadeerror",
                                      style: TextStyle(color: Colors.red[400])),
                                  visible: visible,
                                ),
                                SizedBox(
                                  height: height * 0.005,
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5.0),
                                        ),
                                        errorText: _passwordvalidate
                                            ? '$validadeerror'
                                            : null,
                                        hintText: 'Password'),
                                    obscureText: obscureText,
                                  ),
                                ),
                                //Visibility
                                Container(
                                  width: width * 0.8,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureText =
                                                    toggle(obscureText);
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                new Icon(obscureText
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                new Text(obscureText
                                                    ? "Show"
                                                    : "Hide")
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
                                                  builder: (context) =>
                                                      RecoverScreen()));
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      onPressed: () async {
                                        print("Loading...");
                                        setState(() {
                                          showProgress = true;
                                        });
                                        // perform asynchronous task here
                                        if (validateforms(_email, _password) ==
                                            "true") {
                                          if (_toggled != false) {
                                            //register
                                            status = await register(
                                                _email.text, _password.text);
                                          } else {
                                            //login
                                            status = await signin(
                                                _email.text, _password.text);
                                          }
                                        } else {
                                          status =
                                              validateforms(_email, _password);
                                        }
                                        await Future.delayed(
                                            Duration(seconds: 4), null);

                                        setState(() {
                                          // set the progress indicator to true so it would not be visible
                                          showProgress = false;
                                          // navigate to your desired page
                                          if (status == "true") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(
                                                            uid: inputData())));
                                          } else {
                                            print("Status: $status");
                                            visible = true;
                                            validadeerror = "$status";
                                          }
                                        });
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
                                      visible = false;
                                      if (_toggled == false) {
                                        tipo = "LOGIN";
                                        //DynamicTheme.of(context).setBrightness(Brightness.light);
                                      } else {
                                        tipo = "REGISTER";
                                        //DynamicTheme.of(context).setBrightness(Brightness.dark);
                                      }
                                    });
                                  },
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  )));
  }
}
