import 'dart:async';
import 'dart:ui';

import 'package:chat_app/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'notification_servide.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  ServerStatus _serverStatus = ServerStatus.Connecting;

//http://10.0.2.2:3001
  Future<bool> connect() async {
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

    /// Retorna true si se conecto correctamente
    return _socket.connected;
  }

  void disconnect() {
    print('disconnect');
    _socket.disconnect();
  }

  ///Se suscribe a las notificaciones de un usuario
  ///[id] es el id del usuario
  ///[callback] es la funcion que se ejecuta cuando se recibe una notificacion
  Future<void> subscribeToNotifications(String id) async {
    await initializeService();
    _socket.on(
        'notifications:$id',
        (data) => {
              NotificationService.showNotificationStatic(),
              FlutterBackgroundService().invoke("mostrarNotificacion"),
            });
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    final log = preferences.getStringList('log') ?? <String>[];
    log.add(DateTime.now().toIso8601String());
    await preferences.setStringList('log', log);

    return true;
  }

  static onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    service.on('mostrarNotificacion').listen((event) {});
  }

  ServerStatus get serverStatus => _serverStatus;
}
