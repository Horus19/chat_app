import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tutor_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    final TutorService tutorService =
        Provider.of<TutorService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    final usuario = await AuthService.getUsuario();
    if (autenticado) {
      if (usuario != null && usuario.roles.contains('tutor')) {
        tutorService.getTutorByUserId(usuario.id);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'RolSelectionPage');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'StudentMenuPage');
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'Login');
    }
  }
}
