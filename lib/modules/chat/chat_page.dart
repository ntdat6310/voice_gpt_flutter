import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/loading.dart';
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
  late ConversationModel _conversation;
  late final List<MessageModel> _messages;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
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
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/chat/completions");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
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
        }));

    print("Response:");
    print(response.body);
    Map<String, dynamic> newResponse = jsonDecode(response.body);

    print("newResponse:");
    print(newResponse);
    String string = newResponse['choices'][0]['message']['content'];
    final splitted = string.split("```");
    for (int i = 0; i < splitted.length; i++) {
      print("$i : ${splitted[i]}");
    }

    return newResponse['choices'][0]['message']['content'];
    // return newResponse['choices'][0]['message']['content'];
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
            Expanded(child: _buildListMessage()),
            LoadingWidget(isLoading: _isLoading),
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

  ListView _buildListMessage() {
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

            var input = _textController.text;
            _textController.clear();

            // Future.delayed(const Duration(milliseconds: 100))
            //     .then((_) => _scrollDown());

            generateResponse(input).then((value) {
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
            _textController.clear();
            // Future.delayed(const Duration(milliseconds: 100))
            //     .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }
}
