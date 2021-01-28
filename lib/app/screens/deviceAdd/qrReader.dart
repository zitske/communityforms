import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import 'deviceconfig.dart';

class QrRead extends StatefulWidget {
  @override
  _QrReadState createState() => _QrReadState();
}

class _QrReadState extends State<QrRead> {
  String qr;
  bool camState = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Adicionar Dispositivo'),
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: camState
                    ? new Center(
                        child: new QrCamera(
                          onError: (context, error) => Text(
                            error.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          qrCodeCallback: (code) {
                            setState(() {
                              qr = code;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeviceConfig()),
                            );
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      )
                    : new Center(child: new Text("Camera inactive"))),
            new Text("QRCODE: $qr"),
          ],
        ),
      ),
    );
  }
}
