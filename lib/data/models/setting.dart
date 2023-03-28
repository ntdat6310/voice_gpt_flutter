enum LanguageType { vietnamese, english }

class SettingModel {
  final String language;
  final bool autoSpeak;

  SettingModel({
    required this.autoSpeak,
    required this.language,
  });
}
