// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStoreBase, Store {
  late final _$_isLoadingAtom =
      Atom(name: '_ChatStoreBase._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_isShowRegenerateResponseAtom =
      Atom(name: '_ChatStoreBase._isShowRegenerateResponse', context: context);

  bool get isShowRegenerateResponse {
    _$_isShowRegenerateResponseAtom.reportRead();
    return super._isShowRegenerateResponse;
  }

  @override
  bool get _isShowRegenerateResponse => isShowRegenerateResponse;

  @override
  set _isShowRegenerateResponse(bool value) {
    _$_isShowRegenerateResponseAtom
        .reportWrite(value, super._isShowRegenerateResponse, () {
      super._isShowRegenerateResponse = value;
    });
  }

  late final _$_conversationAtom =
      Atom(name: '_ChatStoreBase._conversation', context: context);

  ConversationModel get conversation {
    _$_conversationAtom.reportRead();
    return super._conversation;
  }

  @override
  ConversationModel get _conversation => conversation;

  @override
  set _conversation(ConversationModel value) {
    _$_conversationAtom.reportWrite(value, super._conversation, () {
      super._conversation = value;
    });
  }

  late final _$textControllerAtom =
      Atom(name: '_ChatStoreBase.textController', context: context);

  @override
  TextEditingController get textController {
    _$textControllerAtom.reportRead();
    return super.textController;
  }

  @override
  set textController(TextEditingController value) {
    _$textControllerAtom.reportWrite(value, super.textController, () {
      super.textController = value;
    });
  }

  late final _$_textInputAtom =
      Atom(name: '_ChatStoreBase._textInput', context: context);

  String get textInput {
    _$_textInputAtom.reportRead();
    return super._textInput;
  }

  @override
  String get _textInput => textInput;

  @override
  set _textInput(String value) {
    _$_textInputAtom.reportWrite(value, super._textInput, () {
      super._textInput = value;
    });
  }

  late final _$handleButtonSubmitClickWithAllHistoryAsyncAction = AsyncAction(
      '_ChatStoreBase.handleButtonSubmitClickWithAllHistory',
      context: context);

  @override
  Future<void> handleButtonSubmitClickWithAllHistory() {
    return _$handleButtonSubmitClickWithAllHistoryAsyncAction
        .run(() => super.handleButtonSubmitClickWithAllHistory());
  }

  late final _$handleButtonSubmitClickAsyncAction =
      AsyncAction('_ChatStoreBase.handleButtonSubmitClick', context: context);

  @override
  Future<void> handleButtonSubmitClick() {
    return _$handleButtonSubmitClickAsyncAction
        .run(() => super.handleButtonSubmitClick());
  }

  late final _$handleRegenerateResponseButtonPressAsyncAction = AsyncAction(
      '_ChatStoreBase.handleRegenerateResponseButtonPress',
      context: context);

  @override
  Future<void> handleRegenerateResponseButtonPress() {
    return _$handleRegenerateResponseButtonPressAsyncAction
        .run(() => super.handleRegenerateResponseButtonPress());
  }

  late final _$_ChatStoreBaseActionController =
      ActionController(name: '_ChatStoreBase', context: context);

  @override
  void clearInput() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.clearInput');
    try {
      return super.clearInput();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enableLoading() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.enableLoading');
    try {
      return super.enableLoading();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disableLoading() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.disableLoading');
    try {
      return super.disableLoading();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enableShowRegenerateResponse() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.enableShowRegenerateResponse');
    try {
      return super.enableShowRegenerateResponse();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disableShowRegenerateResponse() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.disableShowRegenerateResponse');
    try {
      return super.disableShowRegenerateResponse();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void writeConversationToSQLite() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.writeConversationToSQLite');
    try {
      return super.writeConversationToSQLite();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addUserMessageToList() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.addUserMessageToList');
    try {
      return super.addUserMessageToList();
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBotMessageToList(String botMessage) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.addBotMessageToList');
    try {
      return super.addBotMessageToList(botMessage);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textController: ${textController}
    ''';
  }
}
