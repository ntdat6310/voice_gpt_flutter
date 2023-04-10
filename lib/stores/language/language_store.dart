import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStoreBase with _$LanguageStore;

abstract class _LanguageStoreBase with Store {
  @readonly
  late Locale _locale;

  @readonly
  late String _languageCode;
  Function? onLocaleChanged;

  void setOnLocaleChanged(Function callback){
    onLocaleChanged = callback;
  }

  _LanguageStoreBase()
      : _locale = Locale.fromSubtags(
            languageCode: SharedPreferenceHelper.currentLanguage ?? "en"),
        _languageCode = SharedPreferenceHelper.currentLanguage ?? "en" {
    reaction((_) => _locale, (_) {
      print("LanguageStore ${_locale.languageCode.toString()}");
      if(onLocaleChanged !=null){
        onLocaleChanged!();
      }
    });
  }

  @action
  void setLocale({required String languageCode}) {
    SharedPreferenceHelper.changeLanguage(languageCode: languageCode);
    _locale = Locale.fromSubtags(languageCode: languageCode);
    _languageCode = languageCode;
  }
}
