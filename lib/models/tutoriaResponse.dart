// To parse this JSON data, do
//
//     final solicitudTutoriaResponse = solicitudTutoriaResponseFromJson(jsonString);

import 'dart:convert';

class tutoriaResponse {
  String? id;
  DateTime? fechaSolicitud;
  DateTime? fechaTutoria;
  String? descripcion;
  String? valorOferta;
  String? estudianteId;
  String? estudiantenombre;
  String? tutorId;
  String? tutorNombre;
  String? materiaId;
  String? materiaNombre;

  tutoriaResponse({
    this.id,
    this.fechaSolicitud,
    this.fechaTutoria,
    this.descripcion,
    this.valorOferta,
    this.estudianteId,
    this.estudiantenombre,
    this.tutorId,
    this.tutorNombre,
    this.materiaId,
    this.materiaNombre,
  });

  tutoriaResponse copyWith({
    String? id,
    DateTime? fechaSolicitud,
    DateTime? fechaTutoria,
    String? descripcion,
    String? valorOferta,
    String? estudianteId,
    String? estudiantenombre,
    String? tutorId,
    String? tutorNombre,
    String? materiaId,
    String? materiaNombre,
  }) =>
      tutoriaResponse(
        id: id ?? this.id,
        fechaSolicitud: fechaSolicitud ?? this.fechaSolicitud,
        fechaTutoria: fechaTutoria ?? this.fechaTutoria,
        descripcion: descripcion ?? this.descripcion,
        valorOferta: valorOferta ?? this.valorOferta,
        estudianteId: estudianteId ?? this.estudianteId,
        estudiantenombre: estudiantenombre ?? this.estudiantenombre,
        tutorId: tutorId ?? this.tutorId,
        tutorNombre: tutorNombre ?? this.tutorNombre,
        materiaId: materiaId ?? this.materiaId,
        materiaNombre: materiaNombre ?? this.materiaNombre,
      );

  factory tutoriaResponse.fromRawJson(String str) =>
      tutoriaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory tutoriaResponse.fromJson(Map<String, dynamic> json) =>
      tutoriaResponse(
        id: json["id"],
        fechaSolicitud: json["fechaSolicitud"] == null
            ? null
            : DateTime.parse(json["fechaSolicitud"]),
        fechaTutoria: json["fechaTutoria"] == null
            ? null
            : DateTime.parse(json["fechaTutoria"]),
        descripcion: json["descripcion"],
        valorOferta: json["valorOferta"],
        estudianteId: json["estudianteId"],
        estudiantenombre: json["estudiantenombre"],
        tutorId: json["tutorId"],
        tutorNombre: json["tutorNombre"],
        materiaId: json["materiaId"],
        materiaNombre: json["materiaNombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fechaSolicitud": fechaSolicitud?.toIso8601String(),
        "fechaTutoria": fechaTutoria?.toIso8601String(),
        "descripcion": descripcion,
        "valorOferta": valorOferta,
        "estudianteId": estudianteId,
        "estudiantenombre": estudiantenombre,
        "tutorId": tutorId,
        "tutorNombre": tutorNombre,
        "materiaId": materiaId,
        "materiaNombre": materiaNombre,
      };
}
