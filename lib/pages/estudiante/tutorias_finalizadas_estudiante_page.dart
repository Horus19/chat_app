import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../models/tutoriaResponse.dart';
import '../../services/estudiante_service.dart';

class TutoriasFinalizadasEstudiante extends StatefulWidget {
  const TutoriasFinalizadasEstudiante({super.key});

  @override
  State<TutoriasFinalizadasEstudiante> createState() =>
      _TutoriasFinalizadasEstudianteState();
}

class _TutoriasFinalizadasEstudianteState
    extends State<TutoriasFinalizadasEstudiante> {
  final EstudianteService _estudianteService = EstudianteService();

  String get estudiante => ModalRoute.of(context)!.settings.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorías finalizadas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<tutoriaResponse>>(
        future: _estudianteService.getAllCompletedTutoringByStudent(estudiante),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar las tutorías finalizadas'),
              );
            } else {
              final solicitudes = snapshot.data!;
              return ListView.builder(
                itemCount: solicitudes.length,
                itemBuilder: (context, index) {
                  final solicitud = solicitudes[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        /// Navigate to the details page
                        Navigator.pushNamed(
                          context,
                          'TutoriaFinalizadaEstudiante',
                          arguments: solicitud,
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${solicitud.descripcion!.split(' ').take(10).join(' ')}...',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    solicitud.estudiantenombre!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '\$${solicitud.valorOferta}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
