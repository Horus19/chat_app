import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      required this.texto,
      required this.uid,
      required this.animationController});

  final String texto;
  final String uid;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: Container(
        child: uid == '123'
            ? _myMessage()
            : _notMyMessage(), // TODO: implement build
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 17, 134, 23),
            borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
        decoration: BoxDecoration(
            color: const Color(0xffE4E5E8),
            borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
