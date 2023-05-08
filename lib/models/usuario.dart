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
    required this.roles,
  });

  String id;
  String email;
  String token;
  bool online;
  String nombre;
  List<String> roles = [];

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        email: json["email"],
        token: json["token"],
        online: json["online"],
        nombre: json["nombre"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "online": online,
        "nombre": nombre,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}
