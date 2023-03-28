import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {Key? key, required this.content, required this.senderType})
      : super(key: key);
  final String content;
  final SenderType senderType;

  Container _buildBotIcon() {
    return Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/icons/icon_bot.png')));
  }

  Container _buildUserIcon() {
    return Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/icons/icon_user.png')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      color: senderType == SenderType.bot
          ? Background.botBackgroundColor
          : Background.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          senderType == SenderType.bot ? _buildBotIcon() : _buildUserIcon(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
