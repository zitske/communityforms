import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/screens/home.dart';
import 'login.dart';
import 'recover.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brightness getBright() {
    final Brightness devicebright =
        SchedulerBinding.instance.window.platformBrightness;
    return devicebright;
  }

  @override
  void initState() {
    super.initState();
    getBright();
  }

  @override
  Widget build(BuildContext context) {
    print(getBright());
    print(" - 1");
    return new DynamicTheme(
        defaultBrightness: getBright(),
        data: (brightness) => new ThemeData(
              fontFamily: "WorkSans",
              primarySwatch: Colors.green,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Login or register',
            theme: theme,
            home: LogRegDrawer(deviceTheme: getBright()),
          );
        });
  }
}
//Colors.grey[200]
