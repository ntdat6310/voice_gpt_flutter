class Language {
  /// the country code (IT,AF..)
  late String code;

  /// the locale (en, es, da)
  late String locale;

  /// the full name of language (English, Danish..)
  late String language;

  /// map of keys used based on industry type (service worker, route etc)
  late Map<String, String> dictionary;

  Language({
    required this.code,
    required this.locale,
    required this.language,
    required this.dictionary,
  });
}
