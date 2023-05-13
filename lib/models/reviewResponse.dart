// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

class ReviewResponse {
  String? id;
  int? calificacion;
  String? comentario;
  String? tutoria;
  String? estudiante;

  ReviewResponse({
    this.id,
    this.calificacion,
    this.comentario,
    this.tutoria,
    this.estudiante,
  });

  ReviewResponse copyWith({
    String? id,
    int? calificacion,
    String? comentario,
    String? tutoria,
    String? estudiante,
  }) =>
      ReviewResponse(
        id: id ?? this.id,
        calificacion: calificacion ?? this.calificacion,
        comentario: comentario ?? this.comentario,
        tutoria: tutoria ?? this.tutoria,
        estudiante: estudiante ?? this.estudiante,
      );

  factory ReviewResponse.fromRawJson(String str) =>
      ReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        id: json["id"],
        calificacion: json["calificacion"],
        comentario: json["comentario"],
        tutoria: json["tutoria"],
        estudiante: json["estudiante"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "calificacion": calificacion,
        "comentario": comentario,
        "tutoria": tutoria,
        "estudiante": estudiante,
      };
}
