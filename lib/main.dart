import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/materia_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize the locale data for 'es'
  await initializeDateFormatting('es');

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
