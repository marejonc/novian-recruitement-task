import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/language/domain/language_repository.dart';

@injectable
class SaveLanguageCodeUseCase {
  const new(this._languageRepository);

  final LanguageRepository _languageRepository;

  Future<void> call(String languageCode) =>
      _languageRepository.saveLanguageCode(languageCode);
}
