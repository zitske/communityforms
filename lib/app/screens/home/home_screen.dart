import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/screens/deviceAdd/qrReader.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  HomeScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10000, (i) => "Item $i");
    final iconList = <IconData>[Icons.home, Icons.bar_chart, Icons.person];
    int activeIndex = 0;

    void _onTap(int index) {
      setState(() {
        activeIndex = index;
      });
    }

    Future getDevices() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore
          .collection("users")
          .doc(widget.uid)
          .collection("devices")
          .get();
      return qn;
    }

    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Container(
              color: Theme.of(context).canvasColor,
              child: FutureBuilder(
                future: getDevices(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 100,
                                child: Row(
                                  children: [Text(snapshot.data["name"])],
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20.0),
                                )));
                        //ListTile(
                        //title: Text('${items[index]}'),
                      },
                    );
                  }
                },
              ))),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => setState(
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => new QrRead()));
          },
          //params
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        inactiveColor: Theme.of(context).disabledColor,
        activeColor: Theme.of(context).toggleableActiveColor,
        height: 65,
        iconSize: 30,
        icons: iconList,
        activeIndex: activeIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: _onTap,
        //other params
      ),
    ));
  }
}
