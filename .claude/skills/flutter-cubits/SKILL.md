---
name: flutter-cubits
description: Rules for Cubits in the novian_recruitement_task app — sealed Equatable states, @injectable registration, Rx.fromCallable instead of awaiting Futures, StreamSubscription lifecycle, injecting one cubit into another through a single XCubitDeps @factoryParam, and reaching for single_value_cubit first. Use when creating, structuring or editing any Cubit or its state.
paths:
  - "lib/**/bloc/**"
---

# Cubit Rules

DI annotations: `injectable-di`. Providing cubits in the tree: `flutter-pages` and
the local helpers in `lib/di/bloc_factory.dart`.

**Before writing a Cubit, check whether `single_value_cubit` covers it.** One value — a breaths-per-
minute counter, a selected goal, a flag — is an `IntValueCubit` / `SingleValueCubit<T>` subclass
(see `single_value_cubit-package`), not a hand-written sealed state.

## State

- State is a **sealed class** at the **top of the cubit file**, before the cubit.
- Every subclass extends `Equatable` and overrides `props`.
- Add `@CopyWith()` when a subclass has more than one field; never hand-write `copyWith`.
- Use an `enum` only when no state carries a field.
- Derived data is a getter on the state (or the domain model), not recomputed in widgets.
- Error states carry the **error object**, not a message. Turning it into text is the widget's job.

```dart
sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  const UserLoaded({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  const UserError(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}
```

## Registration

- Every cubit is **`@injectable`**. Never `@singleton` / `@lazySingleton` — scope comes from where
  it is provided, not from DI.
- Never `getIt.registerFactory(...)` by hand. Run `dart run build_runner build` after changing
  annotations.
- **IMPORTANT — never `getIt` inside a cubit.**

## Streams over Futures

**Never `await` a Future inside a cubit.** Wrap the call in `Rx.fromCallable(...)` and `listen(emit)`:

```dart
Stream<UserState> _load() => Rx.fromCallable(_repository.fetchUser)
    .map<UserState>((user) => UserLoaded(user: user))
    .onErrorReturnWith((error, stackTrace) {
      addError(error, stackTrace);
      return UserError(error);
    })
    .startWith(const UserLoading());
```

- Always `addError(error, stackTrace)` in `onErrorReturnWith` — never swallow the error.
- Use `switchMap` when the stream can be re-triggered, so the in-flight call is cancelled.

```dart
// ❌ bare Future, manual try/catch
Future<void> load() async {
  emit(const UserLoading());
  try {
    emit(UserLoaded(user: await _repository.fetchUser()));
  } catch (_) {
    emit(const UserError(...));
  }
}
```

## Subscription lifecycle

- Store every `StreamSubscription` in a field: nullable when re-assigned, `late final` when set
  once in the constructor.
- Cancel the previous one before starting a new one: `unawaited(_sub?.cancel())`.
- Cancel **every** subscription in `close()`.
- Never call `close()` on a cubit you received — its provider owns it.

```dart
@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._repository) : super(const UserLoading());

  final UserRepository _repository;
  StreamSubscription<UserState>? _sub;

  void load() {
    unawaited(_sub?.cancel());
    _sub = _load().listen(emit);
  }

  @override
  Future<void> close() {
    unawaited(_sub?.cancel());
    return super.close();
  }
}
```

The constructor wires subscriptions but does not start the first fetch; the page starts it with
`..load()` (see `flutter-pages`).

## Factory params — one `XCubitDeps`

Runtime values from the widget tree (another cubit, an id) arrive as **one** `@factoryParam` named
`XCubitDeps` (X = cubit class name), even for a single value. Cubits are positional, every other
value is named. Repositories and other singletons stay plain constructor parameters.

```dart
class SessionSummaryCubitDeps {
  const SessionSummaryCubitDeps(this.breathsPerMinute, this.goal);

  final BreathsPerMinuteCubit breathsPerMinute;
  final BreathingGoalCubit goal;
}

@injectable
class SessionSummaryCubit extends Cubit<SessionSummaryState> {
  SessionSummaryCubit(@factoryParam SessionSummaryCubitDeps deps)
    : _breaths = deps.breathsPerMinute,
      _goal = deps.goal,
      super(...) {
    _sub = Rx.combineLatest2(_breaths.observe(), _goal.observe(), _toState).listen(emit);
  }
  ...
}
```

Provided as:

```dart
BlocProvider<SessionSummaryCubit>(
  create: (ctx) => ctx.blocFactory.get(SessionSummaryCubitDeps(ctx.read(), ctx.read())),
),
```

Write the cubit type once — on `BlocProvider<T>` — with no type argument on `get` or on the
`ctx.read()` calls passed into the Deps.

## Checklist

- [ ] Not a single value → otherwise `single_value_cubit`
- [ ] Sealed `Equatable` state at the top of the file; error state carries the error
- [ ] `@injectable`; `build_runner` run
- [ ] Every async call through `Rx.fromCallable`, `onErrorReturnWith` calls `addError`
- [ ] Every subscription cancelled in `close()`
- [ ] Runtime values through one `XCubitDeps`
