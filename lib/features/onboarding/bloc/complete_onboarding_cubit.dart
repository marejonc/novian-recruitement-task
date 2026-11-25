import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/complete_onboarding_use_case.dart';
import 'package:rxdart/rxdart.dart';

sealed class CompleteOnboardingState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

class CompleteOnboardingIdle extends CompleteOnboardingState {
  const new();
}

class CompleteOnboardingInProgress extends CompleteOnboardingState {
  const new();
}

class CompleteOnboardingSuccess extends CompleteOnboardingState {
  const new();
}

class CompleteOnboardingError extends CompleteOnboardingState {
  const new(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

/// Persists the first-launch flag; the page navigates on
/// [CompleteOnboardingSuccess].
@injectable
class CompleteOnboardingCubit extends Cubit<CompleteOnboardingState> {
  new(this._completeOnboarding) : super(const CompleteOnboardingIdle());

  final CompleteOnboardingUseCase _completeOnboarding;

  StreamSubscription<CompleteOnboardingState>? _sub;

  void complete() {
    unawaited(_sub?.cancel());
    _sub = _complete().listen(emit);
  }

  Stream<CompleteOnboardingState> _complete() =>
      Rx.fromCallable(_completeOnboarding.call)
          .map<CompleteOnboardingState>(
            (_) => const CompleteOnboardingSuccess(),
          )
          .onErrorReturnWith((error, stackTrace) {
            addError(error, stackTrace);
            return CompleteOnboardingError(error);
          })
          .startWith(const CompleteOnboardingInProgress());

  @override
  Future<void> close() {
    unawaited(_sub?.cancel());
    return super.close();
  }
}
