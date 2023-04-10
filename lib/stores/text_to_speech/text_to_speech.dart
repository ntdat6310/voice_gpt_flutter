import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';

part 'text_to_speech.g.dart';

class TextToSpeechStore = _TextToSpeechBase with _$TextToSpeechStore;

abstract class _TextToSpeechBase with Store {
  late FlutterTts _flutterTts;

  @readonly
  String? _language;

  @readonly
  double _volume = 0.5;

  @readonly
  double _pitch = 1.0;

  @readonly
  double _rate = 0.5;

  @readonly
  String? _newVoiceText;

  @readonly
  bool _isPlaying = false;

  @readonly
  bool _isAutoSpeak = true;

  @readonly
  int _messageSpeakingIndex = -1;

  _TextToSpeechBase()
      : _isAutoSpeak = SharedPreferenceHelper.autoSpeak,
        _language = SharedPreferenceHelper.chatBotSpeakingLanguage {
    _initTts();
  }

  Future<void> _initTts() async {
    _flutterTts = FlutterTts();

    _flutterTts.setLanguage(_language!);

    _flutterTts.setStartHandler(() {
      _isPlaying = true;
    });

    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
      _messageSpeakingIndex = -1;
    });

    _flutterTts.setErrorHandler((msg) {
      _isPlaying = false;
      _messageSpeakingIndex = -1;
    });
  }

  @action
  Future<void> setLanguage(String newLanguage) async {
    _language = newLanguage;
    await _flutterTts.setLanguage(newLanguage);
  }

  @action
  Future<void> setVolume(double newVolume) async {
    _volume = newVolume;
    await _flutterTts.setVolume(newVolume);
  }

  @action
  Future<void> setPitch(double newPitch) async {
    _pitch = newPitch;
    await _flutterTts.setPitch(newPitch);
  }

  @action
  Future<void> setRate(double newRate) async {
    _rate = newRate;
    await _flutterTts.setSpeechRate(newRate);
  }

  @action
  Future<void> setNewVoiceText(String text) async {
    _newVoiceText = text;
  }

  @action
  Future<void> speak() async {
    if (_newVoiceText != null && _newVoiceText!.isNotEmpty) {
      await _flutterTts.speak(_newVoiceText!);
    }
  }

  @action
  Future<void> speakText(String text, int messageSpeakingIndex) async {
    _messageSpeakingIndex = messageSpeakingIndex;
    await _flutterTts.speak(text);
  }

  @action
  Future<void> autoSpeak(String text, int messageSpeakingIndex) async {
    if (_isAutoSpeak) {
      await speakText(text, messageSpeakingIndex);
    }
  }

  @action
  Future<void> stop() async {
    await _flutterTts.stop();
    _isPlaying = false;
    _messageSpeakingIndex = -1;
  }

  Future<List> getLanguages() async {
    List<dynamic> languages = await _flutterTts.getLanguages;
    print("languages:_______________");
    print(languages.toString());
    return languages;
  }
}
