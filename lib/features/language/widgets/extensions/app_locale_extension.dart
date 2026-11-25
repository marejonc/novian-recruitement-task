import 'package:novian_recruitement_task/i18n/i18n.dart';

extension AppLocaleExtension on AppLocale {
  /// The language name, always written in that language.
  String nameIn(Translations t) => switch (this) {
    AppLocale.pl => t.common.languages.pl.name,
    AppLocale.en => t.common.languages.en.name,
  };

  String codeIn(Translations t) => switch (this) {
    AppLocale.pl => t.common.languages.pl.code,
    AppLocale.en => t.common.languages.en.code,
  };
}
