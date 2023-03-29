import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
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
  late bool _isResponseSuccess;
  late ConversationModel _conversation;
  late final List<MessageModel> _messages;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  late String _textInput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
    _isResponseSuccess = true;
    _conversation = ConversationModel.createNew();
    _messages = [];
    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 1",
        senderType: SenderType.user));

    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 2",
        senderType: SenderType.bot));

    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 3",
        senderType: SenderType.user));

    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 4",
        senderType: SenderType.bot));

    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 5",
        senderType: SenderType.user));

    _messages.add(MessageModel.createNew(
        conversationId: _conversation.id,
        content: "This is message 6",
        senderType: SenderType.bot));
  }

  Future<String> generateResponse(String content) async {
    // const apiKey = apiSecretKey;
    const apiKey = apiSecretKeyForErrorTest;
    var url = Uri.https("api.openai.com", "/v1/chat/completions");

    // Follow OpenAI's document
    // https://platform.openai.com/docs/guides/chat/introduction
    // https://platform.openai.com/docs/api-reference/chat
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": content,
          }
        ],
        'temperature': 0,
        'max_tokens': 1000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Response success
    if (response.statusCode == 200) {
      setState(() {
        _isResponseSuccess = true;
      });
      // Decode response from API using UTF-8 format.
      String responseBody = utf8.decode(response.bodyBytes);

      // Convert JSON String to Map<String, dynamic>
      Map<String, dynamic> newResponse = jsonDecode(responseBody);

      // This format is follow by OpenAI's document
      return newResponse['choices'][0]['message']['content'];
    }
    // Response Failed
    else {
      setState(() {
        _isResponseSuccess = false;
      });
      debugPrint("Error: Response failed - ${response.statusCode}");
      debugPrint("Response: ${response.body}");
      return 'Đã có lỗi xảy ra, vui lòng thử lại.';
    }
  }

  void _handleRegenerateResponseButtonPress() async {
    setState(
      () {
        _isLoading = true;
      },
    );

    generateResponse(_textInput).then((value) {
      setState(() {
        _isLoading = false;
        _messages.add(
          MessageModel.createNew(
            conversationId: _conversation.id,
            content: value,
            senderType: SenderType.bot,
          ),
        );
      });
    });
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
              isResponseSuccess: _isResponseSuccess,
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

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
            setState(
              () {
                _messages.add(MessageModel.createNew(
                  conversationId: _conversation.id,
                  content: _textController.text,
                  senderType: SenderType.user,
                ));
                _isLoading = true;
              },
            );

            _textInput = _textController.text;
            _textController.clear();

            generateResponse(_textInput).then((value) {
              setState(() {
                _isLoading = false;
                _messages.add(
                  MessageModel.createNew(
                    conversationId: _conversation.id,
                    content: value,
                    senderType: SenderType.bot,
                  ),
                );
              });
            });
          },
        ),
      ),
    );
  }
}
