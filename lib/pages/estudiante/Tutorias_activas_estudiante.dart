import 'package:flutter/material.dart';

import '../../models/tutoriaResponse.dart';
import '../../services/estudiante_service.dart';

class TutoriasActivasEstudiante extends StatefulWidget {
  const TutoriasActivasEstudiante({super.key});

  @override
  State<TutoriasActivasEstudiante> createState() =>
      _TutoriasAceptadasEstudianteState();
}

class _TutoriasAceptadasEstudianteState
    extends State<TutoriasActivasEstudiante> {
  String get estudiante => ModalRoute.of(context)!.settings.arguments as String;
  EstudianteService estudianteService = EstudianteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorías activas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'StudentMenuPage');
          },
        ),
      ),
      body: FutureBuilder<List<tutoriaResponse>>(
        future: estudianteService.getAllacceptedTutoringByStudent(estudiante),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar las tutoría activas'),
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
                          'TutoriaAceptadaPage',
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
