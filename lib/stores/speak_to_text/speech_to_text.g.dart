// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_to_text.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpeechToTextStore on _SpeechToTextBase, Store {
  late final _$_speechEnabledAtom =
      Atom(name: '_SpeechToTextBase._speechEnabled', context: context);

  bool get speechEnabled {
    _$_speechEnabledAtom.reportRead();
    return super._speechEnabled;
  }

  @override
  bool get _speechEnabled => speechEnabled;

  @override
  set _speechEnabled(bool value) {
    _$_speechEnabledAtom.reportWrite(value, super._speechEnabled, () {
      super._speechEnabled = value;
    });
  }

  late final _$_lastWordsAtom =
      Atom(name: '_SpeechToTextBase._lastWords', context: context);

  String get lastWords {
    _$_lastWordsAtom.reportRead();
    return super._lastWords;
  }

  @override
  String get _lastWords => lastWords;

  @override
  set _lastWords(String value) {
    _$_lastWordsAtom.reportWrite(value, super._lastWords, () {
      super._lastWords = value;
    });
  }

  late final _$_isListeningAtom =
      Atom(name: '_SpeechToTextBase._isListening', context: context);

  bool get isListening {
    _$_isListeningAtom.reportRead();
    return super._isListening;
  }

  @override
  bool get _isListening => isListening;

  @override
  set _isListening(bool value) {
    _$_isListeningAtom.reportWrite(value, super._isListening, () {
      super._isListening = value;
    });
  }

  late final _$_initSpeechAsyncAction =
      AsyncAction('_SpeechToTextBase._initSpeech', context: context);

  @override
  Future<void> _initSpeech() {
    return _$_initSpeechAsyncAction.run(() => super._initSpeech());
  }

  late final _$startListeningAsyncAction =
      AsyncAction('_SpeechToTextBase.startListening', context: context);

  @override
  Future<void> startListening() {
    return _$startListeningAsyncAction.run(() => super.startListening());
  }

  late final _$stopListeningAsyncAction =
      AsyncAction('_SpeechToTextBase.stopListening', context: context);

  @override
  Future<void> stopListening() {
    return _$stopListeningAsyncAction.run(() => super.stopListening());
  }

  late final _$_SpeechToTextBaseActionController =
      ActionController(name: '_SpeechToTextBase', context: context);

  @override
  void _onSpeechResult(SpeechRecognitionResult result) {
    final _$actionInfo = _$_SpeechToTextBaseActionController.startAction(
        name: '_SpeechToTextBase._onSpeechResult');
    try {
      return super._onSpeechResult(result);
    } finally {
      _$_SpeechToTextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
