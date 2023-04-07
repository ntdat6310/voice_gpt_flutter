enum LanguageType { vietnamese, english }
enum ThemeType {lightMode, darkMode}

class SettingModel {
  final String language;
  final bool autoSpeak;
  final String theme;

  SettingModel({
    required this.autoSpeak,
    required this.language,
    required this.theme,
  });
}
