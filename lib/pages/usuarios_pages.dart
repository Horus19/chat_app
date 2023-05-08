import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        online: true,
        email: "camacho19992012@gmail.com",
        nombre: "Horacio",
        id: "1",
        token: "123",
        roles: ['TUTOR_ROLE']),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text('Usuarios', style: TextStyle(color: Colors.black54)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () => {
              //TODO: Desconectar del socket server
              AuthService.deleteToken(),
              AuthService.deleteUsuario(),
              Navigator.pushReplacementNamed(context, 'Login')
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: const WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue),
            waterDropColor: Colors.blue,
          ),
          child: _listViewUsuarios(),
        ),
      ),
    );
  }

  /// Crea un [ListView] con los usuarios de la aplicación.
  /// El [ListView] se construye con el método [ListView.separated], que permite
  /// crear una lista con separadores entre cada elemento.

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }

  /// Crea un [ListTile] personalizado para mostrar la información de un [Usuario].
  ///
  /// El [ListTile] muestra el [nombre] y [email] del usuario, con una imagen de
  /// avatar representada por las iniciales del nombre. Además, en el extremo derecho
  /// muestra un punto verde si el usuario está en línea, y un punto rojo si está fuera de línea.
  ///
  /// El [usuario] debe ser un objeto [Usuario] válido.
  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: const CircleAvatar(
        child: Text('USR'),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  /// Simula una petición de red para cargar los usuarios.
  /// El método [Future.delayed] simula una petición de red que tarda 1 segundo.
  /// Cuando la petición termina, se llama al método [_refreshController.refreshCompleted()]
  /// para indicar que la petición ha terminado.
  void _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
