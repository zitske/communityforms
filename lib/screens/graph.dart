import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  final String uid;
  GraphScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<ListMonth> _dropdownItems = [
    ListMonth(1, "Janeiro"),
    ListMonth(2, "Fevereiro"),
    ListMonth(3, "Marco"),
    ListMonth(4, "Maio"),
    ListMonth(5, "Abril"),
    ListMonth(6, "Junho"),
    ListMonth(7, "Julho"),
    ListMonth(8, "Agosto"),
    ListMonth(9, "Setembro"),
    ListMonth(10, "Outubro"),
    ListMonth(11, "Novembro"),
    ListMonth(12, "Dezembro"),
  ];
  List<DropdownMenuItem<ListMonth>> _dropdownMenuItems;
  ListMonth _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[1].value;
  }

  List<DropdownMenuItem<ListMonth>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListMonth>> items = List();
    for (ListMonth listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Future getDevices() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot consumo = await firestore
          .collection("devices")
          .doc("D100001")
          .collection("consumo_amount")
          .get();
      QuerySnapshot data = await firestore
          .collection("devices")
          .doc("D100001")
          .collection("date")
          .get();

      return;
    }

    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Consumo em"),
              SizedBox(width: 10),
              DropdownButton<ListMonth>(
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
            ],
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<MonthData, String>>[
                LineSeries<MonthData, String>(
                    // Bind data source
                    dataSource: <MonthData>[
                      MonthData(1.0, "1"),
                      MonthData(2.0, "2"),
                      MonthData(6.5, "3"),
                      MonthData(4.3, "4"),
                      MonthData(1.9, "5")
                    ],
                    xValueMapper: (MonthData amount, _) => amount.amount,
                    yValueMapper: (MonthData amount, _) => amount.day)
              ]),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Consumo de hoje (kW x h)'),
              series: <LineSeries<MonthData, String>>[
                LineSeries<MonthData, String>(
                    // Bind data source
                    dataSource: <MonthData>[
                      MonthData(102.0, "0"),
                      MonthData(98.0, "1"),
                      MonthData(78.5, "2"),
                      MonthData(89.3, "3"),
                      MonthData(150.9, "4"),
                      MonthData(20.7, "5"),
                      MonthData(98.5, "6"),
                      MonthData(105.9, "7"),
                      MonthData(86.4, "8"),
                      MonthData(34.9, "9"),
                      MonthData(106.5, "10"),
                      MonthData(98.0, "11"),
                      MonthData(78.5, "12"),
                      MonthData(89.3, "13"),
                      MonthData(150.9, "14"),
                      MonthData(20.7, "15"),
                      MonthData(98.5, "16"),
                      MonthData(105.9, "17"),
                      MonthData(86.4, "18"),
                      MonthData(34.9, "19"),
                      MonthData(106.5, "20"),
                      MonthData(98.0, "21"),
                      MonthData(78.5, "22"),
                      MonthData(89.3, "23"),
                      MonthData(150.9, "24"),
                    ],
                    xValueMapper: (MonthData amount, _) => amount.amount,
                    yValueMapper: (MonthData amount, _) => amount.day)
              ]),
        ],
      ),
    );
  }
}

class MonthData {
  MonthData(this.day, this.amount);
  final double day;
  final String amount;
}

class ListMonth {
  int value;
  String name;

  ListMonth(this.value, this.name);
}
