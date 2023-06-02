import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService with ChangeNotifier {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginStatic =
      FlutterLocalNotificationsPlugin();

  NotificationService(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPluginStatic = flutterLocalNotificationsPlugin;
  }

  /// Atributo de id de notificacion
  /// Se utiliza para identificar la notificacion
  int _idNotification = 0;

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPluginStatic.show(
      _idNotification, // ID de la notificación
      'Tutoria rechazada',
      'Detalle del rechazo... abcdefghijklmnopqrstuvwxyz',
      platformChannelSpecifics,
    );

    _idNotification++;
  }

  ///Metodo estatico que muestra una notificacion
  static Future<void> showNotificationStatic() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPluginStatic.show(
      0, // ID de la notificación
      'Tutoria rechazada',
      'Detalle del rechazo... abcdefghijklmnopqrstuvwxyz',
      platformChannelSpecifics,
    );
  }
}
