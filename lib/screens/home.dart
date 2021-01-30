import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/deviceconfig.dart';
import 'package:flutter_app/screens/devices.dart';
import 'package:flutter_app/screens/graph.dart';
import 'package:flutter_app/screens/myapp.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/utils/singout.dart';

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
    final List<Widget> _floating = [
      FloatingActionButton(
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
      FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.settings,
          size: 35,
        ),
        onPressed: () => setState(
          () {},
          //params
        ),
      ),
      FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.arrow_forward,
          size: 35,
        ),
        onPressed: () => setState(
          () {
            signOut();
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          //params
        ),
      ),
    ];
    print(widget.uid);
    print(userId);

    final iconList = <IconData>[Icons.home, Icons.bar_chart, Icons.person];

    void _onTap(int index) {
      setState(() {
        activeIndex = index;
      });
    }

    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
              body: _screens[activeIndex],
              floatingActionButton: _floating[activeIndex],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
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
            )));
  }
}
