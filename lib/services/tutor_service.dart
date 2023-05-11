import 'dart:convert';

import 'package:chat_app/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/CrearPerfilTutorDto.dart';
import '../models/tutorDTO.dart';
import '../models/tutoriaResponse.dart';
import 'auth_service.dart';

class TutorService with ChangeNotifier {
  late TutorDto tutor;

  final _storage = const FlutterSecureStorage();

  ///TODO: Try catch
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
    if (response.statusCode != 201) {
      throw Exception('Error al crear perfil de tutor');
    }
  }

  ///Metodo para obtener las solicitudes de tutorias por id de tutor
  ///[idTutor] es el id del tutor
  Future<List<tutoriaResponse>> getAllTutoringRequestsByTutor(
      String idTutor) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}tutoria/tutor/$idTutor/pendientes'),
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

  ///Metodo para aceptar una solicitud de tutoria
  ///[idSolicitud] es el id de la solicitud de tutoria
  Future<void> aceptarSolicitudTutoria(String idSolicitud) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse(
            '${Environment.coreBack}tutoria/aceptar?idTutoria=$idSolicitud'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (resp.statusCode != 200) {
        throw http.ClientException('Error al aceptar la solicitud de tutoria');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Metodo para rechazar una solicitud de tutoria
  ///[idSolicitud] es el id de la solicitud de tutoria
  ///[motivo] es el motivo por el cual se rechaza la solicitud de tutoria
  Future<void> rechazarSolicitudTutoria(String idTutoria, String motivo) async {
    try {
      final response = await http.post(
        Uri.parse('${Environment.coreBack}tutoria/rechazar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $AuthService.getToken()',
        },
        body: json.encode({'tutoriaId': idTutoria, 'descripcion': motivo}),
      );
      if (response.statusCode != 201) {
        throw Exception('Error al rechazar la solicitud de tutoria');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Metodo para obtener las tutorias aceptadas por id de tutor
  ///[idTutor] es el id del tutor
  Future<List<tutoriaResponse>> getAllTutoringByTutor(String idTutor) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}tutoria/tutor/$idTutor/activas'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resp.statusCode != 200) {
        throw http.ClientException('Error al obtener las tutorias activas');
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

  ///Metodo para obtener el perfil de tutor por id del usuario
  ///[idUsuario] es el id del usuario del cual se quiere obtener el perfil de tutor
  Future<TutorDto> getTutorByUserId(String idUsuario) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}tutor/usuario/$idUsuario'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (resp.statusCode != 200) {
        throw http.ClientException('Error al aceptar la solicitud de tutoria');
      }
      final tutorJson = json.decode(resp.body);
      final TutorDto tutor = TutorDto.fromJson(tutorJson);
      _storage.write(key: 'tutor', value: jsonEncode(tutor.toJson()));
      this.tutor = tutor;
      return tutor;
    } catch (e) {
      rethrow;
    }
  }

  /// Metodo que edita un Tutor
  /// [TutorDto] json con datos a editar

  Future<void> update(tutor) async {
    try {
      final token = await AuthService.getToken();
      final updatedTutor = {
        'id': tutor.id,
        'descripcion': tutor.descripcion,
        'materias': tutor.materias,
        'costo': tutor.costo,
      };
      await http.patch(Uri.parse('${Environment.coreBack}tutor'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(updatedTutor));
      this.tutor = tutor;
      _storage.write(key: 'tutor', value: jsonEncode(tutor.toJson()));
      // if (resp.statusCode != 200) {
      //   throw http.ClientException('Error al obtener las tutorias activas');
      // }
    } catch (e) {
      rethrow;
    }
  }

  /// Metodo para finalizar una tutoria
  /// [idTutoria] id de la tutoria a finalizar
  Future<void> finalizarTutoria(String idTutoria) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}tutoria/finalizar/$idTutoria'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (resp.statusCode != 200) {
        throw http.ClientException('Error al finalizar la tutoria');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Metodo para obtener las tutorias finalizadas por id de tutor
  ///[idTutor] es el id del tutor
  Future<List<tutoriaResponse>> getAllCompletedTutoringByTutor(
      String idTutor) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.coreBack}tutoria/tutor/$idTutor/finalizadas'),
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

  /// Metodo estatico que obtiene el perfil de tutor del storage
  /// Retorna un objeto de tipo [TutorDto]
  static Future<TutorDto> getTutorFromStorage() async {
    const storage = FlutterSecureStorage();
    final tutorJson = await storage.read(key: 'tutor');
    final TutorDto tutor = TutorDto.fromJson(jsonDecode(tutorJson!));
    return tutor;
  }
}
