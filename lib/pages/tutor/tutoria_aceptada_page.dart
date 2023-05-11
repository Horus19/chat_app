import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/tutoriaResponse.dart';
import '../../services/tutor_service.dart';

class TutoriaAceptadaPage extends StatefulWidget {
  const TutoriaAceptadaPage({super.key});

  @override
  State<TutoriaAceptadaPage> createState() => _TutoriaAceptadaPageState();
}

class _TutoriaAceptadaPageState extends State<TutoriaAceptadaPage> {
  late tutoriaResponse tutoria;

  bool isFinishable = false;

  bool isCancellable = false;

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
    });
  }

  final TutorService _tutorService = TutorService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la tutoría'),
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
                'Estudiante:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                tutoria.estudiantenombre!,
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
                    onPressed: () {
                      //TODO: implementar logica para el chat
                      Navigator.pushReplacementNamed(context, 'Chat');
                    },
                    child: const Text('Ir al chat'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isFinishable) {
                        _finalizarTutoria(context);
                      } else {
                        _cancelarTutoria(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isCancellable
                            ? Colors.red
                            : isFinishable
                                ? Colors.green
                                : Colors.grey),
                    child: Text(isFinishable ? 'finalizar' : 'Cancelar'),
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
              const Text('Puedes agregar un motivo si lo deseas:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
              const SizedBox(height: 10),
              TextField(
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
                _tutorService
                    .rechazarSolicitudTutoria(tutoria.id!, motivo)
                    .then((value) => {
                          Navigator.pushReplacementNamed(
                              context, 'SolicitudTutoriasList',
                              arguments: tutoria.id)
                        });
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

  /// Muestra un dialogo de confirmación para finalizar la tutoria
  /// Si el usuario confirma, se finaliza la tutoria y se redirige al menu del tutor
  /// Si el usuario cancela, se cierra el dialogo
  Future<dynamic> _finalizarTutoria(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar finalización'),
          content: const Text('¿Está seguro que desea finalizar esta tutoria?'),
          actions: [
            TextButton(
              onPressed: () {
                _tutorService.finalizarTutoria(tutoria.id!).then((value) =>
                    {Navigator.pushReplacementNamed(context, 'TutorMenuPage')});
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
