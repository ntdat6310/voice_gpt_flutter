// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_to_speech.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextToSpeechStore on _TextToSpeechBase, Store {
  late final _$_languageAtom =
      Atom(name: '_TextToSpeechBase._language', context: context);

  String? get language {
    _$_languageAtom.reportRead();
    return super._language;
  }

  @override
  String? get _language => language;

  @override
  set _language(String? value) {
    _$_languageAtom.reportWrite(value, super._language, () {
      super._language = value;
    });
  }

  late final _$_volumeAtom =
      Atom(name: '_TextToSpeechBase._volume', context: context);

  double get volume {
    _$_volumeAtom.reportRead();
    return super._volume;
  }

  @override
  double get _volume => volume;

  @override
  set _volume(double value) {
    _$_volumeAtom.reportWrite(value, super._volume, () {
      super._volume = value;
    });
  }

  late final _$_pitchAtom =
      Atom(name: '_TextToSpeechBase._pitch', context: context);

  double get pitch {
    _$_pitchAtom.reportRead();
    return super._pitch;
  }

  @override
  double get _pitch => pitch;

  @override
  set _pitch(double value) {
    _$_pitchAtom.reportWrite(value, super._pitch, () {
      super._pitch = value;
    });
  }

  late final _$_rateAtom =
      Atom(name: '_TextToSpeechBase._rate', context: context);

  double get rate {
    _$_rateAtom.reportRead();
    return super._rate;
  }

  @override
  double get _rate => rate;

  @override
  set _rate(double value) {
    _$_rateAtom.reportWrite(value, super._rate, () {
      super._rate = value;
    });
  }

  late final _$_newVoiceTextAtom =
      Atom(name: '_TextToSpeechBase._newVoiceText', context: context);

  String? get newVoiceText {
    _$_newVoiceTextAtom.reportRead();
    return super._newVoiceText;
  }

  @override
  String? get _newVoiceText => newVoiceText;

  @override
  set _newVoiceText(String? value) {
    _$_newVoiceTextAtom.reportWrite(value, super._newVoiceText, () {
      super._newVoiceText = value;
    });
  }

  late final _$_isPlayingAtom =
      Atom(name: '_TextToSpeechBase._isPlaying', context: context);

  bool get isPlaying {
    _$_isPlayingAtom.reportRead();
    return super._isPlaying;
  }

  @override
  bool get _isPlaying => isPlaying;

  @override
  set _isPlaying(bool value) {
    _$_isPlayingAtom.reportWrite(value, super._isPlaying, () {
      super._isPlaying = value;
    });
  }

  late final _$_isAutoSpeakAtom =
      Atom(name: '_TextToSpeechBase._isAutoSpeak', context: context);

  bool get isAutoSpeak {
    _$_isAutoSpeakAtom.reportRead();
    return super._isAutoSpeak;
  }

  @override
  bool get _isAutoSpeak => isAutoSpeak;

  @override
  set _isAutoSpeak(bool value) {
    _$_isAutoSpeakAtom.reportWrite(value, super._isAutoSpeak, () {
      super._isAutoSpeak = value;
    });
  }

  late final _$_messageSpeakingIndexAtom =
      Atom(name: '_TextToSpeechBase._messageSpeakingIndex', context: context);

  int get messageSpeakingIndex {
    _$_messageSpeakingIndexAtom.reportRead();
    return super._messageSpeakingIndex;
  }

  @override
  int get _messageSpeakingIndex => messageSpeakingIndex;

  @override
  set _messageSpeakingIndex(int value) {
    _$_messageSpeakingIndexAtom.reportWrite(value, super._messageSpeakingIndex,
        () {
      super._messageSpeakingIndex = value;
    });
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_TextToSpeechBase.setLanguage', context: context);

  @override
  Future<void> setLanguage(String newLanguage) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(newLanguage));
  }

  late final _$setVolumeAsyncAction =
      AsyncAction('_TextToSpeechBase.setVolume', context: context);

  @override
  Future<void> setVolume(double newVolume) {
    return _$setVolumeAsyncAction.run(() => super.setVolume(newVolume));
  }

  late final _$setPitchAsyncAction =
      AsyncAction('_TextToSpeechBase.setPitch', context: context);

  @override
  Future<void> setPitch(double newPitch) {
    return _$setPitchAsyncAction.run(() => super.setPitch(newPitch));
  }

  late final _$setRateAsyncAction =
      AsyncAction('_TextToSpeechBase.setRate', context: context);

  @override
  Future<void> setRate(double newRate) {
    return _$setRateAsyncAction.run(() => super.setRate(newRate));
  }

  late final _$setNewVoiceTextAsyncAction =
      AsyncAction('_TextToSpeechBase.setNewVoiceText', context: context);

  @override
  Future<void> setNewVoiceText(String text) {
    return _$setNewVoiceTextAsyncAction.run(() => super.setNewVoiceText(text));
  }

  late final _$speakAsyncAction =
      AsyncAction('_TextToSpeechBase.speak', context: context);

  @override
  Future<void> speak() {
    return _$speakAsyncAction.run(() => super.speak());
  }

  late final _$speakTextAsyncAction =
      AsyncAction('_TextToSpeechBase.speakText', context: context);

  @override
  Future<void> speakText(String text, int messageSpeakingIndex) {
    return _$speakTextAsyncAction
        .run(() => super.speakText(text, messageSpeakingIndex));
  }

  late final _$autoSpeakAsyncAction =
      AsyncAction('_TextToSpeechBase.autoSpeak', context: context);

  @override
  Future<void> autoSpeak(String text, int messageSpeakingIndex) {
    return _$autoSpeakAsyncAction
        .run(() => super.autoSpeak(text, messageSpeakingIndex));
  }

  late final _$stopAsyncAction =
      AsyncAction('_TextToSpeechBase.stop', context: context);

  @override
  Future<void> stop() {
    return _$stopAsyncAction.run(() => super.stop());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
