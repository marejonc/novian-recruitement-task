import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/user/bloc/users_cubit.dart';
import 'package:novian_recruitement_task/features/user/domain/extensions/user_extension.dart';
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
  const new(this.users, this.sessionChoices);

  final UsersCubit users;
  final SessionChoicesCubit sessionChoices;
}

/// Combines the selected backend user with the live session choices. Every
/// change of either — picking another user or other breathing parameters —
/// emits a new [SummaryLoaded]; loading and errors mirror the users cubit.
@injectable
class SummaryCubit extends Cubit<SummaryState> {
  new(@factoryParam SummaryCubitDeps deps)
    : _users = deps.users,
      _sessionChoices = deps.sessionChoices,
      super(const SummaryLoading()) {
    _sub = Rx.combineLatest2(
      _users.observe(),
      _sessionChoices.observe(),
      _toSummary,
    ).distinct().listen(emit);
  }

  final UsersCubit _users;
  final SessionChoicesCubit _sessionChoices;
  late final StreamSubscription<SummaryState> _sub;

  /// Fetches the users again after a failed load.
  void retry() => _users.load();

  SummaryState _toSummary(UsersState users, SessionChoices choices) =>
      switch (users) {
        UsersLoading() => const SummaryLoading(),
        UsersError(:final error) => SummaryError(error),
        UsersLoaded(:final selectedUser) => SummaryLoaded(
          user: selectedUser,
          age: selectedUser.ageAt(DateTime.now()),
          choices: choices,
        ),
      };

  @override
  Future<void> close() {
    unawaited(_sub.cancel());
    return super.close();
  }
}
