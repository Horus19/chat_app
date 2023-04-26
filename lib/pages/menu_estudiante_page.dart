import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class StudentMenuPage extends StatelessWidget {
  const StudentMenuPage({Key? key}) : super(key: key);

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
            'Tutorías activas',
            Icons.pending_actions,
            () {
              // Lógica para la opción "Tutorías activas"
            },
          ),
          _buildMenuItem(
            context,
            'Historial de tutorías',
            Icons.history,
            () {
              // Lógica para la opción "Historial de tutorías"
            },
          ),
          _buildMenuItem(
            context,
            'Activar perfil de tutor',
            Icons.person_add,
            () {
              // Lógica para la opción "Activar perfil de tutor"
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
