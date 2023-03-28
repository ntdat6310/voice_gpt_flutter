import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/modules/chat/chat_page.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatPage()
    );
  }
}
