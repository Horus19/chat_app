import 'dart:convert';

import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late String idUsuarioPara;

  /// Obtiene todos los mensajes de un chat
  /// [idUsuario] es el id del usuario para el que se obtienen los mensajes
  Future<List<Message>> getChat(String idUsuario) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.socketUrl}api/messages/$idUsuario'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (resp.statusCode != 200) {
        return [];
      }
      final List<dynamic> messagesJson = json.decode(resp.body);
      final List<Message> messages =
          messagesJson.map((json) => Message.fromJson(json)).toList();
      return messages;
    } catch (e) {
      return [];
    }
  }
}
