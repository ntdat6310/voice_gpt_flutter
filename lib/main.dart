import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:voice_gpt_flutter/data/services/local_storage_service.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';
import 'package:voice_gpt_flutter/stores/language/language_store.dart';
import 'package:voice_gpt_flutter/ui/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferenceHelper
  await SharedPreferenceHelper().init();

  // Initialize LocalStorageService
  await LocalStorageService().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
    _languageStore = LanguageStore();
    _languageStore.setOnLocaleChanged(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _languageStore.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(languageStore: _languageStore),
    );
  }
}
