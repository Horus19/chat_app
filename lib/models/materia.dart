import 'dart:convert';

class Materia {
  String? id;
  int? codigo;
  String? nombre;
  String? descripcion;
  bool? activo;
  String? codigoNombre;

  Materia({
    this.id,
    this.codigo,
    this.nombre,
    this.descripcion,
    this.activo,
    this.codigoNombre,
  });

  Materia copyWith({
    String? id,
    int? codigo,
    String? nombre,
    String? descripcion,
    bool? activo,
    String? codigoNombre,
  }) =>
      Materia(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        activo: activo ?? this.activo,
        codigoNombre: codigoNombre ?? this.codigoNombre,
      );

  factory Materia.fromRawJson(String str) => Materia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Materia.fromJson(Map<String, dynamic> json) => Materia(
    id: json["id"],
    codigo: json["codigo"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    activo: json["activo"],
    codigoNombre: json["codigoNombre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "codigo": codigo,
    "nombre": nombre,
    "descripcion": descripcion,
    "activo": activo,
    "codigoNombre": codigoNombre,
  };

  static List<Materia> materiaFromJson(String str) =>
      List<Materia>.from(json.decode(str).map((x) => Materia.fromJson(x)));

}
