import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_app/widgets/devicecard.dart';
import 'package:flutter_app/widgets/todayresumecard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DevicesScreen extends StatefulWidget {
  final String uid;
  DevicesScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  dynamic getDevices(String uid) {
    List<dynamic> devices = [];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                devices = doc.data()["devices"];
                print(devices.toString());
              })
            });
    return devices;
  }

  @override
  void initState() {
    getDevices(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: "WorkSans",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.18,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ]),
                          Divider(
                            height: 5,
                            color: Theme.of(context).canvasColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TodayResumeCard(context, "Cafeteira", 10),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Devices",
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: "WorkSans",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.18,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Divider(
                              height: 5,
                              color: Theme.of(context).canvasColor,
                            ),
                            DeviceCard(context, "Cafeteira", 10),
                          ]),
                    ),
                  ]))),
    );
  }
}
