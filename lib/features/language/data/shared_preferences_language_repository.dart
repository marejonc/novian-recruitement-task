import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/language/domain/language_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LanguageRepository)
class SharedPreferencesLanguageRepository implements LanguageRepository {
  const new(this._preferences);

  static const _languageCodeKey = 'languageCode';

  final SharedPreferences _preferences;

  @override
  Future<String?> savedLanguageCode() async =>
      _preferences.getString(_languageCodeKey);

  @override
  Future<void> saveLanguageCode(String languageCode) =>
      _preferences.setString(_languageCodeKey, languageCode);
}
