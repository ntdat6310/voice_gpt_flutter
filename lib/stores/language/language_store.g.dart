// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageStore on _LanguageStoreBase, Store {
  late final _$_localeAtom =
      Atom(name: '_LanguageStoreBase._locale', context: context);

  Locale get locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  Locale get _locale => locale;

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  late final _$_languageCodeAtom =
      Atom(name: '_LanguageStoreBase._languageCode', context: context);

  String get languageCode {
    _$_languageCodeAtom.reportRead();
    return super._languageCode;
  }

  @override
  String get _languageCode => languageCode;

  @override
  set _languageCode(String value) {
    _$_languageCodeAtom.reportWrite(value, super._languageCode, () {
      super._languageCode = value;
    });
  }

  late final _$_LanguageStoreBaseActionController =
      ActionController(name: '_LanguageStoreBase', context: context);

  @override
  void setLocale({required String languageCode}) {
    final _$actionInfo = _$_LanguageStoreBaseActionController.startAction(
        name: '_LanguageStoreBase.setLocale');
    try {
      return super.setLocale(languageCode: languageCode);
    } finally {
      _$_LanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
