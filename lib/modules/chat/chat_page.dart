import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/modules/chat/components/loading.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("ChatGPT"),
        backgroundColor: Background.botBackgroundColor,
      ),
      backgroundColor: Background.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildListMessage()),
            LoadingWidget(isLoading: _isLoading),
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
}
