import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/data/services/chat_gpt_service.dart';
import 'package:voice_gpt_flutter/modules/chat/chat_controller.dart';
import 'package:voice_gpt_flutter/modules/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/loading.dart';
import 'package:voice_gpt_flutter/modules/chat/components/regenerate_response.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = ChatController();

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
        child: Observer(
          builder: (_) => Column(
            children: [
              Expanded(child: _buildMessageList()),
              LoadingWidget(isLoading: chatController.isLoading),
              RegenerateResponseWidget(
                isShowRegenerateResponse:
                    chatController.isShowRegenerateResponse,
                onPressed: () async {
                  chatController.handleRegenerateResponseButtonPress();
                },
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
      ),
    );
  }

  ListView _buildMessageList() {
    return ListView.builder(
      itemCount: chatController.messages.length,
      itemBuilder: (context, index) {
        return ChatMessageWidget(
            content: chatController.messages[index].content,
            senderType: chatController.messages[index].senderType);
      },
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: chatController.textController,
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
      visible: !chatController.isLoading,
      child: Container(
        color: Background.botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            chatController.handleButtonSubmitClickWithAllHistory();
          },
        ),
      ),
    );
  }
}
