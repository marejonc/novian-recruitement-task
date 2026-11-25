import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_repository.dart';

@injectable
class CompleteOnboardingUseCase {
  const new(this._onboardingRepository);

  final OnboardingRepository _onboardingRepository;

  Future<void> call() => _onboardingRepository.completeOnboarding();
}
