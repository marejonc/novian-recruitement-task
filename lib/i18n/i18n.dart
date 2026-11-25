import 'package:novian_recruitement_task/i18n/translations.g.dart';

export 'package:novian_recruitement_task/i18n/translations.g.dart';

/// Locales are lazy-loaded, so await this before `runApp`.
Future<void> initTranslations({AppLocale locale = AppLocale.pl}) =>
    LocaleSettings.setLocale(locale);
