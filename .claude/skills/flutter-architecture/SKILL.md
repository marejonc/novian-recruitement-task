---
name: flutter-architecture
description: Architecture rules for the novian_recruitement_task Flutter app — feature-first layout, the pages/widgets/bloc/domain/data layering, the mocked backend repository, auto_route routing and the onboarding guard, Cubit scope (including state shared between the session and summary screens), GetIt registration and theme-token access. Use when adding or editing any feature, route, repository, use case or model in this project.
paths:
  - "lib/**"
---

# Flutter — Architecture

Read the **IMPORTANT** list in `AGENTS.md` before finishing any change.

## Related skills

- **Cubit creation / editing**: `flutter-cubits`
- **Providing a Cubit in the tree**: `flutter-pages`, `lib/di/bloc_factory.dart`
- **Single-value state** (a counter, a flag, a selected option): `single_value_cubit-package`
- **DI annotations / DI errors**: `injectable-di`
- **Widgets, translations, theme tokens**: `flutter-widgets`
- **Tests**: `flutter-testing`
- **Visual direction for new screens**: `flutter-frontend-design`

## Directory structure

```
lib/
  features/{feature}/
    pages/          # @RoutePage() widgets — one file per page
    widgets/        # Widgets scoped to this feature
    bloc/           # Cubits + states
    domain/         # Models, repository interfaces, use cases, pure logic
    data/           # Repository implementations (mock backend, shared_preferences)
  common/           # Code with no feature of its own, used by several features
  di/
    configure_dependencies.dart   # @InjectableInit, `getIt`
    register_module.dart          # @module for third-party types (SharedPreferences)
    bloc_factory.dart             # barrel: BlocFactory, BlocFactoryProvider, SimpleBlocProvider, context.blocFactory
    bloc_factory/                 # their implementations
  routing/
    app_router.dart     # AutoRouter config — edit this to add routes
    app_router.gr.dart  # Generated — never edit
    *_guard.dart        # AutoRouteGuard implementations
  i18n/
    src/{pl,en}/{namespace}.json  # translation sources (slang, base locale pl, default en)
    i18n.dart                 # barrel + initTranslations()
    translations*.g.dart      # generated — never edit
  theme/            # ThemeExtensions (colors, spacing, radius, typography) + ThemeData
  global_providers_wrapper.dart   # app-scoped Cubits (below BlocFactoryProvider)
  app.dart          # MaterialApp.router
  main.dart         # Bootstrap only: configureDependencies, runApp
assets/
  rive/             # *.riv files, declared in pubspec.yaml
```

Expected features for this task: `onboarding`, `session` (breathing parameters) and `summary`, plus
`user` (domain + data for the mocked backend) if more than one feature reads the user.

### Rules

- **Feature-first is mandatory.** Never put a feature's pages, cubits or repositories directly in
  `lib/`.
- **`lib/common/` only on the second consumer.** A helper with one caller lives in that feature.
- **IMPORTANT — No private widget classes.** Every widget class is public and in its own file. The
  private `State` of a public `StatefulWidget` is fine, and so are private methods.
- **IMPORTANT — Never `VoidCallback`.** Write `void Function()` / `void Function()?`.
- **IMPORTANT — `getIt` only in `di/`, routing guards, `main.dart` and `app.dart`.** Never in a page,
  widget or cubit.
- **`package:` imports and exports only** (`package:novian_recruitement_task/...`). The one
  exception is a fake shared between tests under `test/`, which is imported relatively.

## Layers

Dependencies point inward: `data` → `domain` ← `bloc` ← `pages/widgets`.

| Layer | Directory | Contains |
|---|---|---|
| Presentation | `pages/`, `widgets/` | Pages, widgets — no business logic |
| State | `bloc/` | Cubits and their states |
| Domain | `domain/` | Models, repository interfaces, use cases, pure functions |
| Data | `data/` | Repository implementations |

### `domain/`

**IMPORTANT — `domain/` never depends on Flutter or presentation**: no `BuildContext`, no
`package:flutter/...`, no `flutter_bloc`, no import from `bloc/` or `widgets/`. Pure logic lives
here and takes plain values — e.g. computing age from a birth date, or choosing a relaxation message
from the selected breathing parameters. Put such logic on the model or in an extension so it is
unit-testable without widgets.

Models are immutable, extend `Equatable`, and deserialize with a `fromJson` factory (hand-written
with `dart:convert` maps, or `json_serializable` — pick one and use it everywhere). A model that
needs copying gets `@CopyWith()` — **never a hand-written `copyWith`**.

Repository interfaces are `abstract interface class`es. **Repository methods return `Future<T>`, not
`Stream<T>`** — turning a call into a stream is the Cubit's job.

```dart
// features/user/domain/user_repository.dart
abstract interface class UserRepository {
  Future<User> fetchUser();
}
```

Create a use case only when an action touches **more than one repository or side effect**. A use
case has exactly **one public method, `call()`**.

### `data/`

File names name the backing technology: `mock_user_repository.dart`,
`shared_preferences_onboarding_repository.dart`.

Register every repository implementation with **`@LazySingleton(as: Interface)`**. It stays a thin
pass-through: no state, no stream orchestration, no error mapping — errors are thrown and the Cubit
turns them into an error state.

The mocked backend simulates the network and decodes a JSON payload, so the deserialization path
is real:

```dart
@LazySingleton(as: UserRepository)
class MockUserRepository implements UserRepository {
  const MockUserRepository();

  static const _latency = Duration(milliseconds: 1200);
  static const _response = '{"firstName": "Anna", "lastName": "Kowalska", "birthDate": "1992-04-17"}';

  @override
  Future<User> fetchUser() => Future<void>.delayed(_latency).then(
        (_) => User.fromJson(jsonDecode(_response) as Map<String, dynamic>),
      );
}
```

The first-launch flag lives behind its own repository over `SharedPreferences` (registered in the
DI module with `@preResolve`). Nothing outside `data/` touches `SharedPreferences`.

### Cubit responsibility

A Cubit calls exactly one thing: a repository method, or a use case when the action spans several
repositories.

## Routing

`auto_route`. Pages are named `XPage`; routes are generated as `XRoute`
(`replaceInRouteName: 'Page,Route'`).

```dart
@RoutePage()
class SessionPage extends StatelessWidget { ... }

// lib/routing/app_router.dart
AutoRoute(page: SessionRoute.page, path: '/session'),
```

- **IMPORTANT — never `Navigator`** — always `context.router`.
- Run `dart run build_runner build` after changing routes.
- **Show-once onboarding is a guard**, not a check in a page's `build`:
  `lib/routing/onboarding_guard.dart` reads the flag through the repository (from `getIt`) and
  redirects to `OnboardingRoute` on first launch, so the session screen never flashes first.
  Finishing onboarding persists the flag (through a Cubit) and then calls
  `context.router.replaceAll([const SessionFlowRoute()])`.

## State management

- `flutter_bloc` Cubits, registered with `@injectable`, provided with the local helpers in
  `lib/di/bloc_factory.dart`: `SimpleBlocProvider<T>()` or
  `BlocProvider<T>(create: (ctx) => ctx.blocFactory.get(TDeps(...)))`.
- `BlocFactoryProvider(getIt: getIt)` sits once at the top of `app.dart`. `ctx.blocFactory.get`
  takes at most one argument — the cubit's `XCubitDeps`.
- Never `getIt.registerFactory(...)` by hand.

### Cubit scope

| Scope | Where to provide |
|---|---|
| App-wide | `lib/global_providers_wrapper.dart` (below `BlocFactoryProvider` in `app.dart`) |
| One screen | that page, via `MultiProvider` |
| Several screens of one flow | a wrapper route above those screens |

**The session parameters must be shared by the session and summary screens** — the summary reacts
to what was chosen on the session screen. Provide those Cubits *above both routes* (a shell
`AutoRouteWrapper` page around the session → summary flow, or `GlobalProvidersWrapper` if the flow is
the whole app) — never pass a snapshot of the values as route arguments, and never create a second
instance on the summary page.

Read state with `context.watch` / `context.select`, not `BlocBuilder`:

```dart
final breaths = context.select<BreathsPerMinuteCubit, int>((c) => c.state);
```

## Translations

No hardcoded user-visible strings — all text comes from slang's `context.t` (JSON in `lib/i18n/src/{pl,en}/`,
one file per namespace). `domain/` never returns user-facing text: it returns values or enums that the widget
turns into a translated string. Details in `flutter-widgets`.

## Theme

Design values live in `lib/theme/` as `ThemeExtension`s and are read through context accessors:

```dart
// ✅
context.appColors.primary
context.appSpacing.s16
context.appTypography.title

// ❌
Colors.teal
EdgeInsets.all(16)
TextStyle(fontSize: 20)
```

A value that isn't a token yet is added to `lib/theme/` first, then used. See `flutter-widgets`.

## Material

Material widgets come from the `material_ui` package — import
`package:material_ui/material_ui.dart`, never `package:flutter/material.dart`.

## Rive

- `.riv` files live in `assets/rive/` and are declared under `flutter: assets:`.
- Load with `FileLoader.fromAsset(...)` + `RiveWidgetBuilder`; the widget that creates the
  `FileLoader` owns it and disposes it.
- Rive inputs (state-machine numbers/booleans/triggers or data-binding properties) are **driven from
  Cubit state** — a listener or `didUpdateWidget` pushes the current value into the controller. The
  animation never holds state the rest of the app needs.
- Look up the current `rive` API via the docs before writing it — the runtime API changed
  significantly in 0.14.
