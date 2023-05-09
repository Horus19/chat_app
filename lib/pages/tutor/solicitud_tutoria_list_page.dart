import 'package:flutter/material.dart';
import '../../models/tutoriaResponse.dart';
import '../../services/tutor_service.dart';

class SolicitudTutoriasList extends StatefulWidget {
  const SolicitudTutoriasList({Key? key});

  @override
  State<SolicitudTutoriasList> createState() => _SolicitudTutoriasListState();
}

class _SolicitudTutoriasListState extends State<SolicitudTutoriasList> {
  final TutorService _tutorService = TutorService();

  String get tutor => ModalRoute.of(context)!.settings.arguments as String;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de tutoría'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'TutorMenuPage');
          },
        ),
      ),
      body: FutureBuilder<List<tutoriaResponse>>(
        future: _tutorService.getAllTutoringRequestsByTutor(tutor),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar las solicitudes de tutoría'),
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
                          'SolicitudTutoriaDetails',
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
