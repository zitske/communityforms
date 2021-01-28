import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DeviceConfig extends StatefulWidget {
  final String devId;
  final String uid;
  DeviceConfig({Key key, @required this.devId, @required this.uid})
      : super(key: key);
  @override
  _DeviceConfigState createState() => _DeviceConfigState();
}

class _DeviceConfigState extends State<DeviceConfig> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _devicename = TextEditingController();
  String deviceVoltage = "220";
  bool _toggled = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.devId);
    return Scaffold(
      appBar: AppBar(title: new Text('Configurar Dispositivo')),
      body: Center(
          child: Container(
        color: Theme.of(context).canvasColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hoverColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nome do dispositivo:",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).accentColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width * 0.8,
                          //height: height * 0.05,
                          child: TextFormField(
                            controller: _devicename,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                              ),
                              //errorText: _emailvalidate ? null : '$emailvalidadeerror',
                              //hintText: ''
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "220V",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                            FlutterSwitch(
                              /*activeText: "110V",
                              activeTextColor: Theme.of(context).accentColor,
                              inactiveTextColor: Theme.of(context).accentColor,
                              inactiveText: "220V",*/
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
                                    deviceVoltage = "110";
                                    print("$deviceVoltage");
                                    //DynamicTheme.of(context).setBrightness(Brightness.light);
                                  } else {
                                    deviceVoltage = "220";
                                    print("$deviceVoltage");
                                    //DynamicTheme.of(context).setBrightness(Brightness.dark);
                                  }
                                });
                              },
                            ),
                            Text(
                              "110V",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                                  if (_devicename.text.isNotEmpty) {
                                    firestore
                                        .collection("users")
                                        .doc(widget.uid)
                                        .collection("devices")
                                        .doc(widget.devId)
                                        .set(
                                      {
                                        'name': _devicename.text,
                                        "code": widget.devId
                                      },
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                                  uid: widget.uid,
                                                )));
                                  }
                                },
                                child: Center(
                                  child: Text("Adicionar",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).accentColor)),
                                )),
                          ),
                        ),
                      ],
                    )),
              )),
        ]),
      )),
    );
  }
}
