import 'package:novian_recruitement_task/i18n/translations.g.dart';

// The global `t` is hidden: it does not rebuild widgets when the language
// changes. Widgets read `context.t` instead.
export 'package:novian_recruitement_task/i18n/translations.g.dart' hide t;

/// The language the app starts in before the user picks one.
const AppLocale defaultLocale = AppLocale.en;

Future<void> initTranslations({String? languageCode}) {
  final locale = AppLocale.values
      .where((locale) => locale.languageCode == languageCode)
      .firstOrNull;
  return LocaleSettings.setLocale(locale ?? defaultLocale);
}
