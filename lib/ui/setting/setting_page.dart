import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/language.dart';
import 'package:voice_gpt_flutter/shared/enum.dart';
import 'package:voice_gpt_flutter/stores/auto_speak/auto_speak.dart';
import 'package:voice_gpt_flutter/stores/chatbot_speaking_language/chatbot_speaking_language.dart';
import 'package:voice_gpt_flutter/stores/language/language_store.dart';
import 'package:voice_gpt_flutter/stores/text_to_speech/text_to_speech.dart';
import 'package:voice_gpt_flutter/ui/setting/components/auto_speak_dialog.dart';
import 'package:voice_gpt_flutter/ui/setting/components/language_dialog.dart';
import 'package:voice_gpt_flutter/ui/setting/components/language_speak_chatbot_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/styles/background.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.languageStore}) : super(key: key);
  final LanguageStore languageStore;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AutoSpeakStore _autoSpeakStore = AutoSpeakStore();
  final ChatBotSpeakingLanguageStore _chatBotSpeakingLanguageStore =
      ChatBotSpeakingLanguageStore();
  final TextToSpeechStore _textToSpeechStore = TextToSpeechStore();
  List<dynamic> languagesChatBot = [];
  late final LanguageStore _languageStore;

  @override
  void initState() {
    _textToSpeechStore.getLanguages().then((value) {
      languagesChatBot = value;
    });

    _languageStore = widget.languageStore;

    print("Language: ${_languageStore.locale.languageCode.toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.setting),
          backgroundColor: Background.botBackgroundColor,
        ),
        body: Container(
          color: Background.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.dark_mode,
                          color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.dark_mode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () async {
                    String? languageCode = await showDialog(
                        context: context,
                        builder: (context) {
                          return const LanguageDialog();
                        });
                    if (languageCode != null) {
                      _languageStore.setLocale(languageCode: languageCode);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.language_outlined,
                          color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.language_select,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () async {
                    AutoSpeakStatus? result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AutoSpeakDialog(
                              initialStatus: _autoSpeakStore.isAutoSpeak);
                        });
                    if (result != null) {
                      _autoSpeakStore.changeAutoSpeak(
                          result == AutoSpeakStatus.enable ? true : false);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.record_voice_over,
                          color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.auto_speak,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () async {
                    String? chatBotLanguage = await showDialog(
                        context: context,
                        builder: (context) {
                          return LanguageSpeakChatBotDialog(
                            languages: languagesChatBot,
                          );
                        });
                    if (chatBotLanguage != null) {
                      _chatBotSpeakingLanguageStore
                          .changeChatBotSpeakingLanguage(chatBotLanguage);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.record_voice_over,
                          color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.chatbot_language,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
