import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/stores/home/home_store.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';
import 'package:voice_gpt_flutter/ui/home/components/conversation.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeStore homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Home"),
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
                  onPressed: () async {
                    ConversationModel? newConversation = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                              conversation: homeStore.createNewConversation()),
                        ));
                    if (newConversation != null) {
                      homeStore.addConversation(newConversation);
                    }
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
                Observer(
                    builder: (_) => Expanded(
                        child: _buildConversationList(
                            conversations: homeStore.conversations))),
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

  ListView _buildConversationList(
      {required ObservableList<ConversationModel> conversations}) {
    print("_buildConversationList ${conversations.length}");
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return ConversationWidget(
          conversation: conversations[index],
        );
      },
    );
  }
}
