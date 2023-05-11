import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/tutor_service.dart';

class StudentMenuPage extends StatefulWidget {
  const StudentMenuPage({Key? key}) : super(key: key);

  @override
  State<StudentMenuPage> createState() => _StudentMenuPageState();
}

class _StudentMenuPageState extends State<StudentMenuPage> {
  final TutorService _tutorService = TutorService();
  late bool _isTutor = false;
  late Usuario _usuario;
  @override
  void initState() {
    super.initState();
    AuthService.getUsuario().then((Usuario? usuario) {
      setState(() {
        _usuario = usuario!;
        _isTutor = usuario.roles.contains('tutor');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú estudiante'),
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
            'Buscar tutor',
            Icons.search,
            () {
              Navigator.pushReplacementNamed(context, 'TutorSearchScreen');
              // Lógica para la opción "Buscar tutor"
            },
          ),
          _buildMenuItem(
            context,
            'Solicitudes de tutorías',
            Icons.pending,
            () {
              // Lógica para la opción "Solicitudes de tutorías"
              Navigator.pushReplacementNamed(
                  context, 'SolicitudTutoriasListStudent',
                  arguments: _usuario.id);
            },
          ),
          _buildMenuItem(
            context,
            'Tutorías activas',
            Icons.pending_actions,
            () {
              // Lógica para la opción "Tutorías activas"
              Navigator.pushReplacementNamed(
                  context, 'TutoriasActivasEstudiante',
                  arguments: _usuario.id);
            },
          ),
          _buildMenuItem(
            context,
            'Historial de tutorías',
            Icons.history,
            () {
              // Lógica para la opción "Historial de tutorías"
              Navigator.pushReplacementNamed(
                  context, 'TutoriasFinalizadasEstudiante',
                  arguments: _usuario.id);
            },
          ),
          _buildMenuItem(
            context,
            _isTutor ? "Ir a perfil de tutor" : 'Activar perfil de tutor',
            _isTutor ? Icons.person : Icons.person_add,
            () async {
              if (_isTutor) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'TutorMenuPage');
              } else {
                Navigator.pushReplacementNamed(
                    context, 'ActivateTutorProfileScreen');
              }
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
