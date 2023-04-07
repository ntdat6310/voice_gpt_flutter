import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';
import 'package:voice_gpt_flutter/ui/home/home_page.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferenceHelper
  await SharedPreferenceHelper().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
