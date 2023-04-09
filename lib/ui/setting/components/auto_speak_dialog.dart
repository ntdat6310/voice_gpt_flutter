import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/shared/enum.dart';
import 'package:voice_gpt_flutter/shared/styles/background.dart';

class AutoSpeakDialog extends StatelessWidget {
  const AutoSpeakDialog({Key? key, required this.initialStatus})
      : super(key: key);
  final bool initialStatus;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Auto Speak Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Enable'),
            onTap: () {
              Navigator.pop(context, AutoSpeakStatus.enable);
            },
          ),
          ListTile(
            title: const Text('Disable'),
            onTap: () {
              Navigator.pop(context, AutoSpeakStatus.disable);
            },
          ),
        ],
      ),
    );
  }
}
