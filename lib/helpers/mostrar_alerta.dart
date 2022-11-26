import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subTitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Text(subTitulo),
              actions: [
                MaterialButton(
                    child: Text("ok"),
                    elevation: 5,
                    textColor: Colors.orange,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ));
  }
  return showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog
    (
      title: Text(titulo),
      content: Text(subTitulo),
      actions: 
      [
        CupertinoDialogAction
        (
          isDefaultAction: true,
          child: Text("ok"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    )
  );
}
