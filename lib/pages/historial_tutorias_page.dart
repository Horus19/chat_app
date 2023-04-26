import 'package:flutter/material.dart';

class HistorialTutoriasScreen extends StatelessWidget {
  const HistorialTutoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Tutorías'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'StudentMenuPage');
            // Acción al presionar el botón de regreso
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // número de tutorías en el historial
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text('Materia $index'),
              subtitle: Text('Fecha de la tutoría $index'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // acción al hacer clic en la tutoría seleccionada
              },
            ),
          );
        },
      ),
    );
  }
}
