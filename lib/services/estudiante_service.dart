import 'dart:convert';

import 'package:chat_app/models/solicitudTutoriaDto.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';
import '../models/tutorDTO.dart';
import '../models/tutoriaResponse.dart';
import 'auth_service.dart';

class EstudianteService {
  ///Metodo para consultar tutores por un query string
  /// [query] es el query string que se va a enviar en la petición
  Future<List<TutorDto>> getTutoresByQuery(String query) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get(
        Uri.parse('${Environment.coreBack}tutor?searchString=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw http.ClientException('Error al obtener los tutores');
      }

      final List<dynamic> tutoresJson = json.decode(response.body);
      final List<TutorDto> tutores =
          tutoresJson.map((json) => TutorDto.fromJson(json)).toList();
      return tutores;
    } catch (e) {
      throw Exception('Error al obtener los tutores: $e');
    }
  }

  ///Metodo para consultar un tutor por su id
  /// [id] es el id del tutor que se va a enviar en la petición
  Future<TutorDto> getTutorById(String id) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get(
        Uri.parse('${Environment.coreBack}tutor/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw http.ClientException('Error al obtener el tutor');
      }
      final Map<String, dynamic> tutorJson = json.decode(response.body);
      final TutorDto tutor = TutorDto.fromJson(tutorJson);
      return tutor;
    } catch (e) {
      throw Exception('Error al obtener el tutor: $e');
    }
  }

  /// Metodo para realizar una solicitud de tutoria
  /// [solicitudTutoriaDto] es el objeto que se va a enviar en la petición
  Future<void> solicitarTutoria(SolicitudTutoriaDto solicitudTutoriaDto) async {
    try {
      final token = await AuthService.getToken();
      final response = await http.post(
        Uri.parse('${Environment.coreBack}tutoria'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(solicitudTutoriaDto.toJson()),
      );
      if (response.statusCode != 201) {
        throw http.ClientException('Error al solicitar la tutoria');
      }
    } catch (e) {
      throw Exception('Error al solicitar la tutoria: $e');
    }
  }

  /// Metodo para obtener todas las solicitudes de tutorias pendientes de un estudiante
  /// [idEstudiante] es el id del estudiante que se va a enviar en la petición
  Future<List<tutoriaResponse>> getAllTutoringRequestsByStudent(
      String idEstudiante) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse(
            '${Environment.coreBack}tutoria/estudiante/$idEstudiante/pendientes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resp.statusCode != 200) {
        throw http.ClientException(
            'Error al obtener las solicitudes de tutorias');
      }

      final List<dynamic> solicitudesJson = json.decode(resp.body);
      final List<tutoriaResponse> solicitudes = solicitudesJson
          .map((json) => tutoriaResponse.fromJson(json))
          .toList();
      return solicitudes;
    } catch (e) {
      rethrow;
    }
  }

  /// Metodo para obtener todas las solicitudes de tutorias aceptadas de un estudiante
  /// [idEstudiante] es el id del estudiante que se va a enviar en la petición
  Future<List<tutoriaResponse>> getAllacceptedTutoringByStudent(
      String idEstudiante) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse(
            '${Environment.coreBack}tutoria/estudiante/$idEstudiante/activas'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resp.statusCode != 200) {
        throw http.ClientException(
            'Error al obtener las solicitudes de tutorias');
      }

      final List<dynamic> solicitudesJson = json.decode(resp.body);
      final List<tutoriaResponse> solicitudes = solicitudesJson
          .map((json) => tutoriaResponse.fromJson(json))
          .toList();
      return solicitudes;
    } catch (e) {
      rethrow;
    }
  }

  /// Metodo para obtener todoas las tutorias finalizadas de un estudiante
  /// [idEstudiante] es el id del estudiante que se va a enviar en la petición
  Future<List<tutoriaResponse>> getAllCompletedTutoringByStudent(
      String idEstudiante) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse(
            '${Environment.coreBack}tutoria/estudiante/$idEstudiante/finalizadas'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resp.statusCode != 200) {
        throw http.ClientException('Error al obtener las tutorias finalizadas');
      }

      final List<dynamic> solicitudesJson = json.decode(resp.body);
      final List<tutoriaResponse> solicitudes = solicitudesJson
          .map((json) => tutoriaResponse.fromJson(json))
          .toList();
      return solicitudes;
    } catch (e) {
      rethrow;
    }
  }
}
