import 'package:flutter/material.dart';
import '../../models/tutorDTO.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({Key? key}) : super(key: key);

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  late TutorDto tutor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tutor = ModalRoute.of(context)!.settings.arguments as TutorDto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestionar perfil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'TutorMenuPage');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Descripción",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              initialValue: tutor.descripcion,
              onSaved: (value) {
                setState(() {
                  tutor = tutor.copyWith(descripcion: value);
                });
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              "Materias",
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tutor.materias?.length ?? 0,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(tutor.materias?[index].nombre ?? ""),
                    value: true,
                    onChanged: (value) {},
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Costo",
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              initialValue: tutor.costo,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                setState(() {
                  tutor = tutor.copyWith(costo: value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
