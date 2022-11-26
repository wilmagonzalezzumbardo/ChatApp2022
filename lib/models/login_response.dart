import 'dart:convert';

import 'package:fl_12_chatapp/models/usuario.dart';

class LoginResponse {
    LoginResponse({
        required this.ok,
        required this.msg,
        required this.usuario,
        this.token,
    });

    bool ok;
    String msg;
    Usuario  usuario;
    String? token;

    factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        usuario: Usuario.fromMap(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "usuario": usuario.toMap(),
        "token": token,
    };
}

