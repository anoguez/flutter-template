---
name: gym-workouts-ui-ux
description: Design and implement UI, UX, onboarding, authentication, profile, and settings changes for the Gym Workouts Flutter app. Use when adding or changing screens, navigation, preferences, account flows, profile controls, styling, or Firebase-backed UI in this repository; ensure changes follow the established design system and are functional end to end.
---

# Gym Workouts UI/UX

## Start with the existing product

Before changing UI, inspect the nearest existing screens, routes, state holders, repositories, and tests. Reuse an existing component when it matches the behavior; extract a shared component only when the same interaction or visual treatment is needed in more than one place.

Treat this as a Flutter app with two visual systems already in use:

- Use `$styles`, `context.colors`, `AppSpacing`, and `AppBorderRadius` for the established product styling.
- Use the onboarding visual language only for onboarding and authentication surfaces. Preserve its dark/light colors, Space Grotesk headings, Inter body text, spacing, and controls.
- Use existing `PreferenceCard`, `PreferenceRow`, `TogglePreferenceRow`, and `SectionHeader` in settings. Do not introduce a one-off card style for a settings field.

## Build complete flows, not visual stubs

Trace the full path before adding a CTA:

1. Identify entry route, exit route, and back behavior.
2. Identify the authenticated user and repository writes required by the action.
3. Persist the selection before declaring the flow complete.
4. Show loading, failure, and success states in a platform-safe way.
5. Verify the next launch and sign-out/sign-in behavior.

Do not ship buttons that claim to sign in, connect a provider, save a setting, or request permission unless they perform that work. Do not silently create a user at app startup; guest access must be an explicit user action.

For account flows:

- Route unauthenticated users to Login.
- Run onboarding after first sign-in for that specific account, not merely once per device.
- Use the onboarding completion key scoped to the user ID.
- Write onboarding values to the profile and the canonical preferences repositories; provide a corresponding editable settings surface.
- Keep profile identity details, workout preferences, notifications, and health-sync choices separate in their existing ownership boundaries.

## Handle soft keyboards deliberately

For mobile forms and bottom sheets containing text inputs:

- Only autofocus an input when immediate typing is the expected first action. In particular, do not autofocus an edit form merely because the same field is useful when creating a new item.
- Give users an explicit way to dismiss the software keyboard without closing the form. For shared `TextField` wrappers, handle `onTapOutside` by unfocusing the active field; use the equivalent focus-scope behavior for other input controls.
- Add a focused widget test when changing autofocus or dismissal behavior: cover both the initial focus state and outside-tap unfocus behavior.

## Keep settings canonical and discoverable

For every preference introduced or changed:

- Add it to the appropriate entity, `copyWith`, serialization model, Firestore mapping, and backward-compatible read defaults.
- Save it through the repository/BLoC already used by the settings screen.
- Apply it where relevant in the app; do not leave onboarding values as unused data.
- Expose one clear settings destination. Avoid multiple Profile rows that open the same page; use a single, accurately named entry such as “Preferences”.
- Keep body data in Preferences and account identity in Profile unless product requirements say otherwise.

## Firebase and permission safeguards

When adding a Firestore-backed surface:

- Verify the collection has owner-only `get`, `create`, and `update` rules as appropriate.
- Ensure list queries satisfy rule constraints, including required `where` clauses and explicit limits.
- Deploy changed Firestore rules only after local validation and with user authorization.
- Handle rejected notification and health permissions without marking unsupported behavior as enabled.
- Never call `ScaffoldMessenger.of` where a `ScaffoldMessenger` is not guaranteed (notably Cupertino routes); use an inline error state or a platform-safe messenger lookup.

## Validation checklist

Before handoff:

- Run `dart format` on modified Dart files.
- Run focused widget/BLoC/repository tests, adding or updating tests for new persistence or routing behavior.
- Run `flutter analyze`; fix all diagnostics introduced by the change and clearly identify any pre-existing diagnostics.
- Run the app or an appropriate widget test in both light and dark themes when visuals changed.
- Manually exercise the changed flow: first use, success, failure, restart, and settings edit where applicable.
- Check the diff for dead UI, stale imports, duplicate settings entries, hard-coded values that contradict saved preferences, and unimplemented CTA actions.

## Practical standard

Favor a small coherent change over a broad visual rewrite. Keep domain and data logic out of widgets, respect the existing repository/BLoC boundaries, and make every visual decision reflect a real, persisted product behavior.
