// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.id,
    required this.email,
    required this.token,
    required this.online,
    required this.nombre,
  });

  String id;
  String email;
  String token;
  bool online;
  String nombre;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        email: json["email"],
        token: json["token"],
        online: json["online"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "online": online,
        "nombre": nombre,
      };
}
