import '../models/usuario.dart';
import 'package:fl_12_chatapp/models/usuarios_response.dart';
import 'package:fl_12_chatapp/services/auth_service.dart';

import 'package:http/http.dart' as http;
import '../globals/environment.dart';
import 'dart:convert';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      var url = Uri.https('${Environment.apiUrl}', '/api/usuarios');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      UsuariosResponse listado =  usuariosResponseFromJson(resp.body);
      return listado.usuarios;
    } catch (e) {
      return [];
    }
  }
}
