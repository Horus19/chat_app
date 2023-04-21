import 'dart:convert';

import 'package:chat_app/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/login_response.dart';
import '../models/register_response.dart';
import '../models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;

  final _storage = const FlutterSecureStorage();
  bool _autenticando = false;

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  /// Getters del token

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  /// This is a method that will be used to login a user.
  /// [email] is the email of the user.
  /// [password] is the password of the user.
  Future<LoginResponse> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};
    try {
      final resp = await http.post(
        Uri.parse('${Environment.baseUrl}/auth/login'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      final loginResponse = loginResponseFromJson(resp.body);
      if (loginResponse.ok) {
        //TODO: agregar el nombre del usuario en el backend
        usuario = Usuario(
            id: loginResponse.id!,
            email: loginResponse.email!,
            nombre: loginResponse.email!,
            online: true,
            token: loginResponse.token!);
        await _guardarToken(loginResponse.token!);
      }
      autenticando = false;
      notifyListeners();
      return loginResponse;
    } catch (e) {
      autenticando = false;
      notifyListeners();
      throw Exception('Error en la función login: $e');
    }
  }

  /// This is a method that will be used to register a user.
  /// [nombre] is the name of the user.
  /// [email] is the email of the user.
  /// [password] is the password of the user.
  /// [password2] is the password confirmation of the user.
  Future<RegisterResponse> register(
      String nombre, String email, String password, String password2) async {
    autenticando = true;
    //TODO: implementar envio de confirmacion de contraseña en el backend
    final data = {'fullName': nombre, 'email': email, 'password': password};
    try {
      final resp = await http.post(
        Uri.parse('${Environment.baseUrl}/auth/register'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      final registerResponse = registerResponseFromJson(resp.body);
      autenticando = false;
      notifyListeners();
      return registerResponse;
    } catch (e) {
      autenticando = false;
      notifyListeners();
      throw Exception('Error en la función register: $e');
    }
  }

  /// This is a method that will be used to check if a user is logged in.
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    if (token == null) {
      return false;
    }
    final resp = await http.get(
      Uri.parse('${Environment.baseUrl}/auth/check-auth-status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (resp.statusCode == 200) {
      _guardarToken(jsonDecode(resp.body)['token']);
      return true;
    }
    logout();
    return false;
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
