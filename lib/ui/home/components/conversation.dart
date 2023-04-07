import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Background.backgroundColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
        elevation: MaterialStateProperty.all(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 24,
              ), // Icon message
              SizedBox(width: 12),
              Text(
                'Message Title', // Message title
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
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
      ),
    );
  }
}
