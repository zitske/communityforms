import 'package:flutter/material.dart';

Widget TodayResumeCard(
    dynamic context, String devicename, double momentconsumption) {
  double maxvalue = 1;
  if (momentconsumption > maxvalue) {
    maxvalue = momentconsumption;
  }

  return Container(
      width: 350,
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 30),
                  )
                ]),
          ),
          Expanded(flex: 2, child: Center(child: Container()))
        ]),
      ));
}
