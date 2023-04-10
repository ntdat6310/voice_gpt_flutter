import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/stores/home/home_store.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';
import 'package:voice_gpt_flutter/ui/home/components/conversation.dart';
import 'package:voice_gpt_flutter/ui/setting/setting_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../stores/language/language_store.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.languageStore}) : super(key: key);

  final LanguageStore languageStore;
  final HomeStore homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.home),
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
                    children:  [
                      const SizedBox(width: 8),
                      const Icon(Icons.add_circle, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.new_chat,
                        style: const TextStyle(
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
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.delete, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.clear_all_conversations,
                        style: const TextStyle(
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SettingPage(languageStore: languageStore);
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.settings, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.setting,
                        style: const TextStyle(
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

  Future<void> _showConfirmationDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Warning',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content:
              const Text('Are you sure you want to delete all conversation'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes, do it!'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (result != null && result) {
      homeStore.deleteAllConversations();
    } else {}
  }

  ListView _buildConversationList(
      {required ObservableList<ConversationModel> conversations}) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return ConversationWidget(
          conversation: conversations[index],
          deleteConversation: homeStore.deleteConversation,
        );
      },
    );
  }
}
