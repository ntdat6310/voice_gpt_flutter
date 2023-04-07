import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/constants/preferences.dart';

class SharedPreferenceHelper {
  // Private constructor
  SharedPreferenceHelper._internal();

  // Singleton instance
  static final SharedPreferenceHelper _instance =
      SharedPreferenceHelper._internal();

  // SharedPreferences instance
  late final SharedPreferences _sharedPreferences;

  // Check whether init() is called before SharedPreferenceHelper is used
  bool _isInitialized = false;

  // Factory constructor
  factory SharedPreferenceHelper() {
    return _instance;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  void _checkInitialization() {
    if (!_isInitialized) {
      throw Exception(
          'SharedPreferenceHelper must be initialized before use. Call init() first.');
    }
  }

  // Theme:------------------------------------------------------
  static bool get isDarkMode {
    _instance._checkInitialization();
    return _instance._sharedPreferences.getBool(Preferences.isDarkMode) ??
        false;
  }

  static Future<void> changeLightToDark({required bool isDarkMode}) {
    _instance._checkInitialization();
    return _instance._sharedPreferences
        .setBool(Preferences.isDarkMode, isDarkMode);
  }

  // Language:---------------------------------------------------
  static String? get currentLanguage {
    _instance._checkInitialization();
    return _instance._sharedPreferences.getString(Preferences.currentLanguage);
  }

  static Future<void> changeLanguage({required String language}) {
    _instance._checkInitialization();
    return _instance._sharedPreferences
        .setString(Preferences.currentLanguage, language);
  }

  // Auto Speak:--------------------------------------------------
  static bool get autoSpeak {
    _instance._checkInitialization();
    return _instance._sharedPreferences.getBool(Preferences.autoSpeak) ?? false;
  }

  static Future<void> changeAutoSpeak({required bool isAutoSpeak}) {
    _instance._checkInitialization();
    return _instance._sharedPreferences
        .setBool(Preferences.autoSpeak, isAutoSpeak);
  }
}
