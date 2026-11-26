import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/user/domain/get_users_use_case.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:rxdart/rxdart.dart';

part 'users_cubit.g.dart';

sealed class UsersState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {
  const new();
}

@CopyWith()
class UsersLoaded extends UsersState {
  const new({
    required this.users,
    required this.selectedUser,
  });

  final List<User> users;
  final User selectedUser;

  @override
  List<Object?> get props => [users, selectedUser];
}

class UsersError extends UsersState {
  const new(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}

/// The users from the backend and which of them the session is for. The
/// single source of truth for the selected user, shared by the session and
/// the summary screen. The first user is selected once the list arrives.
@injectable
class UsersCubit extends Cubit<UsersState> {
  new(this._getUsers) : super(const UsersLoading());

  final GetUsersUseCase _getUsers;
  StreamSubscription<UsersState>? _sub;

  void load() {
    unawaited(_sub?.cancel());
    _sub = Rx.fromCallable(_getUsers.call)
        .map<UsersState>(
          (users) => switch (users) {
            [final firstUser, ...] => UsersLoaded(
              users: users,
              selectedUser: firstUser,
            ),
            [] => UsersError(StateError('The backend returned no users')),
          },
        )
        .onErrorReturnWith((error, stackTrace) {
          addError(error, stackTrace);
          return UsersError(error);
        })
        .startWith(const UsersLoading())
        .listen(emit);
  }

  void select(User user) {
    if (state case final UsersLoaded state when state.users.contains(user)) {
      emit(state.copyWith(selectedUser: user));
    }
  }

  @override
  Future<void> close() {
    unawaited(_sub?.cancel());
    return super.close();
  }
}
