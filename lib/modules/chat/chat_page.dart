import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/data/services/chat_gpt_service.dart';
import 'package:voice_gpt_flutter/modules/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/loading.dart';
import 'package:voice_gpt_flutter/modules/chat/components/regenerate_response.dart';
import 'package:voice_gpt_flutter/shared/constant.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late bool _isLoading;
  late bool _isShowRegenerateResponse;
  late ConversationModel _conversation;
  late final List<MessageModel> _messages;
  final _textController = TextEditingController();
  late String _textInput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
    _isShowRegenerateResponse = false;
    _conversation = ConversationModel.createNew();
    _messages = [];
  }

  void handleButtonSubmitClick() async {
    _textInput = _textController.text;
    _textController.clear();

    setState(
      () {
        _messages.add(MessageModel.createNew(
          conversationId: _conversation.id,
          content: _textInput,
          senderType: SenderType.user,
        ));
        _isLoading = true;
      },
    );

    try {
      ChatGptService chatGptService = ChatGptService();
      String response = await chatGptService.fetchChatResponse(_textInput);
      setState(() {
        _isLoading = false;
        _isShowRegenerateResponse = false;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: response,
            senderType: SenderType.bot,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isShowRegenerateResponse = true;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: "Đã có lỗi xảy ra, xin vui lòng thử lại.",
            senderType: SenderType.bot,
          ),
        );
      });
    }
  }

  void _handleRegenerateResponseButtonPress() async {
    setState(
      () {
        _isLoading = true;
        _isShowRegenerateResponse = false;
      },
    );

    try {
      ChatGptService chatGptService = ChatGptService();
      String response = await chatGptService.fetchChatResponse(_textInput);
      setState(() {
        _isLoading = false;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: response,
            senderType: SenderType.bot,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isShowRegenerateResponse = true;
      });
    }
  }

  void handleButtonSubmitClickWithAllHistory() async {
    _textInput = _textController.text;
    _textController.clear();

    setState(
          () {
        _messages.add(MessageModel.createNew(
          conversationId: _conversation.id,
          content: _textInput,
          senderType: SenderType.user,
        ));
        _isLoading = true;
      },
    );

    try {
      ChatGptService chatGptService = ChatGptService();
      String response = await chatGptService.fetchChatResponseWithAllHistory(_messages);
      setState(() {
        _isLoading = false;
        _isShowRegenerateResponse = false;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: response,
            senderType: SenderType.bot,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isShowRegenerateResponse = true;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: "Đã có lỗi xảy ra, xin vui lòng thử lại.",
            senderType: SenderType.bot,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Center(child: Text("GPT - 3.5")),
        backgroundColor: Background.botBackgroundColor,
      ),
      backgroundColor: Background.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            LoadingWidget(isLoading: _isLoading),
            RegenerateResponseWidget(
              isShowRegenerateResponse: _isShowRegenerateResponse,
              onPressed: _handleRegenerateResponseButtonPress,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildMessageList() {
    return ListView.builder(
      // controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return ChatMessageWidget(
            content: _messages[index].content,
            senderType: _messages[index].senderType);
      },
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: Background.botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !_isLoading,
      child: Container(
        color: Background.botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            handleButtonSubmitClickWithAllHistory();
          },
        ),
      ),
    );
  }
}
