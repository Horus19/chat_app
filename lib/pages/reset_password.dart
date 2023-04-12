import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isSent
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hemos enviado un correo a la dirección proporcionada. Por favor, revisa tu bandeja de entrada y sigue las instrucciones para reestablecer tu contraseña.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: const Color.fromARGB(255, 12, 112, 170),
                        shape: const StadiumBorder(),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ingresa tu correo para reestablecer tu contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          hintText: 'ejemplo@correo.com',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa un correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      MaterialButton(
                        onPressed: () {
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Por favor, ingresa un correo electrónico"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            //TODO: Agregar lógica para manejar el envío de correo electrónico para reestablecer la contraseña
                            setState(() {
                              isSent = true;
                            });
                          }
                        },
                        color: const Color.fromARGB(255, 12, 112, 170),
                        shape: const StadiumBorder(),
                        child: const Text(
                          "Enviar correo",
                          style: TextStyle(color: Colors.white),
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
