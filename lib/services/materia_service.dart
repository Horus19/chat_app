import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';
import '../models/materia.dart';
import 'auth_service.dart';

class MateriaService with ChangeNotifier {


  /// Metodo para obtener un listado de materias por una peticion http

  Future<List<Materia>> getMaterias() async {
    try {
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}materia'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $AuthService.getToken()',
        },
      );


      final List<dynamic> materiasJson = json.decode(resp.body);
      final List<Materia> materias = materiasJson.map((json) => Materia.fromJson(json)).toList();
      return materias;
    } catch (e) {
      print('Error al obtener las materias: $e');
      rethrow;
    }
  }

}
