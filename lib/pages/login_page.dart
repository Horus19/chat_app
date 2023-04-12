import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: const [
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
      child: Column(
        children: const [
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
                    child: Text('Olvidé mi contraseña'),
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
                color: const Color.fromARGB(255, 12, 112, 170),
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
              Navigator.pushReplacementNamed(context, 'Register');
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
