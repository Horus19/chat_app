import 'dart:convert';

class SolicitudTutoriaDto {
  String? materiaId;
  String? estudianteId;
  String? tutorId;
  DateTime? fechaTutoria;
  String? descripcion;
  int? valorOferta;

  SolicitudTutoriaDto({
    this.materiaId,
    this.estudianteId,
    this.tutorId,
    this.fechaTutoria,
    this.descripcion,
    this.valorOferta,
  });

  SolicitudTutoriaDto copyWith({
    String? materiaId,
    String? estudianteId,
    String? tutorId,
    DateTime? fechaTutoria,
    String? descripcion,
    int? valorOferta,
  }) =>
      SolicitudTutoriaDto(
        materiaId: materiaId ?? this.materiaId,
        estudianteId: estudianteId ?? this.estudianteId,
        tutorId: tutorId ?? this.tutorId,
        fechaTutoria: fechaTutoria ?? this.fechaTutoria,
        descripcion: descripcion ?? this.descripcion,
        valorOferta: valorOferta ?? this.valorOferta,
      );

  factory SolicitudTutoriaDto.fromRawJson(String str) =>
      SolicitudTutoriaDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SolicitudTutoriaDto.fromJson(Map<String, dynamic> json) =>
      SolicitudTutoriaDto(
        materiaId: json["materiaId"],
        estudianteId: json["estudianteId"],
        tutorId: json["tutorId"],
        fechaTutoria: json["fechaTutoria"] == null
            ? null
            : DateTime.parse(json["fechaTutoria"]),
        descripcion: json["descripcion"],
        valorOferta: json["valorOferta"],
      );

  Map<String, dynamic> toJson() => {
        "materiaId": materiaId,
        "estudianteId": estudianteId,
        "tutorId": tutorId,
        "fechaTutoria": fechaTutoria?.toIso8601String(),
        "descripcion": descripcion,
        "valorOferta": valorOferta,
      };
}
