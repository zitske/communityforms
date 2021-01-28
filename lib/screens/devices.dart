import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DevicesScreen extends StatefulWidget {
  final String uid;
  DevicesScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            color: Theme.of(context).canvasColor,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Home",
                  style: TextStyle(fontSize: 40),
                ),
              ]),
            ])));
  }
}
