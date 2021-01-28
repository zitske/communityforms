import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class DevicesScreen extends StatefulWidget {
  final String uid;
  DevicesScreen({Key key, @required this.uid}) : super(key: key);
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    Future getDevices() async {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore
          .collection("users")
          .doc(widget.uid)
          .collection("devices")
          .get();
      return qn.docs;
    }

    return Center(
        child: Container(
            color: Theme.of(context).canvasColor,
            child: FutureBuilder<QuerySnapshot>(
              future: getDevices(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      //itemCount: snapshot.data,
                      itemBuilder: (_, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 100,
                                child: Row(
                                  children: [
                                    //Text(snapshot.data.docs)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                )));
                        //ListTile(
                        //title: Text('${items[index]}'),
                      },
                    );
                  } else {
                    return Center(
                        child: Column(children: [
                      Text("Voce nao tem nenhumdispositivo cadastrado"),
                      Text(
                          'Clique no botao + para adicionar um novodispositivo')
                    ]));
                  }
                }
              },
            )));
  }
}
