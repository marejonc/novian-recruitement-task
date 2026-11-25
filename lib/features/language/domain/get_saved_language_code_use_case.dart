import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/language/domain/language_repository.dart';

@injectable
class GetSavedLanguageCodeUseCase {
  const new(this._languageRepository);

  final LanguageRepository _languageRepository;

  Future<String?> call() => _languageRepository.savedLanguageCode();
}
