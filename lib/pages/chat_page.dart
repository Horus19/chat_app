import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centrar contenido
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      maxRadius: 14,
                      child: Text('Te', style: TextStyle(fontSize: 12)),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Nombre del usuario',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWriting = false;
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
    super.dispose();
  }
}
