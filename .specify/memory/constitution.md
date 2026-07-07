<!--
Sync Impact Report
==================
Version change: TEMPLATE → 1.0.0 (initial ratification)
Modified principles: N/A (first fill of template placeholders)
Added sections:
  - I. Clean Architecture Layering (NON-NEGOTIABLE)
  - II. BLoC-Driven State Management
  - III. Design Token Consistency
  - IV. Test Discipline for Business Logic
  - V. Dependency Hygiene
  - VI. Template Minimalism (YAGNI)
  - Technology & Platform Constraints (Section 2)
  - Development Workflow & Quality Gates (Section 3)
  - Governance
Removed sections: none (template placeholders only)
Templates requiring updates:
  - .specify/templates/plan-template.md: ✅ no change needed (Constitution Check section is generic and reads this file at runtime)
  - .specify/templates/spec-template.md: ✅ no change needed (no constitution-specific references)
  - .specify/templates/tasks-template.md: ✅ no change needed (no constitution-specific references)
  - README.md: ⚠ pending (consider linking to this constitution from the architecture section)
Follow-up TODOs:
  - TODO(RATIFICATION_DATE): original adoption predates this constitution file; repo history does not
    record a formal ratification event, so ratification date is set to the date this constitution was
    first filled in.
-->

# Flutter Template Constitution

## Core Principles

### I. Clean Architecture Layering (NON-NEGOTIABLE)
Every feature MUST be organized into `domain/` (entities, repository interfaces, usecases),
`data/` (models, services, repository implementations), and `ui/` (screens, BLoCs) layers.
Domain code MUST NOT import from `data/` or `ui/`. Repository implementations MUST catch
data-layer exceptions (`core/errors/exceptions.dart`) and convert them to `Either<Failure, T>`
(`core/utils/typedef.dart`) — never let raw exceptions escape into a BLoC. Usecases MUST extend
`UsecaseWithParams`/`UsecaseWithoutParams` and contain no logic beyond delegating to a repository.
Rationale: this is the pattern the template's own README commits to; skipping a layer or leaking
exceptions across it defeats the reason a new project would choose this template over a blank one.

### II. BLoC-Driven State Management
Screen-level state MUST be managed with `flutter_bloc` (`Bloc`/`Cubit`), not ad hoc `setState` or
scattered `ValueNotifier`s, for any state that involves asynchronous data loading or multi-step user
flows. Each BLoC's states MUST be modeled as a sealed/closed state hierarchy (e.g. `Initial`,
`Loading`, `Loaded`, `Error`) and failures MUST be converted to user-facing messages via
`core/errors/failure_mapper.dart` rather than re-implemented per BLoC. Local, ephemeral UI state
(e.g. an animation controller) MAY continue to use `flutter_hooks`.
Rationale: without an enforced convention, "BLoC" degrades into an unused dependency, which is the
state this template was in before this principle was adopted.

### III. Design Token Consistency
Color MUST come from `Theme.of(context).colorScheme` (via `context.colors`), never a hardcoded
`Color(0x...)` literal or ad hoc named constant. Spacing and radii MUST come from `AppSpacing` /
`AppBorderRadius`, not inline magic numbers. New color/spacing/radius tokens are added to
`AppColors`/`AppSpacing`/`AppBorderRadius`, never inlined at the call site. `ThemeContextExtension`
(`context.colors`, `context.textTheme`, `context.isDark`) is the required access pattern; a global
theme singleton MUST NOT be reintroduced for anything Material's `ThemeData` already models.
Rationale: hardcoded colors scattered across widgets make re-skinning a new project (the entire
point of a template) require a manual widget-by-widget audit instead of changing one seed color.

### IV. Test Discipline for Business Logic
Every BLoC, usecase, and repository implementation MUST have tests before being considered done.
BLoC tests MUST use `bloc_test`; repository/usecase collaborators MUST be mocked with `mocktail`.
UI widget tests are encouraged but not required to the same bar as business logic. A pull request
that adds a repository or BLoC without a corresponding test under `test/` MUST NOT be merged.
Rationale: business logic (error mapping, state transitions) is exactly the code most template
consumers will copy into real features; untested reference code teaches the wrong habit.

### V. Dependency Hygiene
`pubspec.yaml` dependencies MUST NOT be added and left unused (the state `fpdart`, `equatable`,
and `flutter_bloc` were in before this constitution). Discontinued or unmaintained packages
(per pub.dev's discontinued marker) MUST be replaced or removed, not carried forward. Version
bumps MUST be verified with `flutter analyze` and `flutter test` passing before being committed.
When a dependency constraint must be pinned below latest (e.g. to avoid a resolver conflict or a
known-bad analyzer-plugin release), the pin MUST be accompanied by a comment or commit message
explaining why, so a future upgrade attempt knows what to re-check.
Rationale: a template that silently accumulates unused or stale dependencies passes that debt to
every project bootstrapped from it.

### VI. Template Minimalism (YAGNI)
The template MUST NOT carry speculative abstractions, unused example widgets, or dead files
"in case a future project needs them." The example feature slice (currently `lib/ui/todos` and
its `domain`/`data` counterparts) exists solely to demonstrate Principle I end-to-end and MUST be
deleted (not just ignored) by a project once its own first real feature is built, per the README.
Rationale: a template's job is to show one correct pattern clearly, not to pre-guess every
feature a consuming project might need.

## Technology & Platform Constraints

The template targets the Flutter/Dart SDK versions declared in `pubspec.yaml`'s `environment:`
key and documented in `README.md`; both MUST be kept in sync when the minimum supported SDK
changes. Routing MUST use `go_router`; dependency injection MUST use `get_it`, registered
centrally in `lib/config/dependencies.dart`. Localization MUST use Flutter's built-in
`gen-l10n` with `synthetic-package: false` (the synthetic `flutter_gen` package mechanism is
deprecated by the Flutter SDK and MUST NOT be reintroduced) — generated output lives under
`lib/l10n/generated/` and is regenerated via `flutter gen-l10n` / `flutter pub get`, not committed.
Responsive sizing via `flutter_screenutil` (`.w`/`.h`/`.r`) MAY be applied at call sites but MUST
NOT be baked into the base `AppSpacing`/`AppBorderRadius` token values themselves.

## Development Workflow & Quality Gates

Before a change is considered complete: `flutter analyze` MUST report zero issues, and
`flutter test` MUST pass. Any dependency version bump spanning a major version MUST be checked
against the packages that actually consume it in `lib/` (an unused dependency bump is not a
reason to skip verification, and a used one is not safe to assume compatible). Native project
files (`ios/`, `android/`) that get modified by tooling side effects (e.g. Flutter's automatic
Xcode project migrations during `flutter build`) MUST be called out explicitly for review rather
than committed silently alongside unrelated Dart changes.

## Governance

This constitution supersedes ad hoc conventions for anything it explicitly addresses. Amendments
are made by editing this file directly: update the affected principle/section, bump
`CONSTITUTION_VERSION` per the policy below, set `LAST_AMENDED_DATE` to the date of the edit, and
record the change in a Sync Impact Report comment at the top of the file. Versioning follows
semantic versioning: MAJOR for a backward-incompatible principle removal or redefinition, MINOR
for a new principle or materially expanded guidance, PATCH for wording/clarification fixes.
Pull requests that touch `lib/` MUST be checked against the Core Principles above; a violation
MUST either be fixed or the constitution amended first — the code MUST NOT simply ignore the
principle. Runtime development guidance for contributors lives in `README.md`; that file MUST be
kept consistent with any principle change made here.

**Version**: 1.0.0 | **Ratified**: 2026-07-07 | **Last Amended**: 2026-07-07
