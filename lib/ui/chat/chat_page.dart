import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:voice_gpt_flutter/data/models/conversation.dart';
import 'package:voice_gpt_flutter/data/services/local_storage_service.dart';
import 'package:voice_gpt_flutter/stores/speak_to_text/speech_to_text.dart';
import 'package:voice_gpt_flutter/stores/text_to_speech/text_to_speech.dart';
import 'package:voice_gpt_flutter/ui/chat/components/chat_message.dart';
import 'package:voice_gpt_flutter/ui/chat/components/loading.dart';
import 'package:voice_gpt_flutter/ui/chat/components/regenerate_response.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';
import 'package:voice_gpt_flutter/stores/chat/chat_store.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.conversation}) : super(key: key);
  final ConversationModel conversation;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatStore chatStore;
  late final int messageLength;
  late final SpeechToTextStore speechToTextStore;
  late final TextToSpeechStore textToSpeechStore;

  @override
  void initState() {
    speechToTextStore = SpeechToTextStore();
    textToSpeechStore = TextToSpeechStore();
    chatStore = ChatStore(
        conversation: widget.conversation,
        speechToTextStore: speechToTextStore);
    speechToTextStore.setOnSpeechResultCallback(chatStore.updateTextField);
    chatStore.setAutoSpeakCallback(textToSpeechStore.autoSpeak);
    messageLength = chatStore.conversation.messageObservable.length;
    super.initState();
  }

  @override
  void dispose() {
    // Tại sao khi nhấn back thì nó có gọi dispose
    // Nhưng khi thoát ứng dụng bằng nút overview thì lại lost connection to device
    // và không gọi dispose?
    if (messageLength != chatStore.conversation.messageObservable.length) {
      print("ChatPage - dispose..........");
      LocalStorageService.addConversation(chatStore.conversation);
      // Navigator.pop(context, chatStore.conversation);
      // Không nên để Navigator.pop ở dispose. Vì sao?
    }
    textToSpeechStore.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed(context);
        return false; // Điều này sẽ ngăn chặn việc "pop" mặc định
      },
      child: Scaffold(
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
                      _buildVoiceInputButton(),
                      _buildSubmit(),
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

  void _onBackPressed(BuildContext context) {
    // Thực hiện các thao tác khi nút Back được nhấn
    if (messageLength != chatStore.conversation.messageObservable.length) {
      // LocalStorageService.addConversation(chatStore.conversation);
      Navigator.pop(context, chatStore.conversation);
    } else {
      Navigator.pop(context, null);
    }
  }

  ListView _buildMessageList() {
    return ListView.builder(
      itemCount: chatStore.conversation.messageObservable.length,
      itemBuilder: (context, index) {
        return ChatMessageWidget(
          content: chatStore.conversation.messageObservable[index].content,
          senderType:
              chatStore.conversation.messageObservable[index].senderType,
          messageIndex: index,
          textToSpeechStore: textToSpeechStore,
        );
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

  Widget _buildVoiceInputButton() {
    return Container(
      color: Background.botBackgroundColor,
      child: IconButton(
        onPressed: () {
          print(
              "speechToTextStore.isListening ${speechToTextStore.isListening.toString()}");
          speechToTextStore.isListening
              ? speechToTextStore.stopListening()
              : speechToTextStore.startListening();
        },
        icon: speechToTextStore.isListening
            ? const Icon(Icons.mic_off, color: Colors.white)
            : const Icon(Icons.mic, color: Colors.white),
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
            color: Colors.white,
            // color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            chatStore.handleButtonSubmitClickWithAllHistory();
          },
        ),
      ),
    );
  }
}
