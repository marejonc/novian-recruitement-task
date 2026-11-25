---
name: flutter-widgets
description: Rules for widget files (lib/**/widgets/**) in the novian_recruitement_task app — translations via slang's `t` instead of hardcoded strings, theme tokens from lib/theme (context.appColors, appSpacing, appRadius, appTypography) instead of raw values, one public widget per file, buildX naming, reading Cubit state with watch/select, responsive layout, plus a grep self-check. Use when creating or editing any widget file or the theme.
paths:
  - "lib/**/widgets/**"
  - "lib/theme/**"
---

# Widget Rules

## One public widget per file

No private widget classes (`class _Header extends StatelessWidget`). Each piece of UI is a public
`StatelessWidget` / `StatefulWidget` in its own `snake_case` file, takes `super.key`, and sits in the
feature's `widgets/` (or `lib/common/widgets/` once two features use it). A parent layout file
reads as a list of child widgets. Private methods are fine.

A method that returns a widget is named `buildX` / `_buildX` — never `_header()` or `makeTile()`. No
widget-returning closures inside `build`.

## Translations — no hardcoded strings

Every user-visible string comes from slang via `t` (import
`package:novian_recruitement_task/i18n/i18n.dart`). That covers `Text`, titles, button labels,
`tooltip`, `semanticsLabel`, hint and error text.

```dart
// ✅
Text(t.session.title)
Text(t.summary.greeting(name: user.firstName, age: age))

// ❌
Text('Sesja oddechowa')
Text('Cześć ${user.firstName}, masz $age lat')
```

- Sources: `lib/i18n/src/pl/{namespace}.json`, base locale `pl` (`build.yaml` holds the slang
  config, `namespaces: true`). The file name is the first key segment: `pl/session.json` →
  `t.session.…`; the file holds only its own keys, without a wrapping namespace key. A new feature
  gets its own namespace file; shared words go in `common.json`.
- Keys are camelCase. Values from code are slang parameters (`"greeting": "Cześć {name}"`); counts
  use slang plurals (`"breaths": {"one": "…", "few": "…", "many": "…", "other": "…"}` with `n`) —
  never concatenation or interpolation around a translated fragment.
- Messages picked from state (a relaxation message per breathing pace) are chosen in the widget by
  switching on a domain enum — the domain returns the enum, never the text.
- After editing JSON run `dart run build_runner build`. Never edit `translations*.g.dart`.
- Locales load lazily — `main()` awaits `initTranslations()` before `runApp`.

## Theme tokens — no raw design values

All design values come from the `ThemeExtension`s in `lib/theme/`:

| Need | Use | Never |
|---|---|---|
| colour | `context.appColors.x` | `Colors.*`, `Color(0x…)` |
| text style | `context.appTypography.x` (`copyWith(color:)` allowed) | `TextStyle(fontSize: …)`, `copyWith(fontSize/fontWeight)` |
| padding / gap | `context.appSpacing.sN` | numeric literals |
| radius | `context.appRadius.x` | `BorderRadius.circular(8)` |

- A missing value is added to `lib/theme/` first, then used.
- An element size only one class uses is a private `static const` on that class
  (`static const _animationSize = 280.0;`), never an inline literal. Only `0` may stay a literal.
- Each palette is a `ThemeExtension` generated with `theme_tailor`
  (`@TailorMixin(themeGetter: ThemeGetter.onBuildContext)`, `part 'x.tailor.dart';`) so
  `copyWith`, `lerp` and the `context.appX` accessor are generated — never hand-written.

## Responsive layout

The app must look right on small phones, large phones and tablets, in both orientations where the
screen allows it. Use `LayoutBuilder` / `MediaQuery.sizeOf` and `Flexible` / `Expanded` rather than
fixed heights; Rive animations get a size derived from the available constraints (with an
`AspectRatio`), not a hardcoded box. Wrap content that can overflow in a scroll view. Breakpoints are
theme constants, not literals.

## State in `build`

Prefer `context.watch<C>().state` / `context.select<C, T>(...)` over `BlocBuilder`; use `BlocBuilder`
only to limit a subtree's rebuilds.

**IMPORTANT — never `context.read(...).state` in `build`**: it is not reactive. `read` belongs in
callbacks (`onPressed`, `onChanged`, listeners).

## Errors into text

Error states carry an error object. Mapping it to a translated message happens in the widget (a private method
or a shared extension in `lib/common/`), never in the cubit.

## Other rules

- `void Function()` instead of `VoidCallback`.
- Bools are yes/no questions: `isSelected`, `hasStarted` — never `selected`, `started`.
- No `!` null assertions outside tests; bind with `if (x case final x?)` instead.

## Self-check

Run from the repo root before finishing; it must print nothing. Run it with `bash` — zsh does not
split unquoted variables, so the same lines under zsh silently match nothing.

```sh
bash <<'CHECK'
SRC=lib
X="--include=*.dart --exclude=*.g.dart --exclude=*.gr.dart --exclude=*.config.dart --exclude=*.tailor.dart"
grep -rnwE $X 'VoidCallback' $SRC
grep -rnF $X 'package:flutter/material.dart' $SRC
grep -rnE $X '^class _[A-Za-z]+ extends (StatelessWidget|StatefulWidget)' $SRC
grep -rnE $X 'Navigator\.' $SRC
grep -rnE $X 'getIt(<|\.|\()' $SRC | grep -E '/(widgets|pages|bloc)/'
grep -rnE $X '\bColors\.|Color\(0x' $SRC | grep -v '^lib/theme/'
grep -rnE $X 'TextStyle\(|fontSize:|fontWeight:' $SRC | grep -v '^lib/theme/'
grep -rnE $X 'BorderRadius\.circular\([0-9]' $SRC
grep -rnE $X '(EdgeInsets\.[a-zA-Z]+\(|SizedBox\((width|height): )[^)]*\b[1-9][0-9]*(\.[0-9]+)?\b' $SRC | grep -v '^lib/theme/'
grep -rnE $X "Text\((\s*)['\"]" $SRC
grep -rnE $X "(label|title|tooltip|hintText|semanticsLabel|errorText): *['\"]" $SRC
grep -rnE $X '\.read<[^>]*>\(\)\.state' $SRC
CHECK
```

The two string checks only catch literals passed directly; the last line also matches legitimate reads inside callbacks — check each hit by hand.
