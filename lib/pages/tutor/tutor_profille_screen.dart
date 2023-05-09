import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/materia.dart';
import '../../models/tutorDTO.dart';
import '../../services/materia_service.dart';
import '../../services/tutor_service.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({Key? key}) : super(key: key);

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  late TutorDto tutor;
  late List<Materia> _materias = [];
  final List<Materia> _materiasSeleccionadas = [];

  // var _isEnabled = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tutor = ModalRoute.of(context)!.settings.arguments as TutorDto;
    Provider.of<MateriaService>(context, listen: false)
        .getMaterias()
        .then((materias) {
      setState(() {
        _materias = materias;
        //Obtiene las materias de las materias del tutor
        _materiasSeleccionadas.addAll(_materias
            .where((materia) => tutor.materias!
                .any((materiaTutor) => materiaTutor.id == materia.id))
            .toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tutorService = Provider.of<TutorService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestionar perfil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'TutorMenuPage');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Editar informacion del tutor:",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              const Text(
                'Aquí podrás actualizar los datos de tu perfil de tutor. Por favor, asegúrate de revisar cuidadosamente toda la información antes de guardar los cambios.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descripción, experiencia y habilidades como tutor:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: tutor.descripcion,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    tutor = tutor.copyWith(descripcion: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Materias en las que puedes ofrecer tutorías:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  hintText: "Selecciona...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _materias.map((materia) {
                  return DropdownMenuItem(
                    value: materia,
                    child: Text(
                      materia.codigoNombre!,
                      style: const TextStyle(fontSize: 16),
                    ),
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
                    label: Text(
                      materia.codigoNombre!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.blueGrey[100],
                    deleteIcon: const Icon(
                      Icons.cancel_rounded,
                      size: 24,
                    ),
                    onDeleted: () {
                      setState(() {
                        _materiasSeleccionadas.remove(materia);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tarifa sugerida por hora de tutoría',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: tutor.costo,
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
                    tutor = tutor.copyWith(costo: value);
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar edición de perfil'),
                            content: const Text(
                                '¿Está seguro que desea guardar los cambios en el perfil?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  tutorService.update(tutor);
                                  Navigator.pushReplacementNamed(
                                      context, 'TutorMenuPage');
                                },
                                child: const Text('Guardar'),
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
                    child: const Text('Aceptar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'TutorMenuPage');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text("Habilitar costo"),
              //     Switch(
              //       value: _isEnabled,
              //       onChanged: (bool value) {
              //         setState(() {
              //           _isEnabled = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
