import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/ui/chat/chat_page.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({Key? key, required this.conversation})
      : super(key: key);
  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ChatPage(conversation: conversation);
        }));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Background.backgroundColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
        elevation: MaterialStateProperty.all(0),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          const int iconDeleteButtonWidth = 24 + 32; // Icon size + padding
          final textMaxWidth = constraints.maxWidth - iconDeleteButtonWidth;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: textMaxWidth,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 24,
                    ), // Icon message
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        conversation.messageObservable.isNotEmpty
                            ? conversation.messageObservable[0].content
                            : "", // Message title
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 1, // Giới hạn chỉ hiển thị 1 dòng
                        overflow: TextOverflow
                            .ellipsis, // Thêm "..." nếu vượt quá giới hạn
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  print("delete icon clicked");
                },
                icon: const Icon(
                  Icons.delete,
                  size: 24,
                ),
                color: Colors.white,
              ), // Icon delete
            ],
          );
        },
      ),
    );
  }
}
