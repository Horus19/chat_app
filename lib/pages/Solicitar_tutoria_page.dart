import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/solicitudTutoriaDto.dart';
import '../models/tutorDTO.dart';
import '../services/auth_service.dart';
import '../services/estudiante_service.dart';

class SolicitudTutoriaScreen extends StatefulWidget {
  const SolicitudTutoriaScreen({Key? key}) : super(key: key);

  @override
  _SolicitudTutoriaScreenState createState() => _SolicitudTutoriaScreenState();
}

class _SolicitudTutoriaScreenState extends State<SolicitudTutoriaScreen> {
  final _formKey = GlobalKey<FormState>();

  final SolicitudTutoriaDto _solicitudTutoriaDto = SolicitudTutoriaDto();

  final EstudianteService _estudianteService = EstudianteService();

  TutorDto get tutor => ModalRoute.of(context)!.settings.arguments as TutorDto;

  @override
  void initState() {
    super.initState();
    AuthService.getUsuario().then((usuario) {
      setState(() {
        _solicitudTutoriaDto.estudianteId = usuario!.id;
        _solicitudTutoriaDto.tutorId = tutor.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Tutoría'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Para solicitar una tutoría, por favor diligencie el siguiente formulario:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                    "Seleccione la materia en la que desea recibir tutoría:"),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<MateriaDTO>(
                  items: tutor.materias!
                      .map((materia) => DropdownMenuItem(
                            value: materia,
                            child: Text(materia.nombre!),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _solicitudTutoriaDto.materiaId = value!.id;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Materia',
                    hintText: 'Seleccione una materia',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, seleccione una materia';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                    "Describa brevemente el tema sobre el que desea recibir tutoría:"),
                const SizedBox(height: 8.0),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    hintText: 'Ingrese una descripción',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese una descripción';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _solicitudTutoriaDto.descripcion = value;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text("Ingrese el valor que ofrece por la tutoría:"),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Valor de la oferta',
                    hintText: 'Ingrese el valor de la oferta',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el valor de la oferta';
                    }
                    final numberValue = int.tryParse(value);
                    if (numberValue == null) {
                      return 'Por favor, ingrese un número válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _solicitudTutoriaDto.valorOferta = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16.0),
                const Text("Seleccione la fecha y hora de la tutoría:"),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha y hora de la tutoría',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      final TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _solicitudTutoriaDto.fechaTutoria = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: _solicitudTutoriaDto.fechaTutoria != null
                        ? DateFormat.yMMMMd('es')
                            .add_Hm()
                            .format(_solicitudTutoriaDto.fechaTutoria!)
                        : '',
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _estudianteService
                            .solicitarTutoria(_solicitudTutoriaDto)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'La solicitud de tutoría ha sido enviada'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          Navigator.pushReplacementNamed(
                              context, "StudentMenuPage");
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Enviar Solicitud'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
