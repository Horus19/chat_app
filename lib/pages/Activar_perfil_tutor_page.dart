import 'package:flutter/material.dart';

class ActivarPerfilTutorScreen extends StatefulWidget {
  const ActivarPerfilTutorScreen({super.key});

  @override
  _ActivarPerfilTutorScreenState createState() =>
      _ActivarPerfilTutorScreenState();
}

class _ActivarPerfilTutorScreenState extends State<ActivarPerfilTutorScreen> {
  String _descripcion = '';
  final List<String> _materias = [
    'Matemáticas',
    'Física',
    'Programación',
    'Inglés',
    'Historia'
  ];
  final List<String> _materiasSeleccionadas = [];
  double _tarifa = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activar Perfil de Tutor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'StudentMenuPage');
            // Acción al presionar el botón de regreso
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '¡Bienvenido al programa de tutores!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Para activar tu perfil de tutor, necesitamos que completes tu información como tutor:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Describe tu experiencia y habilidades como tutor:'),
              const SizedBox(height: 8),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _descripcion = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                  'Selecciona las materias en las que puedes ofrecer tutorías:'),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _materias.map((materia) {
                  return DropdownMenuItem(
                    value: materia,
                    child: Text(materia),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (!_materiasSeleccionadas.contains(value)) {
                      _materiasSeleccionadas.add(value!);
                    }
                  });
                },
                value: null,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _materiasSeleccionadas.map((materia) {
                  return Chip(
                    label: Text(materia),
                    onDeleted: () {
                      setState(() {
                        _materiasSeleccionadas.remove(materia);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Establece tu tarifa por hora de tutoría:'),
              const SizedBox(height: 8),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _tarifa = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Descripción: $_descripcion');
                        print('Materias: $_materiasSeleccionadas');
                        print('Tarifa: $_tarifa');
                        // Lógica para enviar la información al servidor y activar el perfil de tutor
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                      ),
                      child: const Text(
                        'Activar perfil de tutor',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
