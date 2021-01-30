import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_app/screens/myapp.dart';
import 'package:flutter_app/widgets/priceedit.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _toggled = false;
  int tension = 220;

  @override
  Widget build(BuildContext context) {
    double price = 1.000;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future getData() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore
          .collection("users")
          .doc(widget.uid)
          .collection("devices")
          .get();
      return qn.docs;
    }

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Hi,",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "WorkSans",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.18,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "eduardomontzitske@gmail.com",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 30),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Divider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.18,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      "$price R\$/kWh",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 30),
                    ),
                    Spacer(),
                    InkWell(
                        child: Icon(Icons.edit),
                        onTap: () {
                          editPrice(context);
                        })
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                Row(
                  children: [
                    Text(
                      "Voltage",
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.18,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "220V",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 30),
                    ),
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
                            tension = 220;
                            //DynamicTheme.of(context).setBrightness(Brightness.light);
                          } else {
                            tension = 110;
                            //DynamicTheme.of(context).setBrightness(Brightness.dark);
                          }
                        });
                      },
                    ),
                    Text(
                      "110V",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 30),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
