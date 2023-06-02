import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';
import '../services/tutor_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _Logo(),
                _Form(),
                _Label(),
              ],
            ),
          )),
    );
  }
}

///Widget que contiene el logo de la aplicación
class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(top: 30),
      width: 170,
      child: const Column(
        children: [
          Image(
            image: AssetImage('assets/user.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'TutUIS',
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    ));
  }
}

///Widget que contiene el formulario de login

class _Form extends StatefulWidget {
  const _Form({super.key});
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool _obscurePass = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final tutorService = Provider.of<TutorService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 0, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailCtrl,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Correo',
                errorStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) {
                // Si el valor es nulo o vacío, mostrar un mensaje de error
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
                // Si el valor no termina en @correo.uis.edu.co, mostrar otro mensaje de error
                // if (!value.endsWith('@correo.uis.edu.co')) {
                //   return 'El correo debe terminar en @correo.uis.edu.co';
                // }
                // Si todo está bien, retornar null
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                TextFormField(
                  controller: passCtrl,
                  autocorrect: false,
                  obscureText: _obscurePass,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: 'Contraseña',
                    errorStyle: const TextStyle(color: Colors.red),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePass = !_obscurePass;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    // Si el valor es nulo o vacío, mostrar un mensaje de error
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una contraseña';
                    }
                    // Si el valor no tiene al menos 6 caracteres, mostrar otro mensaje de error
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    // Si todo está bien, retornar null
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'ResetPassword');
                      //Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: const Text('Olvidé mi contraseña'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double
                  .infinity, // Esto hace que el botón tenga el ancho máximo posible
              height:
                  50.0, // Esto hace que el botón tenga una altura fija de 50 pixeles
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (authService.autenticando) return;
                    FocusScope.of(context).unfocus();
                    // Si el formulario es válido, mostrar un snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ingresando..."),
                        backgroundColor: Colors.blue,
                      ),
                    );

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (!loginOk.ok) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(loginOk.message ?? "Error al ingresar"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      final socketService =
                          // ignore: use_build_context_synchronously
                          Provider.of<SocketService>(context, listen: false);

                      await socketService.connect();

                      socketService.subscribeToNotifications(loginOk.id!);

                      if (loginOk.roles!.contains('tutor')) {
                        await tutorService.getTutorByUserId(loginOk.id!);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, 'RolSelectionPage');
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, 'StudentMenuPage');
                      }
                    }
                  }
                },
                color: !authService.autenticando
                    ? const Color.fromARGB(255, 12, 112, 170)
                    : Colors.grey,
                shape: const StadiumBorder(),
                child: const Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///Widget que contiene el texto de "¿No tienes cuenta?"
class _Label extends StatelessWidget {
  const _Label({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Column(
        children: [
          const Text(
            '¿No tienes cuenta?',
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'Register');
            },
            child: const Text(
              'Crea una ahora!',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
