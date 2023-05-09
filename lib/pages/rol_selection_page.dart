import 'package:chat_app/models/tutorDTO.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/tutor_service.dart';

class RolSelectionPage extends StatefulWidget {
  const RolSelectionPage({Key? key}) : super(key: key);

  @override
  State<RolSelectionPage> createState() => _RolSelectionPageState();
}

class _RolSelectionPageState extends State<RolSelectionPage> {
  @override
  Widget build(BuildContext context) {
    /// Se obtiene el servicio de tutor
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu rol'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 150),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: const Text(
              'Seleccione el rol con el cual desea ingresar a la plataforma',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 200, maxHeight: 150),
                      child: ElevatedButton(
                        onPressed: () {
                          print("Estudiante");
                          Navigator.pushReplacementNamed(
                              context, 'StudentMenuPage');
                          // Lógica para el rol de estudiante
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.school, size: 50),
                            SizedBox(height: 10),
                            Text('Estudiante', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 200, maxHeight: 150),
                      child: ElevatedButton(
                        onPressed: () async {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, 'TutorMenuPage');
                          // Lógica para el rol de tutor
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.person, size: 50),
                            SizedBox(height: 10),
                            Text('Tutor', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
