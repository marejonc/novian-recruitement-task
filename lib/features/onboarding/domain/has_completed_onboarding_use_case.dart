import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_repository.dart';

@injectable
class HasCompletedOnboardingUseCase {
  const new(this._onboardingRepository);

  final OnboardingRepository _onboardingRepository;

  Future<bool> call() => _onboardingRepository.hasCompletedOnboarding();
}
