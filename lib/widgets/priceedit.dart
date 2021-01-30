import 'package:flutter/material.dart';

Future<dynamic> editPrice(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: new Text("Preco por kWh"),
        content: Column(
          children: [TextFormField()],
        ),
        actions: <Widget>[
          // define os botões na base do dialogo
          new FlatButton(
            child: new Text("Salvar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
