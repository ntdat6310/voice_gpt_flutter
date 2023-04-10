// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot_speaking_language.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatBotSpeakingLanguageStore on _ChatBotSpeakingLanguageBase, Store {
  late final _$_chatBotSpeakingLanguageAtom = Atom(
      name: '_ChatBotSpeakingLanguageBase._chatBotSpeakingLanguage',
      context: context);

  String get chatBotSpeakingLanguage {
    _$_chatBotSpeakingLanguageAtom.reportRead();
    return super._chatBotSpeakingLanguage;
  }

  @override
  String get _chatBotSpeakingLanguage => chatBotSpeakingLanguage;

  @override
  set _chatBotSpeakingLanguage(String value) {
    _$_chatBotSpeakingLanguageAtom
        .reportWrite(value, super._chatBotSpeakingLanguage, () {
      super._chatBotSpeakingLanguage = value;
    });
  }

  late final _$_ChatBotSpeakingLanguageBaseActionController =
      ActionController(name: '_ChatBotSpeakingLanguageBase', context: context);

  @override
  void changeChatBotSpeakingLanguage(String chatBotSpeakingLanguage) {
    final _$actionInfo =
        _$_ChatBotSpeakingLanguageBaseActionController.startAction(
            name: '_ChatBotSpeakingLanguageBase.changeChatBotSpeakingLanguage');
    try {
      return super.changeChatBotSpeakingLanguage(chatBotSpeakingLanguage);
    } finally {
      _$_ChatBotSpeakingLanguageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
