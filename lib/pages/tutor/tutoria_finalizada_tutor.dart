import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/tutoriaResponse.dart';

class TutoriaFinalizadaTutor extends StatefulWidget {
  const TutoriaFinalizadaTutor({super.key});

  @override
  State<TutoriaFinalizadaTutor> createState() =>
      _TutoriaFinalizadaEstudianteState();
}

class _TutoriaFinalizadaEstudianteState extends State<TutoriaFinalizadaTutor> {
  tutoriaResponse get solicitudTutoria =>
      ModalRoute.of(context)!.settings.arguments as tutoriaResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutoria finalizada - Tutor'),
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
                'Estudiante:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                solicitudTutoria.estudiantenombre!,
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
            ],
          ),
        ),
      ),
    );
  }
}
