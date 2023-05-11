import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../pages/Activar_perfil_tutor_page.dart';
import '../pages/Solicitar_tutoria_page.dart';
import '../pages/buscar_tutor_page.dart';
import '../pages/estudiante/SolicitudTutoriasListStudent.dart';
import '../pages/estudiante/Tutorias_activas_estudiante.dart';
import '../pages/estudiante/tutorias_finalizadas_estudiante_page.dart';
import '../pages/historial_tutorias_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/menu_estudiante_page.dart';
import '../pages/menu_tutor_page.dart';
import '../pages/register_page.dart';
import '../pages/reset_password.dart';
import '../pages/rol_selection_page.dart';
import '../pages/successful_registration_page.dart';
import '../pages/tutor/solicitud_tutoria_details_page.dart';
import '../pages/tutor/solicitud_tutoria_list_page.dart';
import '../pages/tutor/tutor_profille_screen.dart';
import '../pages/tutor/tutoria_aceptada_page.dart';
import '../pages/tutor/tutorias_activas_list_page.dart';
import '../pages/tutor/tutorias_finalizadas_page.dart';
import '../pages/tutor_detalle_page.dart';
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
  "ActivateTutorProfileScreen": (_) => const ActivarPerfilTutorScreen(),
  "TutorDetailPage": (_) => const TutorDetailPage(),
  "SolicitudTutoriaScreen": (_) => const SolicitudTutoriaScreen(),
  "SolicitudTutoriasList": (_) => const SolicitudTutoriasList(),
  "SolicitudTutoriaDetails": (_) => const SolicitudTutoriaDetails(),
  "TutoriasActivasList": (_) => const TutoriasActivasList(),
  "TutorProfileScreen": (_) => const TutorProfileScreen(),
  "TutoriaAceptadaPage": (_) => const TutoriaAceptadaPage(),
  "SolicitudTutoriasListStudent": (_) => const SolicitudTutoriasListStudent(),
  "TutoriasActivasEstudiante": (_) => const TutoriasActivasEstudiante(),
  "TutoriasFinalizadasList": (_) => const TutoriasFinalizadasList(),
  "TutoriasFinalizadasEstudiante": (_) => const TutoriasFinalizadasEstudiante(),
};
