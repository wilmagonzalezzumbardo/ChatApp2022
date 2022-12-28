import 'dart:convert';

import 'package:fl_12_chatapp/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globals/environment.dart';
import '../models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  //usuario
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //getters del token de forma etatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> borrarToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final data = {'email': email, 'password': password};
    var da = '${Environment.apiUrl}' + '/api/login/buscalogin';
    var url = Uri.https('${Environment.apiUrl}', '/api/login/buscalogin');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token!);
      return true;
    } else {
      return false;
    }
  }

  Future nuevo(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
      'passwordConfirmation': password
    };
    var da = '${Environment.apiUrl}' + '/api/login/new';
    var url = Uri.https('${Environment.apiUrl}', '/api/login/new');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token!);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<bool> isLoggedIn() async {
    final token_ = await this._storage.read(key: 'token');
    var url = Uri.https('${Environment.apiUrl}', '/api/login/rutaTokenRenew');
    if (token_ == null)
    {
      return false;
    }
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token_!});
    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token!);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
