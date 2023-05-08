import 'package:chat_app/models/tutorDTO.dart';
import 'package:flutter/material.dart';

import '../services/estudiante_service.dart';

class TutorSearchScreen extends StatefulWidget {
  const TutorSearchScreen({Key? key}) : super(key: key);

  @override
  State<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends State<TutorSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<TutorDto> _tutores = [];

  final EstudianteService _estudianteService = EstudianteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Tutor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'StudentMenuPage');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por materia o tutor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _estudianteService
                        .getTutoresByQuery(_searchController.text)
                        .then((tutores) {
                      setState(() {
                        _tutores = tutores;
                      });
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _tutores.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _tutores[index].nombre ?? "Sin nombre",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_tutores[index].descripcion!.split(' ').take(10).join(' ')}...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          // const SizedBox(height: 16),
                          // Wrap(
                          //   spacing: 8,
                          //   children: _tutores[index].materias?.map((materia) {
                          //         return Chip(
                          //           label: Text(
                          //             materia.nombre ?? "",
                          //             style: const TextStyle(fontSize: 12),
                          //           ),
                          //           backgroundColor: Colors.blue[100],
                          //         );
                          //       }).toList() ??
                          //       [],
                          // ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Costo: ${_tutores[index].costo ?? "No disponible"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                "Calificación: ${_tutores[index].calificacion ?? "0"}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  'TutorDetailPage',
                                  arguments: _tutores[index],
                                );
                              },
                              child: const Text("Ver perfil"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
