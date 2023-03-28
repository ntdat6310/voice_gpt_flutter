import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';

class ChatMessageWidget extends StatefulWidget {
  const ChatMessageWidget({Key? key, required this.text, required this.chatMessageType}) : super(key: key);
  final String text;
  final SenderType chatMessageType;

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
