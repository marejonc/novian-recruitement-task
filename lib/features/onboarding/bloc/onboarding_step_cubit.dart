import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_step.dart';
import 'package:single_value_cubit/single_value_cubit.dart';

/// The onboarding step on screen; starts with the language choice.
@injectable
class OnboardingStepCubit extends SingleValueCubit<OnboardingStep> {
  new() : super(OnboardingStep.language);
}
