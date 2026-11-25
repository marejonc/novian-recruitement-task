abstract interface class LanguageRepository {
  /// The language code the user picked, or `null` before the first pick.
  Future<String?> savedLanguageCode();

  Future<void> saveLanguageCode(String languageCode);
}
