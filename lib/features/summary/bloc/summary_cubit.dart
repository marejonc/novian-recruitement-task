import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/user/domain/extensions/user_extension.dart';
import 'package:novian_recruitement_task/features/user/domain/get_user_use_case.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:single_value_cubit/single_value_cubit.dart';

part 'summary_cubit.g.dart';

sealed class SummaryState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

class SummaryLoading extends SummaryState {
  const new();
}

@CopyWith()
class SummaryLoaded extends SummaryState {
  const new({
    required this.user,
    required this.age,
    required this.choices,
  });

  final User user;
  final int age;
  final SessionChoices choices;

  @override
  List<Object?> get props => [user, age, choices];
}

class SummaryError extends SummaryState {
  const new(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

class SummaryCubitDeps {
  const new(this.sessionChoices);

  final SessionChoicesCubit sessionChoices;
}

/// Combines the backend user with the live session choices. The user is
/// fetched once per [load]; every later change of the choices emits a new
/// [SummaryLoaded] without refetching.
@injectable
class SummaryCubit extends Cubit<SummaryState> {
  new(this._getUser, @factoryParam SummaryCubitDeps deps)
    : _sessionChoices = deps.sessionChoices,
      super(const SummaryLoading());

  final GetUserUseCase _getUser;
  final SessionChoicesCubit _sessionChoices;
  StreamSubscription<SummaryState>? _sub;

  void load() {
    unawaited(_sub?.cancel());
    _sub = _load().listen(emit);
  }

  Stream<SummaryState> _load() =>
      Rx.fromCallable(_getUser.call)
          .switchMap((user) {
            final age = user.ageAt(DateTime.now());
            return _sessionChoices.observe().map<SummaryState>(
              (choices) =>
                  SummaryLoaded(user: user, age: age, choices: choices),
            );
          })
          .onErrorReturnWith((error, stackTrace) {
            addError(error, stackTrace);
            return SummaryError(error);
          })
          .startWith(const SummaryLoading());

  @override
  Future<void> close() {
    unawaited(_sub?.cancel());
    return super.close();
  }
}
