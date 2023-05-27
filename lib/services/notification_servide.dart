import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService with ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

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

    await flutterLocalNotificationsPlugin.show(
      _idNotification, // ID de la notificación
      'Tutoria rechazada',
      'Detalle del rechazo... abcdefghijklmnopqrstuvwxyz',
      platformChannelSpecifics,
    );

    _idNotification++;
  }

  /// Muestra una notificación con un mensaje personalizado
  ///
}
