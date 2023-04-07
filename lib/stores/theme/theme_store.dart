// import 'package:mobx/mobx.dart';
// import 'package:voice_gpt_flutter/data/shared_preferences/shared_preference_helper.dart';
//
// part 'theme_store.g.dart';
//
// class ThemeStore = _ThemeStoreBase with _$ThemeStore;
//
// abstract class _ThemeStoreBase with Store {
//   // store variables:-----------------------------------------------------------
//   @readonly
//   bool _darkMode = false;
//
//   // actions:-------------------------------------------------------------------
//   @action
//   Future<void> changeBrightnessToDark({required bool isDarkMode}) async {
//     _darkMode = isDarkMode;
//     await SharedPreferenceHelper.changeLightToDark(isDarkMode: isDarkMode);
//   }
// }
