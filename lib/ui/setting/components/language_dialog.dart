import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  static const Map<String, String> languagesSupport = {
    "en": "English",
    "vi": "Tiếng Việt",
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.system_language),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          itemCount: languagesSupport.length,
          itemBuilder: (BuildContext context, int index) {
            final String languageKey = languagesSupport.keys.elementAt(index);
            final String? languageValue = languagesSupport[languageKey];

            return ListTile(
              title: Text(languageValue ?? ''),
              onTap: () {
                Navigator.pop(context, languageKey);
              },
            );
          },
        ),
      ),
    );
  }
}
