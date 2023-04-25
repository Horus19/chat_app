import 'package:flutter/material.dart';

class TutorMenuPage extends StatelessWidget {
  const TutorMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Solicitudes de tutorías',
            Icons.pending,
            () {
              // Lógica para la opción "Solicitudes de tutorías"
            },
          ),
          _buildMenuItem(
            context,
            'Ir a perfil de estudiante',
            Icons.person_pin,
            () {
              // Lógica para la opción "Ir a perfil de estudiante"
            },
          ),
          _buildMenuItem(
            context,
            'Salir',
            Icons.exit_to_app,
            () {
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
