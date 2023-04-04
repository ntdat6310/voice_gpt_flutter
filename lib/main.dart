import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChatPage());
  }
}
