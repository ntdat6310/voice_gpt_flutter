import 'package:flutter/material.dart';
import 'package:voice_gpt_flutter/shared/enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AutoSpeakDialog extends StatelessWidget {
  const AutoSpeakDialog({Key? key, required this.initialStatus})
      : super(key: key);
  final bool initialStatus;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.auto_speak_setting),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.enable),
            onTap: () {
              Navigator.pop(context, AutoSpeakStatus.enable);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.disable),
            onTap: () {
              Navigator.pop(context, AutoSpeakStatus.disable);
            },
          ),
        ],
      ),
    );
  }
}
