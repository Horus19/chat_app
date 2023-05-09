import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/tutoriaResponse.dart';
import '../../services/tutor_service.dart';

class SolicitudTutoriaDetails extends StatefulWidget {
  const SolicitudTutoriaDetails({Key? key});

  @override
  _SolicitudTutoriaDetailsState createState() =>
      _SolicitudTutoriaDetailsState();
}

class _SolicitudTutoriaDetailsState extends State<SolicitudTutoriaDetails> {
  tutoriaResponse get solicitudTutoria =>
      ModalRoute.of(context)!.settings.arguments as tutoriaResponse;

  final TutorService _tutorService = TutorService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la solicitud'),
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
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                'Estudiante:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                solicitudTutoria.estudiantenombre!,
                style: const TextStyle(
                  fontSize: 16,
                ),
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
                style: const TextStyle(
                  fontSize: 16,
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar aceptación'),
                            content: const Text(
                                '¿Está seguro que desea aceptar esta solicitud?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _tutorService
                                      .aceptarSolicitudTutoria(
                                          solicitudTutoria.id!)
                                      .then((value) => {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                'SolicitudTutoriasList',
                                                arguments: solicitudTutoria.id)
                                          });
                                },
                                child: const Text('Aceptar'),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String motivo = '';

                          return AlertDialog(
                            title: const Text('Confirmar rechazo'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '¿Está seguro que desea rechazar esta solicitud?'),
                                const SizedBox(height: 10),
                                const Text(
                                    'Puedes agregar un motivo si lo deseas:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                                const SizedBox(height: 10),
                                TextField(
                                  onChanged: (value) => motivo = value,
                                  decoration: const InputDecoration(
                                    hintText: 'Escriba el motivo aquí',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _tutorService
                                      .rechazarSolicitudTutoria(
                                          solicitudTutoria.id!, motivo)
                                      .then((value) => {
                                            Navigator.pushReplacementNamed(
                                                context,
                                                'SolicitudTutoriasList',
                                                arguments: solicitudTutoria.id)
                                          });
                                },
                                child: const Text('Confirmar'),
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Rechazar'),
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
