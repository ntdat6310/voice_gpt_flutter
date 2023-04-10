import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';

part 'chatbot_speaking_language.g.dart';

class ChatBotSpeakingLanguageStore = _ChatBotSpeakingLanguageBase
    with _$ChatBotSpeakingLanguageStore;

abstract class _ChatBotSpeakingLanguageBase with Store {
  @readonly
  late String _chatBotSpeakingLanguage;

  _ChatBotSpeakingLanguageBase()
      : _chatBotSpeakingLanguage =
            SharedPreferenceHelper.chatBotSpeakingLanguage;

  @action
  void changeChatBotSpeakingLanguage(String chatBotSpeakingLanguage) {
    if (_chatBotSpeakingLanguage != chatBotSpeakingLanguage) {
      SharedPreferenceHelper.changeChatBotSpeakingLanguage(
          chatBotSpeakingLanguage: chatBotSpeakingLanguage);
    }
  }
}
