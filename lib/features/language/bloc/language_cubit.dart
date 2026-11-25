import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/language/domain/save_language_code_use_case.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:rxdart/rxdart.dart';
import 'package:single_value_cubit/single_value_cubit.dart';

/// The app language, provided above the router so onboarding and the
/// session flow share it. Selecting a language switches the slang locale
/// (which rebuilds every `context.t` reader) and persists the choice.
@injectable
class LanguageCubit extends SingleValueCubit<AppLocale> {
  new(this._saveLanguageCode) : super(LocaleSettings.currentLocale);

  final SaveLanguageCodeUseCase _saveLanguageCode;

  StreamSubscription<void>? _saveSub;

  void select(AppLocale locale) {
    if (locale == state) return;
    set(locale);
    unawaited(LocaleSettings.setLocale(locale));
    unawaited(_saveSub?.cancel());
    _saveSub = Rx.fromCallable(() => _saveLanguageCode(locale.languageCode))
        .onErrorReturnWith(addError)
        .listen(null);
  }

  @override
  Future<void> close() {
    unawaited(_saveSub?.cancel());
    return super.close();
  }
}
