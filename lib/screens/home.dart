import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/deviceconfig.dart';
import 'package:flutter_app/screens/devices.dart';
import 'package:flutter_app/screens/graph.dart';
import 'package:flutter_app/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  HomeScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String userId;

  int activeIndex = 0;
  @override
  void initState() {
    userId = widget.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      DevicesScreen(uid: widget.uid),
      GraphScreen(uid: widget.uid),
      ProfileScreen(uid: widget.uid)
    ];
    print(widget.uid);
    print(userId);

    final iconList = <IconData>[Icons.home, Icons.bar_chart, Icons.person];

    void _onTap(int index) {
      setState(() {
        activeIndex = index;
      });
    }

    return SafeArea(
        child: Scaffold(
      body: _screens[activeIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => setState(
          () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new DeviceConfig(
                          devId: "TESTTEST",
                          uid: widget.uid,
                        )));
          },
          //params
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        inactiveColor: Theme.of(context).disabledColor,
        activeColor: Theme.of(context).toggleableActiveColor,
        splashColor: Theme.of(context).splashColor,
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
