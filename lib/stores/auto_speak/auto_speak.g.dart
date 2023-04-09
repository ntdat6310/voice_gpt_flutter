// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_speak.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AutoSpeakStore on _AutoSpeakBase, Store {
  late final _$_isAutoSpeakAtom =
      Atom(name: '_AutoSpeakBase._isAutoSpeak', context: context);

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

  late final _$_AutoSpeakBaseActionController =
      ActionController(name: '_AutoSpeakBase', context: context);

  @override
  void changeAutoSpeak(bool autoSpeak) {
    final _$actionInfo = _$_AutoSpeakBaseActionController.startAction(
        name: '_AutoSpeakBase.changeAutoSpeak');
    try {
      return super.changeAutoSpeak(autoSpeak);
    } finally {
      _$_AutoSpeakBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
