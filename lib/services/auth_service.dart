import 'dart:convert';

import 'package:chat_app/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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

  static Future<void> deleteUsuario() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'usuario');
  }

  /// Metodo para obtener el usuario
  static Future<Usuario?> getUsuario() async {
    const storage = FlutterSecureStorage();
    final usuario = await storage.read(key: 'usuario');
    if (usuario != null) {
      return Usuario.fromJson(jsonDecode(usuario));
    }
    return null;
  }

  /// Metodo estatico para agregar el rol de tutor al usuario
  static Future<void> setTutorRol() async {
    const storage = FlutterSecureStorage();
    final usuario = await storage.read(key: 'usuario');
    if (usuario != null) {
      final user = Usuario.fromJson(jsonDecode(usuario));
      user.roles.add('tutor');
      await storage.write(key: 'usuario', value: jsonEncode(user.toJson()));
    }
  }

  /// This is a method that will be used to login a user.
  /// [email] is the email of the user.
  /// [password] is the password of the user.
  Future<LoginResponse> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};
    try {
      final resp = await http.post(
        Uri.parse('${Environment.authBack}/login'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      final loginResponse = loginResponseFromJson(resp.body);
      if (loginResponse.ok) {
        usuario = Usuario(
            id: loginResponse.id!,
            email: loginResponse.email!,
            nombre: loginResponse.email!,
            online: true,
            token: loginResponse.token!,
            roles: loginResponse.roles!);
        _storage.write(key: 'usuario', value: jsonEncode(usuario.toJson()));
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
  Future<RegisterResponse> register(
      String nombre, String email, String password) async {
    autenticando = true;
    final data = {'fullName': nombre, 'email': email, 'password': password};
    try {
      final resp = await http.post(
        Uri.parse('${Environment.authBack}/register'),
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
      Uri.parse('${Environment.authBack}/check-auth-status'),
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

  /// This is a method that will be used to logout a user.
  Future logout() async {
    await _storage.delete(key: 'usuario');
    return await _storage.delete(key: 'token');
  }
}
