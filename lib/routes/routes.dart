import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/reset_password.dart';
import '../pages/usuarios_pages.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'Usuarios': (_) => const UsuariosPage(),
  'Chat': (_) => const ChatPage(),
  'Login': (_) => const LoginPage(),
  'Register': (_) => const RegisterPage(),
  "LoadingPage": (_) => const LoadingPage(),
  "ResetPassword": (_) => const ResetPasswordScreen(),
};
