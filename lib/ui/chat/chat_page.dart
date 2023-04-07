import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/ui/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/ui/chat/components/loading.dart';
import 'package:voice_gpt_flutter/ui/chat/components/regenerate_response.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/stores/chat/chat_store.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.conversation}) : super(key: key);
  final ConversationModel? conversation;
  final ChatStore chatStore = ChatStore(conversation: null);

  // Tìm hiểu xem khi widget này bị gỡ khỏi stack thì gọi method nào
  // Từ đó gọi hàm write vào local storage (Hive)

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
              LoadingWidget(isLoading: chatStore.isLoading),
              RegenerateResponseWidget(
                isShowRegenerateResponse: chatStore.isShowRegenerateResponse,
                onPressed: () async {
                  chatStore.handleRegenerateResponseButtonPress();
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
      itemCount: chatStore.conversation.messages.length,
      itemBuilder: (context, index) {
        return ChatMessageWidget(
            content: chatStore.conversation.messages[index].content,
            senderType: chatStore.conversation.messages[index].senderType);
      },
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: chatStore.textController,
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
      visible: !chatStore.isLoading,
      child: Container(
        color: Background.botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            chatStore.handleButtonSubmitClickWithAllHistory();
          },
        ),
      ),
    );
  }
}
