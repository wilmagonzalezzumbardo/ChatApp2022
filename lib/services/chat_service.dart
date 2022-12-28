import 'package:fl_12_chatapp/models/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../globals/environment.dart';
import '../models/usuario.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  ChatService({
    this.usuarioPara,
  });

  Future getChat(String usuarioID) async {
    var url = Uri.https('${Environment.apiUrl}', '/api/mensajes/$usuarioID');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    MensajesResponse listado = mensajesResponseFromJson(resp.body);
    print(listado.mensajes);
    return listado.mensajes;
  }
}
