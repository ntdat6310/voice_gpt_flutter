import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:voice_gpt_flutter/data/models/message.dart';
import 'package:voice_gpt_flutter/stores/text_to_speech/text_to_speech.dart';
import 'package:voice_gpt_flutter/ui/chat/components/code_view.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'dart:core';

class ChatMessageWidget extends StatefulWidget {
  const ChatMessageWidget({
    Key? key,
    required this.content,
    required this.senderType,
    required this.messageIndex,
    required this.textToSpeechStore,
  }) : super(key: key);
  final String content;
  final SenderType senderType;
  final int messageIndex;
  final TextToSpeechStore textToSpeechStore;

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

/// If it's odd, it's the code block.
/// Using CodeView to render.
bool _isOdd(int number) {
  return number % 2 != 0;
}

List<String> _replaceDoubleNewline(List<String> strings) {
  return strings.map((string) {
    return string.replaceAll('\n\n', '\n');
  }).toList();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  late final List newContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newContent = _replaceDoubleNewline(widget.content.split("```"));
  }

  Container _buildBotIcon() {
    return Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/icons/icon_bot.png')),
          ],
        ));
  }

  Container _buildUserIcon() {
    return Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/icons/icon_user.png')));
  }

  IconButton _buildSpeakButton() {
    return IconButton(
        onPressed: () async {
          if (widget.textToSpeechStore.isPlaying &&
              widget.textToSpeechStore.messageSpeakingIndex == widget.messageIndex) {
            await widget.textToSpeechStore.stop();
          } else {
            await widget.textToSpeechStore
                .speakText(widget.content, widget.messageIndex);
          }
        },
        icon: _buildIcon());
  }

  Icon _buildIcon(){
    return widget.textToSpeechStore.isPlaying &&
        widget.textToSpeechStore.messageSpeakingIndex == widget.messageIndex
        ? const Icon(Icons.stop_circle_outlined, color: Colors.white)
        : const Icon(Icons.play_circle_outline, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: widget.senderType == SenderType.bot
          ? Background.botBackgroundColor
          : Background.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.senderType == SenderType.bot
              ? _buildBotIcon()
              : _buildUserIcon(),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(newContent.length, (index) {
                  if (_isOdd(index)) {
                    return CodeViewWidget(code: newContent[index]);
                  } else {
                    return Text(
                      newContent[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    );
                  }
                })),
          ),
          Visibility(
            visible: widget.senderType == SenderType.bot,
            child: Observer(builder: (_) => _buildSpeakButton()),
          ),
        ],
      ),
    );
  }
}
