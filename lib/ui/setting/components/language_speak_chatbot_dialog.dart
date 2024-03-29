import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSpeakChatBotDialog extends StatelessWidget {
  const LanguageSpeakChatBotDialog({Key? key, required this.languages})
      : super(key: key);
  final List<dynamic> languages;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.select_robot_language),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5, // Giới hạn chiều cao của nội dung
        width: MediaQuery.of(context).size.width * 0.8, // Giới hạn chiều rộng của nội dung
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(languages[index].toString()),
              onTap: () {
                Navigator.pop(context, languages[index].toString());
              },
            );
          },
        ),
      ),
    );
  }
}
