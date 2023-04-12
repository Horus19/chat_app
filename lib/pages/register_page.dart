import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: const [
              _Header(),
              _Form(),
              _Label(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "TutUIS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Ingresa tus datos para empezar a usar nuestros servicios.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final pass2Ctrl = TextEditingController();

  bool _obscurePass = false;

  bool _obscurePass2 = true;

  @override
  Widget build(BuildContext context) {
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
              controller: nameCtrl,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Nombre',
                errorStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) {
                // Si el valor es nulo o vacío, mostrar un mensaje de error
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su nombre';
                }

                // Si todo está bien, retornar null
                return null;
              },
            ),
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
                if (!value.endsWith('@correo.uis.edu.co')) {
                  return 'El correo debe terminar en @correo.uis.edu.co';
                }
                // Si todo está bien, retornar null
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
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
                  icon: Icon(_obscurePass
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
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
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: pass2Ctrl,
              autocorrect: false,
              obscureText: _obscurePass2,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: 'Confirmar Contraseña',
                errorStyle: const TextStyle(color: Colors.red),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePass2
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () {
                    setState(() {
                      _obscurePass2 = !_obscurePass2;
                    });
                  },
                ),
              ),
              validator: (value) {
                // Si el valor es nulo o vacío, mostrar un mensaje de error
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                }
                // Si el valor es diferente al de passCtrl, mostrar otro mensaje de error
                if (value != passCtrl.text) {
                  return 'Las contraseñas no coinciden';
                }
                // Si todo está bien, retornar null
                return null;
              },
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si el formulario es válido, mostrar un snackbar
                    //TODO: Crear un servicio para manejar el login
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Verifica tus datos e intenta de nuevo"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                color: Color.fromARGB(255, 12, 112, 170),
                shape: const StadiumBorder(),
                child: const Text(
                  "Registrarse",
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

class _Label extends StatelessWidget {
  const _Label({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Column(
        children: [
          const Text(
            "¿Ya tienes cuenta?",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "Login");
            },
            child: const Text(
              "Inicia sesión aquí!",
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
