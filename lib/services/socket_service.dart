import 'package:chat_app/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  ServerStatus _serverStatus = ServerStatus.Connecting;

//http://10.0.2.2:3001
  void connect() async {
    final token = await AuthService.getToken();
    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    _socket.connect();

    _socket.onConnect((_) async {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('event', (data) => print(data));
    _socket.onDisconnect((_) => {
          _serverStatus = ServerStatus.Offline,
          notifyListeners(),
        });
  }

  void disconnect() {
    print('disconnect');
    _socket.disconnect();
  }

  ServerStatus get serverStatus => _serverStatus;
}
