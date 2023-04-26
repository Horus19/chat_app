import 'package:flutter/material.dart';

class TutorSearchScreen extends StatefulWidget {
  const TutorSearchScreen({super.key});

  @override
  State<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends State<TutorSearchScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Tutor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'StudentMenuPage');
            // Acción al presionar el botón de regreso
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por materia o tutor',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //TODO: Implementar búsqueda
                    print(_searchController.text);
                    // Acción a realizar al presionar el botón de búsqueda
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  5, // reemplazar con la cantidad de resultados de búsqueda
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text('Nombre del tutor $index'),
                    trailing: const Text("4.5"),
                    onTap: () {
                      // accion al hacer clic en el tutor seleccionado
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
