---
name: flutter-pages
description: Rules for page files (lib/features/*/pages/) in the novian_recruitement_task app. A page is a StatelessWidget with @RoutePage() that only provides Cubits via MultiProvider and handles side effects via BlocListener, delegating all UI to a separate *Content widget; StatefulWidget + AutoRouteWrapper only when a just-provided Cubit needs initializing. Use when creating or editing a page or a route.
paths:
  - "lib/features/*/pages/**"
---

# Page Rules

A page has two jobs: **provide Cubits** and **react to side effects** (navigation). All UI lives in a
`*PageContent` widget in the feature's `widgets/`.

```
lib/features/{feature}/
  pages/{feature}_page.dart              # @RoutePage() entry point
  widgets/{feature}_page_content.dart    # all UI for this page
```

## Template

```dart
@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        SimpleBlocProvider<CompleteOnboardingCubit>(),
        BlocListener<CompleteOnboardingCubit, CompleteOnboardingState>(
          listener: (context, state) {
            if (state is CompleteOnboardingSuccess) {
              unawaited(context.router.replaceAll([const SessionRoute()]));
            }
          },
        ),
      ],
      child: const OnboardingPageContent(),
    );
  }
}
```

- **`@RoutePage()` on every page**; route arguments are constructor parameters
  (`@PathParam` / `@QueryParam` when they come from the path), handed to cubits as `XCubitDeps`.
- Leaf cubits first, then the cubits that read them — a provider can only `ctx.read()` what is above
  it.
- **IMPORTANT — never `Navigator`**; navigate with `context.router`.
- No layout, no theme lookups, no strings in the page — that is the content widget.

## Kicking off loading

The cubit constructor does not fetch; the page starts it with a cascade:

```dart
BlocProvider<UserCubit>(
  create: (ctx) => ctx.blocFactory.get()..load(),
),
```

A `..load()` cascade is the only initialization allowed in `create`. When a provided Cubit needs more
than that, the page becomes a `StatefulWidget` implementing `AutoRouteWrapper`: providers move to
`wrappedRoute` (with `child: this`), and the initialization runs in `initState` via `context.read`.

`BlocProvider` is lazy — pass `lazy: false` when the cubit must start work as the page opens even
though no widget reads it yet (e.g. starting the backend fetch while the user is still choosing
parameters).

## Shared flow state

Cubits that several routes read (the session parameters read by the summary) are **not** provided by
either page. They are provided by a wrapper route above both — a page implementing
`AutoRouteWrapper` whose `wrappedRoute` returns the providers around `child: this` and whose `build`
returns `const AutoRouter()` — or by `GlobalProvidersWrapper`. See `flutter-architecture`.

## No listener / single cubit

No side effects → no `BlocListener`. One cubit without factory params → `SimpleBlocProvider<T>`
wrapping the content directly instead of `MultiProvider`.
