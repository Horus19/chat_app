// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

class Message {
  String? uuid;
  String? mensaje;

  Message({
    this.uuid,
    this.mensaje,
  });

  Message copyWith({
    String? uuid,
    String? mensaje,
  }) =>
      Message(
        uuid: uuid ?? this.uuid,
        mensaje: mensaje ?? this.mensaje,
      );

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        uuid: json["uuid"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "mensaje": mensaje,
      };
}
