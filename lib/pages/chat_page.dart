import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isWriting = false;

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _listenMessage);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Hide sticker when keyboard appear
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                // Acción al presionar el botón de regreso
              },
            ),
            title: const Text("Conversación")),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) =>
                  _messages[index],
              reverse: true,
            )),
            const Divider(height: 1),
            _inputChat(),
          ]),
        ),
      ),
    );
  }

  /// Widget para el input del chat
  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(children: [
        Flexible(
          child: TextField(
            focusNode: _focusNode,
            controller: _textController,
            decoration: const InputDecoration.collapsed(
              hintText: 'Enviar mensaje',
            ),
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                if (texto.trim().isNotEmpty) {
                  _isWriting = true;
                } else {
                  _isWriting = false;
                }
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: IconTheme(
            data: const IconThemeData(color: Colors.blue),
            child: IconButton(
              onPressed: _isWriting
                  ? () => _handleSubmit(_textController.text.trim())
                  : null,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ]),
    ));
  }

  /// Función para enviar el mensaje,
  /// [texto] es el mensaje que se va a enviar
  void _handleSubmit(String texto) {
    if (texto.isEmpty) return;
    final newMessage = ChatMessage(
      texto: texto,
      uid: authService.usuario.id,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWriting = false;
    });
    socketService.socket.emit('mensaje-personal', {
      'de': authService.usuario.id,
      'para': chatService.idUsuarioPara,
      'mensaje': texto
    });
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    //TODO: Off del socket
    for (var element in _messages) {
      element.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  _listenMessage(data) {
    ChatMessage message = ChatMessage(
      texto: data['mensaje'],
      uid: data['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
}
