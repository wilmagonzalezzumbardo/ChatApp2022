import 'package:flutter/material.dart';

class ClassProvider extends ChangeNotifier {
  late bool estaEscribiendo;
  late String texto;

  ClassProvider() {
    estaEscribiendo = false;
    texto = "";
  }

  String get text1 {
    return this.texto;
  }

  set text1(String valor) {
    this.texto = valor;
  }

  bool get estaEscribiendo1 {
    return this.estaEscribiendo;
    //notifyListeners();
  }

  set estaEscribiendo1(bool valor) {
    this.estaEscribiendo = valor;
    notifyListeners();
  }
}
