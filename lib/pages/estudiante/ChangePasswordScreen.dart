import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'models/changePassword.dto.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordDto _changePasswordDto = ChangePasswordDto();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recuerda que tu contraseña debe tener al menos 8 caracteres, una letra mayúscula, una minúscula y un número.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // const Text(
                //   'Contraseña actual',
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 10),
                _buildCurrentPasswordInput(),
                const SizedBox(height: 20),
                // const Text(
                //   'Nueva contraseña',
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 10),
                _buildPasswordInput(),
                const SizedBox(height: 20),
                // const Text(
                //   'Confirmar contraseña',
                //   style: TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 10),
                _buildConfirmPasswordInput(),
                const SizedBox(height: 20),
                _buildChangePasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return TextField(
      obscureText: true,
      controller: _passwordController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nueva contraseña',
        hintText: 'Ingrese su nueva contraseña',
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return TextField(
      obscureText: true,
      controller: _confirmPasswordController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Confirmar contraseña',
        hintText: 'Ingrese su nueva contraseña nuevamente',
      ),
    );
  }

  Widget _buildCurrentPasswordInput() {
    return TextField(
      controller: _currentPasswordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contraseña actual',
        hintText: 'Ingrese su contraseña actual',
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _changePasswordDto.password = _currentPasswordController.text;
              _changePasswordDto.newPassword = _passwordController.text;
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              authService
                  .changePassword(_changePasswordDto)
                  .then((value) => {
                        if (value.statusCode == 201)
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Se ha cambiado la contraseña exitosamente'),
                            )),
                            authService.logout(),
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'Login', (route) => false)
                          }
                        else
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'No se ha podido cambiar la contraseña, verifique que la contraseña actual sea correcta'),
                            ))
                          }
                      })
                  .catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(error.toString()),
                ));
              });
            }
          },
          child: const Text('Cambiar contraseña'),
        ),
      ),
    );
  }
}
