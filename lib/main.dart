import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/materia_service.dart';
import 'package:chat_app/services/notification_servide.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/tutor_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

// Inicializa el objeto FlutterLocalNotificationsPlugin
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Configura la plataforma predeterminada para las notificaciones
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the locale data for 'es'
  await initializeDateFormatting('es');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // Run your app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MateriaService()),
        ChangeNotifierProvider(create: (_) => TutorService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(
            create: (_) =>
                NotificationService(flutterLocalNotificationsPlugin)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TUTUIS App',
        initialRoute: 'LoadingPage',
        routes: appRoutes,
      ),
    );
  }
}
