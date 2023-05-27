import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/reviewRequest.dart';
import '../../models/tutoriaResponse.dart';
import '../../services/review_service.dart';

class TutoriaFinalizadaEstudiante extends StatefulWidget {
  const TutoriaFinalizadaEstudiante({super.key});

  @override
  State<TutoriaFinalizadaEstudiante> createState() =>
      _TutoriaFinalizadaEstudianteState();
}

class _TutoriaFinalizadaEstudianteState
    extends State<TutoriaFinalizadaEstudiante> {
  tutoriaResponse get solicitudTutoria =>
      ModalRoute.of(context)!.settings.arguments as tutoriaResponse;
  ReviewService reviewService = ReviewService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _calificacionController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutoria finalizada'),
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
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ReviewRequest reviewRequest = ReviewRequest(
                      tutoria: solicitudTutoria.id,
                      estudiante: solicitudTutoria.estudianteId,
                      calificacion: 0,
                      comentario: '',
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Calificar tutoría recibida'),
                          content: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Ingresa un número entero de 1 a 5:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _calificacionController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Calificación',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingresa una calificación.';
                                    }
                                    final calificacion = int.tryParse(value);
                                    if (calificacion == null ||
                                        calificacion < 1 ||
                                        calificacion > 5) {
                                      return 'ingresa una calificación de 1 a 5.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Ingresa un comentario:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _comentarioController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    labelText: 'Comentario',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  reviewRequest.calificacion =
                                      int.parse(_calificacionController.text);
                                  reviewRequest.comentario =
                                      _comentarioController.text;
                                  reviewService.createReview(reviewRequest);
                                  Navigator.pushReplacementNamed(
                                      context, 'StudentMenuPage');
                                }
                              },
                              child: const Text('Calificar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Calificar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
