import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';
import 'package:voice_gpt_flutter/ui/home/components/conversation.dart';

List<ConversationModel> getConversations() {
  final List<ConversationModel> conversations = [];
  conversations.add(ConversationModel.createNew());
  conversations.add(ConversationModel.createNew());
  conversations.add(ConversationModel.createNew());
  conversations[0].messageList.add(
      MessageModel.createNew(content: "Hello 01", senderType: SenderType.user));
  conversations[1].messageList.add(
      MessageModel.createNew(content: "Hello 02", senderType: SenderType.user));
  conversations[2].messageList.add(
      MessageModel.createNew(content: "Hello 03", senderType: SenderType.user));
  return conversations;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Hello"),
            backgroundColor: Background.botBackgroundColor),
        body: Container(
          color: Background.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(conversation: null),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.add_circle, color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "New Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _buildConversationList()),
                const Divider(
                  color: Colors.white38,
                  thickness: 2,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.delete, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Clear All Conversations",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Background.backgroundColor),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.settings, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildConversationList() {
    final List<ConversationModel> conversations = getConversations();

    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return ConversationWidget(index: index);
      },
    );
  }
}
