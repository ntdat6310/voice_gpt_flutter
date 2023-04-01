import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/conversation.dart';
import '../../data/models/message.dart';
import '../../data/services/chat_gpt_service.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  @readonly
  bool _isLoading = false;

  @readonly
  bool _isShowRegenerateResponse = false;

  @readonly
  // Do not make it final => Build failed
  // MobX will automatically monitor changes to these
  // and update the interface as needed.
  ConversationModel _conversation = ConversationModel.createNew();

  @readonly
  // Do not make it final => Build failed
  List<MessageModel> _messages = [];

  @observable
  TextEditingController textController = TextEditingController();

  @readonly
  String _textInput = '';

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
    _messages.add(MessageModel.createNew(
      conversationId: _conversation.id,
      content: _textInput,
      senderType: SenderType.user,
    ));
  }

  @action
  void addBotMessageToList(String botMessage) {
    _messages.add(
      MessageModel.createNew(
        conversationId: _conversation.id,
        content: botMessage,
        senderType: SenderType.bot,
      ),
    );
  }

  @action
  Future<void> handleButtonSubmitClickWithAllHistory() async {
    clearInput();
    addUserMessageToList();
    enableLoading();
    try {
      ChatGptService chatGptService = ChatGptService();
      String botMessage =
          await chatGptService.fetchChatResponseWithAllHistory(_messages);
      disableLoading();
      disableShowRegenerateResponse();
      addBotMessageToList(botMessage);
    } catch (e) {
      disableLoading();
      enableShowRegenerateResponse();
      addBotMessageToList("Đã có lỗi xảy ra, xin vui lòng thử lại.");
    }
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
    } catch (e) {
      disableLoading();
      enableShowRegenerateResponse();
    }
  }
}
