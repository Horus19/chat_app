import 'package:chat_app/models/CancelarTutoriaRequest.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/tutor_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/tutoriaResponse.dart';
import '../../models/userByTutorID.dart';
import '../../services/estudiante_service.dart';

class TutoriaAceptadaEstudiante extends StatefulWidget {
  const TutoriaAceptadaEstudiante({super.key});

  @override
  State<TutoriaAceptadaEstudiante> createState() =>
      _TutoriaAceptadaEstudianteState();
}

class _TutoriaAceptadaEstudianteState extends State<TutoriaAceptadaEstudiante> {
  late tutoriaResponse tutoria;

  bool isFinishable = false;

  bool isCancellable = false;

  late UserByTutorId usuarioTutor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tutoria = ModalRoute.of(context)!.settings.arguments as tutoriaResponse;
    setState(() {
      /// Es finalizable si la fecha de la tutoria es anterior a la fecha actual
      isFinishable = tutoria.fechaTutoria != null &&
          DateTime.now().isAfter(tutoria.fechaTutoria!);

      /// Es cancelable si la fecha de la tutoria es nula o si faltan 24 horas o más para la fecha de la tutoria
      isCancellable = tutoria.fechaTutoria == null ||
          DateTime.now().isBefore(tutoria.fechaTutoria!.subtract(
            const Duration(hours: 24),
          ));
      final tutorService = Provider.of<TutorService>(context, listen: false);

      tutorService.getUserByTutor(tutoria.tutorId!).then((value) => {
            usuarioTutor = value,
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la tutoría - estudiante'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descripción:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tutoria.descripcion!,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tutor:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tutoria.tutorNombre!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fecha de tutoría:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tutoria.fechaTutoria != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(tutoria.fechaTutoria!)
                    : 'No definida',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Valor de la oferta:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${tutoria.valorOferta}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final chatService =
                          Provider.of<ChatService>(context, listen: false);
                      chatService.idUsuarioPara = usuarioTutor.id!;
                      Navigator.pushNamed(context, 'Chat');
                    },
                    child: const Text('Ir al chat'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _cancelarTutoria(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isCancellable ? Colors.red : Colors.grey),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Muestra un dialogo de confirmación para cancelar la tutoria y un campo de texto para agregar un motivo.
  /// Si el usuario confirma, se finaliza la tutoria
  /// TODO: agregar logica para cancelar la tutoria
  Future<dynamic> _cancelarTutoria(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String motivo = '';

        return AlertDialog(
          title: const Text('Confirmar cancelación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¿Está seguro que desea cancelar esta tutoria?'),
              const SizedBox(height: 10),
              const Text('Agregue el motivo:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
              const SizedBox(height: 10),
              TextField(
                maxLines: 3,
                onChanged: (value) => motivo = value,
                decoration: const InputDecoration(
                  hintText: 'Escriba el motivo aquí',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                EstudianteService estudianteService = EstudianteService();
                CancelarTutoriaRequest request = CancelarTutoriaRequest(
                  tutoriaId: tutoria.id!,
                  descripcion: motivo,
                );
                estudianteService.cancelarTutoria(request);
                Navigator.pushReplacementNamed(context, 'StudentMenuPage');
              },
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
