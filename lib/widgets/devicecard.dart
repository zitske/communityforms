import 'package:flutter/material.dart';

Widget DeviceCard(
    dynamic context, String devicename, double momentconsumption) {
  double maxvalue = 1;
  if (momentconsumption > maxvalue) {
    maxvalue = momentconsumption;
  }
  int displayvalue = momentconsumption.toInt();
  double graphvalue = (momentconsumption / maxvalue) / 10;

  return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(-1, 1), // changes position of shadow
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            flex: 1,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                devicename,
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 30),
              )
            ]),
          ),
          Expanded(
              flex: 2,
              child: Center(
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$displayvalue",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 40),
                    ),
                    Text(
                      "kWh",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                    backgroundColor: Theme.of(context).disabledColor,
                    strokeWidth: 15,
                    value: graphvalue,
                  ),
                )
              ])))
        ]),
      ));
}
