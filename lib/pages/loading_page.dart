import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final autenticado = await authService.isLoggedIn();
    final usuario = await AuthService.getUsuario();
    if (autenticado) {
      if (usuario != null && usuario.roles.contains('tutor')) {
        print('ROl seleccionado');
        Navigator.pushReplacementNamed(context, 'RolSelectionPage');
      } else
        Navigator.pushReplacementNamed(context, 'StudentMenuPage');
    } else {
      Navigator.pushReplacementNamed(context, 'Login');
    }
  }
}
