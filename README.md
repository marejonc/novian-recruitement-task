# Medcare

A small Flutter breathing app for iOS and Android. It has three screens:

- **Onboarding** appears on first launch only. You pick a language, then see an intro with a Rive
  bloom animation that responds to device tilt.
- **Session** lets you pick a user, a breathing pace (4–12 breaths per minute) and a duration. A
  Rive pacer animation follows the chosen pace.
- **Summary** greets the selected user by name and age, computed from their birth date. It shows
  a relaxation message, a pace card and the total breath count, all based on the session choices.
  Go back and change a choice, and the summary changes with it.

The backend is a mock. It waits about 0.5 s, then returns a JSON list of users (`firstName`,
`lastName`, `birthDate`). About one call in ten fails on purpose, so you can see the error and
retry states. The UI is available in Polish and English.

## Running

Requires Flutter stable 3.50.x (Dart `^3.14.0`).

```sh
flutter pub get
dart run build_runner build   # generated files are not committed
flutter run
```

To see onboarding again, clear the app's data or reinstall the app.

## Stack

`flutter_bloc` with `injectable` + `get_it`, `auto_route` (onboarding is a route guard), `rive`
0.14, `slang` for translations, `theme_tailor` for light and dark themes, and
`shared_preferences` for the onboarding flag and the chosen language. Code is organized by
feature in `lib/features/`. The Rive sources are in `rive/` and the exported `.riv` files are in
`assets/rive/`.
