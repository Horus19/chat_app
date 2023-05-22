import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/tutoriaResponse.dart';
import '../../services/estudiante_service.dart';

class SolicitudTutoriaDetalleEstudiante extends StatefulWidget {
  const SolicitudTutoriaDetalleEstudiante({super.key});

  @override
  State<SolicitudTutoriaDetalleEstudiante> createState() =>
      _SolicitudTutoriaDetalleEstudianteState();
}

class _SolicitudTutoriaDetalleEstudianteState
    extends State<SolicitudTutoriaDetalleEstudiante> {
  tutoriaResponse get solicitudTutoria =>
      ModalRoute.of(context)!.settings.arguments as tutoriaResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la solicitud'),
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
                solicitudTutoria.descripcion!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                solicitudTutoria.tutorNombre!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Materia:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                solicitudTutoria.materiaNombre!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                solicitudTutoria.fechaTutoria != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(solicitudTutoria.fechaTutoria!)
                    : 'No definida',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fecha de solicitud:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                solicitudTutoria.fechaSolicitud != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(solicitudTutoria.fechaSolicitud!)
                    : 'No definida',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                '\$${solicitudTutoria.valorOferta}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      _createCancellationDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancelar')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a dialog to confirm the cancellation of the request.
  Future<dynamic> _createCancellationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar cancelación'),
          content:
              const Text('¿Está seguro que desea cancelar esta solicitud?'),
          actions: [
            TextButton(
              onPressed: () {
                EstudianteService estudianteService = EstudianteService();
                estudianteService
                    .cancelarSolicitud(solicitudTutoria.id!)
                    .then((value) {
                  Navigator.pushReplacementNamed(context, 'StudentMenuPage');
                });
              },
              child: const Text('Aceptar'),
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
