import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/services/local_storage_service.dart';
import 'package:voice_gpt_flutter/stores/speak_to_text/speech_to_text.dart';

import '../../data/models/conversation.dart';
import '../../data/models/message.dart';
import '../../data/services/chat_gpt_service.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  late SpeechToTextStore _speechToTextStore;

  Function? _autoSpeakCallback;
  void setAutoSpeakCallback(Function callback) {
    _autoSpeakCallback = callback;
  }

  @readonly
  bool _isLoading = false;

  @readonly
  bool _isShowRegenerateResponse = false;

  @readonly
  // Do not make it final => Build failed
  // MobX will automatically monitor changes to these
  // and update the interface as needed.
  late ConversationModel _conversation;

  _ChatStoreBase(
      {required ConversationModel conversation,
      required SpeechToTextStore speechToTextStore})
      : _conversation = conversation,
        _speechToTextStore = speechToTextStore;

  @observable
  TextEditingController textController = TextEditingController();

  @readonly
  String _textInput = '';

  @action
  void updateTextField() {
    textController.text = _speechToTextStore.lastWords;
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _speechToTextStore.lastWords.length));
  }

  @action
  void clearInput() {
    _textInput = textController.text;
    textController.clear();
  }

  @action
  void enableLoading() {
    _isLoading = true;
  }

  @action
  void disableLoading() {
    _isLoading = false;
  }

  @action
  void enableShowRegenerateResponse() {
    _isShowRegenerateResponse = true;
  }

  @action
  void disableShowRegenerateResponse() {
    _isShowRegenerateResponse = false;
  }

  @action
  void addUserMessageToList() {
    _conversation.messageObservable.add(MessageModel.createNew(
      content: _textInput,
      senderType: SenderType.user,
    ));
  }

  @action
  void addBotMessageToList(String botMessage) {
    _conversation.messageObservable.add(
      MessageModel.createNew(
        content: botMessage,
        senderType: SenderType.bot,
      ),
    );
    if (_autoSpeakCallback != null) {
      _autoSpeakCallback!(
          botMessage, _conversation.messageObservable.length - 1);
    }
  }

  @action
  Future<void> handleButtonSubmitClickWithAllHistory() async {
    clearInput();
    addUserMessageToList();
    enableLoading();
    try {
      ChatGptService chatGptService = ChatGptService();
      String botMessage = await chatGptService
          .fetchChatResponseWithAllHistory(_conversation.messageObservable);
      disableLoading();
      disableShowRegenerateResponse();
      addBotMessageToList(botMessage);
    } catch (e) {
      disableLoading();
      enableShowRegenerateResponse();
      addBotMessageToList("Đã có lỗi xảy ra, xin vui lòng thử lại.");
    }
    LocalStorageService.addConversation(_conversation);
  }

  @action
  Future<void> handleButtonSubmitClick() async {
    clearInput();
    addUserMessageToList();
    enableLoading();

    try {
      ChatGptService chatGptService = ChatGptService();
      String botMessage = await chatGptService.fetchChatResponse(_textInput);
      disableLoading();
      disableShowRegenerateResponse();
      addBotMessageToList(botMessage);
    } catch (e) {
      disableLoading();
      enableShowRegenerateResponse();
      addBotMessageToList("Đã có lỗi xảy ra, xin vui lòng thử lại.");
    }

    LocalStorageService.addConversation(_conversation);
  }

  @action
  Future<void> handleRegenerateResponseButtonPress() async {
    enableLoading();
    disableShowRegenerateResponse();
    try {
      ChatGptService chatGptService = ChatGptService();
      String botMessage = await chatGptService.fetchChatResponse(_textInput);
      disableLoading();
      addBotMessageToList(botMessage);
      LocalStorageService.addConversation(_conversation);
    } catch (e) {
      disableLoading();
      enableShowRegenerateResponse();
    }
  }
}
