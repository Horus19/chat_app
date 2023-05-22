// To parse this JSON data, do
//
//     final cancelarTutoriaRequest = cancelarTutoriaRequestFromJson(jsonString);

import 'dart:convert';

class CancelarTutoriaRequest {
  String? tutoriaId;
  String? descripcion;

  CancelarTutoriaRequest({
    this.tutoriaId,
    this.descripcion,
  });

  CancelarTutoriaRequest copyWith({
    String? tutoriaId,
    String? descripcion,
  }) =>
      CancelarTutoriaRequest(
        tutoriaId: tutoriaId ?? this.tutoriaId,
        descripcion: descripcion ?? this.descripcion,
      );

  factory CancelarTutoriaRequest.fromRawJson(String str) =>
      CancelarTutoriaRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelarTutoriaRequest.fromJson(Map<String, dynamic> json) =>
      CancelarTutoriaRequest(
        tutoriaId: json["tutoriaId"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "tutoriaId": tutoriaId,
        "descripcion": descripcion,
      };
}
