import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/Activar_perfil_tutor_page.dart';
import '../pages/buscar_tutor_page.dart';
import '../pages/historial_tutorias_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/menu_estudiante_page.dart';
import '../pages/menu_tutor_page.dart';
import '../pages/register_page.dart';
import '../pages/reset_password.dart';
import '../pages/rol_selection_page.dart';
import '../pages/successful_registration_page.dart';
import '../pages/usuarios_pages.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'Usuarios': (_) => const UsuariosPage(),
  'Chat': (_) => const ChatPage(),
  'Login': (_) => const LoginPage(),
  'Register': (_) => const RegisterPage(),
  "LoadingPage": (_) => const LoadingPage(),
  "ResetPassword": (_) => const ResetPasswordScreen(),
  "welcome": (_) => const SuccessfulRegistrationPage(),
  "RolSelectionPage": (_) => const RolSelectionPage(),
  "StudentMenuPage": (_) => const StudentMenuPage(),
  "TutorMenuPage": (_) => const TutorMenuPage(),
  "TutorSearchScreen": (_) => const TutorSearchScreen(),
  "HistorialTutoriasScreen": (_) => const HistorialTutoriasScreen(),
  "ActivateTutorProfileScreen": (_) => ActivarPerfilTutorScreen(),
};
