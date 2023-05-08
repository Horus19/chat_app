// To parse this JSON data, do
//
//     final crearPerfilTutorDto = crearPerfilTutorDtoFromJson(jsonString);

import 'dart:convert';

class CrearPerfilTutorDto {
  String? usuarioId;
  List<String>? materiasIds;
  String? descripcion;
  int? costoPorHora;

  CrearPerfilTutorDto({
    this.usuarioId,
    this.materiasIds,
    this.descripcion,
    this.costoPorHora,
  });

  CrearPerfilTutorDto copyWith({
    String? usuarioId,
    List<String>? materiasIds,
    String? descripcion,
    int? costoPorHora,
  }) =>
      CrearPerfilTutorDto(
        usuarioId: usuarioId ?? this.usuarioId,
        materiasIds: materiasIds ?? this.materiasIds,
        descripcion: descripcion ?? this.descripcion,
        costoPorHora: costoPorHora ?? this.costoPorHora,
      );

  factory CrearPerfilTutorDto.fromRawJson(String str) => CrearPerfilTutorDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CrearPerfilTutorDto.fromJson(Map<String, dynamic> json) => CrearPerfilTutorDto(
    usuarioId: json["usuarioId"],
    materiasIds: json["materiasIds"] == null ? [] : List<String>.from(json["materiasIds"]!.map((x) => x)),
    descripcion: json["descripcion"],
    costoPorHora: json["costoPorHora"],
  );

  Map<String, dynamic> toJson() => {
    "usuarioId": usuarioId,
    "materiasIds": materiasIds == null ? [] : List<dynamic>.from(materiasIds!.map((x) => x)),
    "descripcion": descripcion,
    "costoPorHora": costoPorHora,
  };
}
