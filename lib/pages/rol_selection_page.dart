import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

class RolSelectionPage extends StatefulWidget {
  const RolSelectionPage({Key? key}) : super(key: key);

  @override
  State<RolSelectionPage> createState() => _RolSelectionPageState();
}

class _RolSelectionPageState extends State<RolSelectionPage> {
  late SocketService socketService;

  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect();
    socketService.socket
        .on('notifications:bb2eec1a-1f9a-43ee-8c71-e4e8bde1193a', (_) {
      print('Notificación recibida');
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () async {
                          Navigator.pushNamed(context, 'StudentMenuPage');
                          // Lógica para el rol de estudiante
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                          Navigator.pushNamed(context, 'TutorMenuPage');
                          // Lógica para el rol de tutor
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
