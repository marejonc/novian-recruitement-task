import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: OnboardingRepository)
class SharedPreferencesOnboardingRepository implements OnboardingRepository {
  const new(this._preferences);

  static const _hasCompletedOnboardingKey = 'hasCompletedOnboarding';

  final SharedPreferences _preferences;

  @override
  Future<bool> hasCompletedOnboarding() async =>
      _preferences.getBool(_hasCompletedOnboardingKey) ?? false;

  @override
  Future<void> completeOnboarding() =>
      _preferences.setBool(_hasCompletedOnboardingKey, true);
}
