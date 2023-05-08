import 'dart:convert';

import 'package:chat_app/environment.dart';
import 'package:http/http.dart' as http;

import '../models/CrearPerfilTutorDto.dart';
import 'auth_service.dart';

class TutorService {
  ///Metodo para crear perfil de tutor por una peticion http
  ///[CrearPerfilTutorDto] es el objeto que se envia en la peticion http
  Future<void> crearPerfilTutor(CrearPerfilTutorDto crearPerfilTutor) async {
    final response = await http.post(
      Uri.parse('${Environment.coreBack}tutor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $AuthService.getToken()',
      },
      body: json.encode(crearPerfilTutor.toJson()),
    );
    print(response.body);
    if (response.statusCode == 201) {
      print('Perfil de tutor creado');
    } else {
      throw Exception('Error al crear el perfil de tutor');
    }
  }
}
