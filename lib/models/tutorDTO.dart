// To parse this JSON data, do
//
//     final tutorDto = tutorDtoFromJson(jsonString);

import 'dart:convert';

class TutorDto {
  String? id;
  String? nombre;
  String? descripcion;
  List<MateriaDTO>? materias;
  String? costo;
  String? calificacion;

  TutorDto({
    this.id,
    this.nombre,
    this.descripcion,
    this.materias,
    this.costo,
    this.calificacion,
  });

  TutorDto copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    List<MateriaDTO>? materias,
    String? costo,
    String? calificacion,
  }) =>
      TutorDto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        materias: materias ?? this.materias,
        costo: costo ?? this.costo,
        calificacion: calificacion ?? this.calificacion,
      );

  factory TutorDto.fromRawJson(String str) =>
      TutorDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TutorDto.fromJson(Map<String, dynamic> json) => TutorDto(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        materias: json["materias"] == null
            ? []
            : List<MateriaDTO>.from(
                json["materias"]!.map((x) => MateriaDTO.fromJson(x))),
        costo: json["costo"],
        calificacion: json["calificacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "materias": materias == null
            ? []
            : List<dynamic>.from(materias!.map((x) => x.toJson())),
        "costo": costo,
        "calificacion": calificacion,
      };
}

class MateriaDTO {
  String? id;
  String? nombre;

  MateriaDTO({
    this.id,
    this.nombre,
  });

  MateriaDTO copyWith({
    String? id,
    String? nombre,
  }) =>
      MateriaDTO(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );

  factory MateriaDTO.fromRawJson(String str) =>
      MateriaDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MateriaDTO.fromJson(Map<String, dynamic> json) => MateriaDTO(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
