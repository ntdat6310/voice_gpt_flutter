import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';

abstract class _AutoSpeakBase with Store {
  @readonly
  late bool _isAutoSpeak;

  _AutoSpeakBase() : _isAutoSpeak = SharedPreferenceHelper.autoSpeak;

  @action
  void changeAutoSpeak(bool autoSpeak) {
    if (_isAutoSpeak != autoSpeak) {
      SharedPreferenceHelper.changeAutoSpeak(isAutoSpeak: autoSpeak);
    }
  }
}
