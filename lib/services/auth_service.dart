import 'dart:convert';

import 'package:chat_app/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/login_response.dart';
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

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
