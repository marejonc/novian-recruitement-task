# novian_recruitement_task — Medcare / Wellness breathing app

A minimalist, responsive Flutter mobile app (iOS + Android) built as a recruitment task. It shows
state architecture, a mocked backend, and interactive Rive animations.

## What the app must do

1. **Onboarding** — shown **only on first launch** (flag in `SharedPreferences`). Introduces the
   Medcare app; a Rive animation is the key visual.
2. **Session** — the user picks breathing-exercise parameters (e.g. breaths per minute, goal). A
   second Rive animation (breathing / progress) **reacts to those choices**. The choices are the
   input for the next screen.
3. **Summary** — personalized summary from the backend user (first name, last name, **age computed
   from birth date**) plus the session choices (e.g. tailored relaxation message, breath count).
   **Changes on the session screen must directly change this screen's state, content and visuals.**

Backend is a mock: `Future.delayed` latency + JSON deserialization of `firstName`, `lastName`,
`birthDate`.

## Stack

Flutter stable (3.50.x, Dart `^3.14.0`), `rive` (0.14.x — check the current API before using it),
`flutter_bloc` + `provider` + `single_value_cubit`, `injectable` + `get_it`, `rxdart`,
`equatable`, `copy_with_extension`, `auto_route`, `shared_preferences`, `theme_tailor`,
`slang` (+ `slang_build_runner`) for translations; `mocktail` for tests. Material widgets come from the
`material_ui` package (Material is decoupled from the framework in current Flutter) — import
`package:material_ui/material_ui.dart`, not `package:flutter/material.dart`. Lints: `very_good_analysis` (see `analysis_options.yaml`).

All of these are already in `pubspec.yaml`. Add new ones with `flutter pub add <name>`
(`dev:<name>` for generators and test tools). `main()` initializes Rive (`RiveNative.init()`),
translations and DI before `runApp`.

## Commands

```sh
flutter pub get
dart run build_runner build         # required on a fresh checkout — generated files are gitignored; after changing translation JSON, @injectable, @RoutePage, @CopyWith, @TailorMixin
flutter analyze
dart format lib test
flutter test
flutter run
```

## Checklist after making changes, in this order

- Re-read the **IMPORTANT** rules below and run the self-check from `flutter-widgets`
- `dart run build_runner build` if translation JSON, annotations or routes changed
- `dart format lib test`
- `flutter analyze` — must be clean
- `flutter test`
- Hot reload / hot restart the running app and check runtime errors (dart MCP
  `get_runtime_errors`)

## Code style

- Prefer `final`; use `const` constructors and literals wherever possible.
- dartdoc comments are not required (`public_member_api_docs: false`).
- Trailing commas on multi-line parameter/argument lists (`trailing_commas: preserve`). Named-parameter
  declarations get one parameter per line with a trailing comma; a lone `{super.key}` stays inline.
- Every file ends with a newline (`eol_at_end_of_file`).
- Comments explain what the code does and why — no references to task-document sections or
  ticket ids.

## IMPORTANT — rules

Check every change against this list before calling it done. The skills hold the reasons and
examples.

- **Feature-first:** code lives in `lib/features/{feature}/{pages,widgets,bloc,domain,data}`.
- **`domain/` is free of Flutter:** no `BuildContext`, widgets, `flutter_bloc`, or imports from
  `bloc/` / `widgets/`.
- **Never `VoidCallback`** — write `void Function()` / `void Function()?`.
- **Never `Navigator`** — routes go through `context.router` (auto_route). First-launch onboarding is
  an `AutoRouteGuard`, not a check in `build`.
- **`getIt` only in `di/`, routing guards, `main.dart` and `app.dart`** — never in a page, widget or
  cubit.
- **No private widget classes**; one public widget per file. Private `State` classes are fine.
- **Widget-returning methods are named `buildX` / `_buildX`.**
- **No raw design values:** no `Colors.*`, `Color(0x…)`, raw `TextStyle(...)`, or numeric literals
  for padding, gaps, radii or sizes outside `lib/theme/`. Use `context.appColors` / `appTypography`
  / `appSpacing` / `appRadius`; add a missing token first. A size only one class uses is a private
  `static const` on that class.
- **No hardcoded user-visible strings** — every `Text`, label, title, tooltip, hint, error and
  `semanticsLabel` comes from slang's `context.t.namespace.key` (JSON in `lib/i18n/src/{pl,en}/`; the
  global `t` is hidden so a language switch rebuilds every reader). Strings built
  from values (the summary message) are slang parameters / plurals, not string concatenation.
- **No `fontSize` / `fontWeight` in a text style's `copyWith`** — pick or add a typography token.
- **Never a hand-written `copyWith`** — `@CopyWith()` for states and models, theme_tailor for
  `ThemeExtension`s.
- **Cubits:** sealed `Equatable` states, `@injectable`, async calls via `Rx.fromCallable` with
  `addError` in `onErrorReturnWith`, every subscription cancelled in `close()`. A single value is a
  `single_value_cubit`, not a hand-written cubit.
- **A cubit's `@factoryParam` is always one `XCubitDeps`** — cubits positional, other values named.
- **Cubits are provided through `lib/di/bloc_factory.dart`** (local, ~40 lines: `BlocFactory`,
  `BlocFactoryProvider`, `SimpleBlocProvider<T>`, `context.blocFactory`) — no third-party wrapper.
- **Write the cubit type once:** `BlocProvider<T>(create: (ctx) => ctx.blocFactory.get(TDeps(ctx.read())))`.
- **`context.read(...).state` never in `build`** — only in callbacks. In `build` use
  `context.watch` / `context.select`.
- **Session choices are one source of truth** shared by the session and summary screens (provided
  above both routes) — never copied into route arguments.
- **Rive inputs are driven from Cubit state**; the animation never owns app state. The widget that
  creates a Rive `FileLoader` / controller disposes it.
- **Repositories return `Future<T>`** and are `@LazySingleton(as: Interface)`; `SharedPreferences`
  is touched only in `data/`.
- **A use case has exactly one public method, `call()`.**
- **Bools are yes/no questions** — `isSelected`, `hasCompletedOnboarding`, never `selected`.
- **A helper on one value is an extension**, not a top-level function (`user.ageAt(now)`, not
  `ageOf(user, now)`), in `{feature}/{layer}/extensions/<name>_extension.dart`.
- **No `!` null assertions** outside tests — bind with `if (x case final x?)` / pattern matching.
- **A pattern binding keeps the name of what it matches** (`if (user.nickname case final nickname?)`).
- **`package:` imports and exports only.** Exception: a fake shared between tests is imported
  relatively.
- **Test doubles come from `mocktail`** — `MockX extends Mock implements X`,
  `FakeX extends Fake implements X`; never hand-written fakes with `noSuchMethod`.

## Skills

Project skills live in `.claude/skills/` (also linked as `.agents/skills/`):

| Skill | Covers |
|---|---|
| `flutter-architecture` | Layout, layers, mock backend, routing + onboarding guard, cubit scope, theme, Rive |
| `flutter-cubits` | Sealed states, `@injectable`, `Rx.fromCallable`, subscriptions, `XCubitDeps` |
| `flutter-pages` | `@RoutePage()` pages — `MultiProvider` + `BlocListener`, UI in `*PageContent` |
| `flutter-widgets` | Theme tokens, one widget per file, responsive layout, self-check |
| `flutter-testing` | mocktail `Mock` / `Fake`, test layout, what to cover |
| `injectable-di` | DI annotations, `@module` / `@preResolve`, DI errors |
| `flutter-frontend-design` | Visual direction for new screens |

Package skills shipped by dependencies, installed with the Dart `skills` CLI (not edited by hand;
tracked in `.config/dart_skills/skills_config.json`). After adding or upgrading a package, run:

```sh
dart run skills@ get --all --agent claude   # .agents/skills is a symlink to .claude/skills
dart run skills@ prune                      # drop skills of removed packages
```

| Skill | Covers |
|---|---|
| `single_value_cubit-package` | `IntValueCubit`, `SingleValueCubit<T>`, `observe()` |
| `get-it-expert` | `get_it` registration, scopes, async init, testing |
