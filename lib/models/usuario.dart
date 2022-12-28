import 'dart:convert';

class Usuario {
    Usuario({
        required this.nombre,
        this.password,
        required this.email,
        required this.online,
        required this.uid,
    });

    String nombre;
    String? password;
    String email;
    bool online;
    String uid;


    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        password: json["password"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "password": password,
        "email": email,
        "online": online,
        "uid": uid,
      };

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        password: json["password"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "password": password,
        "email": email,
        "online": online,
        "uid": uid,
    };

}
   