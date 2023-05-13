// To parse this JSON data, do
//
//     final reviewRequest = reviewRequestFromJson(jsonString);

import 'dart:convert';

class ReviewRequest {
  int? calificacion;
  String? comentario;
  String? tutoria;
  String? estudiante;

  ReviewRequest({
    this.calificacion,
    this.comentario,
    this.tutoria,
    this.estudiante,
  });

  ReviewRequest copyWith({
    int? calificacion,
    String? comentario,
    String? tutoria,
    String? estudiante,
  }) =>
      ReviewRequest(
        calificacion: calificacion ?? this.calificacion,
        comentario: comentario ?? this.comentario,
        tutoria: tutoria ?? this.tutoria,
        estudiante: estudiante ?? this.estudiante,
      );

  factory ReviewRequest.fromRawJson(String str) =>
      ReviewRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewRequest.fromJson(Map<String, dynamic> json) => ReviewRequest(
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        tutoria: json["tutoria"],
        estudiante: json["estudiante"],
      );

  Map<String, dynamic> toJson() => {
        "calificacion": calificacion,
        "comentario": comentario,
        "tutoria": tutoria,
        "estudiante": estudiante,
      };
}
