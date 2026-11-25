---
name: flutter-testing
description: Unit- and widget-test rules for the novian_recruitement_task app — mocktail Mock classes for every dependency a test doesn't own, Fake classes for don't-care arguments, when/verify/any stubbing, registerFallbackValue, setUp/tearDown layout, and what is worth testing here (JSON deserialization, age calculation, cubits, the onboarding flag). Use when writing, editing or reviewing any *_test.dart file or test double.
paths:
  - "test/**"
---

# Testing Rules

## Test doubles come from `mocktail`

```dart
class MockUserRepository extends Mock implements UserRepository {}
class FakeUser extends Fake implements User {}
```

- `MockX extends Mock implements X` for every dependency the test doesn't own (repositories, use
  cases). Stub with `when`, check with `verify`.
- `FakeX extends Fake implements X` + `registerFallbackValue(FakeX())` in `setUpAll` for arguments
  whose value the test doesn't care about (`any()`).
- **Never** a hand-written `implements XRepository` with `noSuchMethod`, a `calls` list or a
  `failure` field.
- Real values only where the test asserts on or branches on them.
- Cheap cubits the subject reads (a `single_value_cubit` holding the breaths per minute) are used for
  real, not mocked.
- `SharedPreferences` in tests: `SharedPreferences.setMockInitialValues({...})`.

## Layout

```dart
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository repository;
  late UserCubit cubit;

  setUp(() {
    repository = MockUserRepository();
    cubit = UserCubit(repository);
  });

  tearDown(() => cubit.close());

  void mockFetchUser(User user) =>
      when(() => repository.fetchUser()).thenAnswer((_) async => user);

  test('emits the loaded user', () async {
    mockFetchUser(user);

    cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, UserLoaded(user: user));
    verify(() => repository.fetchUser()).called(1);
  });
}
```

- Mocks and fakes are top-level, public, declared above `main`.
- The subject and its doubles are `late` locals of `main`, created fresh in `setUp`; cubits and
  streams are closed in `tearDown`.
- Repeated stubbing goes in a named local helper (`mockFetchUser`).
- Stub a `Future` with `thenAnswer((_) async => …)`, never `thenReturn(Future…)`.
- Test files mirror `lib/` under `test/` and end in `_test.dart`. A fake shared by several tests is
  imported relatively — `package:` can't reach `test/`.

## What to cover here

- `User.fromJson` — the fields and date parsing the mocked backend returns.
- Age from birth date — before / on / after the birthday this year (inject "now", don't read
  `DateTime.now()` inside the logic).
- Summary logic — the message / numbers produced for given session parameters.
- Cubits — loading → loaded / error transitions with a mocked repository.
- Onboarding flag repository — first launch vs. after completion.

Widget tests (`flutter-add-widget-test`) are welcome for the summary reacting to parameter changes.
Rive widgets need the native runtime — keep them out of widget tests or stub the animation widget.

Run: `flutter test`.
