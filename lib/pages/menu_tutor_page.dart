import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/usuario.dart';
import '../services/auth_service.dart';
import '../services/notification_servide.dart';
import '../services/socket_service.dart';
import '../services/tutor_service.dart';

class TutorMenuPage extends StatefulWidget {
  const TutorMenuPage({Key? key}) : super(key: key);

  @override
  State<TutorMenuPage> createState() => _TutorMenuPageState();
}

class _TutorMenuPageState extends State<TutorMenuPage> {
  late SocketService socketService;
  late NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    notificationService =
        Provider.of<NotificationService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    AuthService.getUsuario().then((Usuario? usuario) {
      socketService.socket.on('notifications:${usuario!.id}', (data) {
        print('Notificación recibida');
        notificationService.showNotification();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Inicializar el servicio de tutor
    final _tutorService = Provider.of<TutorService>(context);

    final socketService = Provider.of<SocketService>(context);
    final notificationService =
        Provider.of<NotificationService>(context, listen: false);
    // Escucha el evento de notificación del socket
    socketService.socket.on('notification', (data) {
      // Muestra la notificación cuando se recibe una notificación del servidor
      notificationService.showNotification();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú tutor'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        childAspectRatio: 1.5,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _buildMenuItem(
            context,
            'Gestionar perfil',
            Icons.manage_accounts,
            () {
              // Lógica para la opción "Gestionar perfil"
              Navigator.pushNamed(context, 'TutorProfileScreen',
                  arguments: _tutorService.tutor);
            },
          ),
          _buildMenuItem(
            context,
            'Solicitudes de tutorías',
            Icons.pending,
            () {
              Navigator.pushNamed(context, 'SolicitudTutoriasList',
                  arguments: _tutorService.tutor.id);
            },
          ),
          _buildMenuItem(
            context,
            'Tutorías activas',
            Icons.pending_actions,
            () {
              // Lógica para la opción "Tutorías activas"
              Navigator.pushNamed(context, 'TutoriasActivasList',
                  arguments: _tutorService.tutor.id);
            },
          ),
          _buildMenuItem(
            context,
            'Historial de tutorías',
            Icons.history,
            () {
              // Lógica para la opción "Historial de tutorías"
              Navigator.pushNamed(context, 'TutoriasFinalizadasList',
                  arguments: _tutorService.tutor.id);
            },
          ),
          _buildMenuItem(
            context,
            'Ir a perfil de estudiante',
            Icons.person_pin,
            () {
              Navigator.pushNamed(context, 'StudentMenuPage');
            },
          ),
          _buildMenuItem(
            context,
            'Salir',
            Icons.exit_to_app,
            () {
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, 'Login');
              // Lógica para la opción "Salir"
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
