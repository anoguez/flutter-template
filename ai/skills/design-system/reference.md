# Design System Guide — gym_workouts

Read this file in full before writing or reviewing any widget. Every rule here reflects the design system established in PR #158.

---

## Core principle: no raw values in widget code

**Never** write raw `Color(...)`, `EdgeInsets.all(n)`, `SizedBox(height: n)`, `BorderRadius.circular(n)`, or `Colors.*` literals anywhere under `lib/ui/`. Every value must come from one of the three token classes or from the `ColorScheme` via context.

---

## 1 — Colors

### Access pattern
Always use `context.colors` (shorthand from `ThemeContextExtension` at `lib/core/extensions/theme_extension.dart`):
```dart
final cs = context.colors; // ColorScheme
```

### Semantic color mapping

| Use case | Token |
|---|---|
| Primary action fill | `cs.primary` |
| Text on primary fill | `cs.onPrimary` |
| Primary tinted container | `cs.primaryContainer` |
| Secondary action fill | `cs.secondary` |
| Card / page surface | `cs.surface` |
| Elevated / input fill | `cs.surfaceContainerHighest` |
| Primary text | `cs.onSurface` |
| Muted / dim text | `cs.onSurfaceVariant` |
| Subtle hairline border | `cs.outlineVariant` |
| Visible border | `cs.outline` |
| Error / destructive | `cs.error` |
| Text on error fill | `cs.onError` |
| Tertiary (charts, info) | `cs.tertiary` |

### Brand palette reference (for understanding only — use cs.* in code)

| Role | Dark value | Light value |
|---|---|---|
| primary | `GymColors.lime` `#D7FF3C` | `GymColors.limeDark` `#7BA800` |
| secondary | `GymColors.coral` `#FF7A45` | `GymColors.coralDark` `#E85418` |
| tertiary | `#00D4FF` cyan | `#006B87` teal |
| error | `GymColors.danger` `#FF5A5F` | same |
| scaffold bg | `GymColors.darkBg` `#000000` | `GymColors.lightBg` `#F4F4F1` |

### Static/non-semantic colors (only these may be used as raw values)

```dart
AppColors.white           // Colors.white — for text on photos/gradients
AppColors.black           // Colors.black
AppColors.whiteTransparent // 0x4DFFFFFF — glass overlays
AppColors.blackTransparent // 0x4D000000 — scrim overlays
GymColors.transparent     // 0x00000000 — no-op placeholder
```

Gradient helpers from `GymColors`:
```dart
GymColors.accentGlow(cs.primary)   // radial glow for glass cards
AppColors.gymGradientDark           // lime→coral linear
AppColors.gymGradientLight          // limeDark→coralDark linear
```

### Forbidden

```dart
// ❌ Never
Colors.grey, Colors.blue, Colors.green, Colors.orange, Colors.red
GymColors.darkBg, GymColors.darkSurface, GymColors.lime   // in widget code
Color(0xFF...)  // raw hex literals
```

---

## 2 — Spacing (`AppSpacing`)

Exported from `common_libs.dart` — no extra import needed.

### Scale

| Name | dp | Use |
|---|---|---|
| `AppSpacing.xs` | 4 | micro gaps, icon margins |
| `AppSpacing.sm` | 8 | compact gaps |
| `AppSpacing.md2` | 12 | tight element gaps |
| `AppSpacing.md` | 16 | standard content padding |
| `AppSpacing.md3` | 20 | generous card padding |
| `AppSpacing.lg` | 24 | section gaps |
| `AppSpacing.xl` | 32 | screen-level separation |
| `AppSpacing.xxl` | 48 | hero-level separation |

### Gap widgets (vertical SizedBox)

```dart
AppSpacing.gapXs   // 4 dp
AppSpacing.gapSm   // 8 dp
AppSpacing.gapMd2  // 12 dp
AppSpacing.gapMd   // 16 dp
AppSpacing.gapMd3  // 20 dp
AppSpacing.gapLg   // 24 dp
AppSpacing.gapXl   // 32 dp
AppSpacing.gapXxl  // 48 dp
```

### Horizontal gaps

```dart
AppSpacing.hGapXs / hGapSm / hGapMd2 / hGapMd / hGapLg
```

### EdgeInsets presets

```dart
AppSpacing.paddingScreenDefault  // symmetric(h:16, v:8) — standard screen padding
AppSpacing.paddingListItem       // symmetric(h:16, v:12) — list row padding
AppSpacing.paddingCard           // symmetric(h:16, v:12) — card content padding
AppSpacing.paddingListContent    // only(l:16, r:16, t:4, b:12) — list header
AppSpacing.paddingButton         // symmetric(h:24, v:12)
AppSpacing.paddingMd             // all(16)
AppSpacing.paddingLg             // all(24)
// plus paddingXs/Sm/Md2/Md3/Xl and horizontal/vertical variants
```

---

## 3 — Border radius (`AppBorderRadius`)

Exported from `common_libs.dart` — no extra import needed.

```dart
AppBorderRadius.radiusXs    // 4 dp — progress dots
AppBorderRadius.radiusSm    // 8 dp — chips, badges
AppBorderRadius.radiusMd    // 12 dp — buttons, text fields
AppBorderRadius.radiusLg    // 16 dp — standard cards
AppBorderRadius.radiusXl    // 20 dp — large sheet top
AppBorderRadius.radiusCard  // 22 dp — glass hero/list cards (matches theme card shape)
AppBorderRadius.radiusFull  // 999 dp — pill shapes

// Top-only (bottom sheets)
AppBorderRadius.radiusTopMd / radiusTopLg / radiusTopXl

// Bottom-only
AppBorderRadius.radiusBottomSm

// Raw doubles when a double is required
AppBorderRadius.md   // 12.0
AppBorderRadius.lg   // 16.0
AppBorderRadius.card // 22.0
AppBorderRadius.full // 999.0
```

---

## 4 — Typography

### Access pattern

```dart
context.textTheme  // shorthand for Theme.of(context).textTheme
```

### Font roles (set in `AppTheme`)

| Role | Font | Sizes |
|---|---|---|
| `displayLarge/Medium/Small` | Space Grotesk 500 | 57/45/36 |
| `headlineLarge/Medium/Small` | Space Grotesk 500 | 32/28/24 |
| `titleLarge` | Space Grotesk 500 | 22 |
| `titleMedium/Small` | Inter 500 | 16/14 |
| `bodyLarge/Medium/Small` | Inter 400 | 16/14/12 |
| `labelLarge/Medium/Small` | JetBrains Mono 500 | 12/11/10 |

### Rules

- `context.textTheme.headlineSmall` → section headings
- `context.textTheme.titleMedium` → card titles, list item titles
- `context.textTheme.bodyMedium` → body copy, descriptions
- `context.textTheme.labelSmall` → ALL-CAPS section labels (via `SectionLabel`)
- **Never** call `GoogleFonts.inter()`, `GoogleFonts.spaceGrotesk()`, etc. in widget code

---

## 5 — Shared widgets (use these, do not reinvent)

All live under `lib/ui/core/widgets/` or `lib/ui/core/`.

### Buttons

| Widget | File | Use |
|---|---|---|
| `PrimaryButton` | `widgets/primary_button.dart` | Primary CTA — `cs.primary` fill, `cs.onPrimary` text |
| `GhostButton` | `widgets/ghost_button.dart` | Secondary/neutral — `cs.surfaceContainerHighest` fill, `cs.outlineVariant` border |
| `SheetPrimaryButton` | `widgets/sheet_primary_button.dart` | Bottom-sheet CTA (full width) |

```dart
PrimaryButton(label: 'Start', onPressed: _start, expanded: true)
GhostButton(label: 'Cancel', onPressed: _cancel)
PrimaryButton(label: 'Save', icon: const Icon(Icons.check), onPressed: _save)
```

### Controls

| Widget | File | Use |
|---|---|---|
| `IconChip` | `widgets/icon_chip.dart` | Square icon button (back, close, menu) — 40 dp default, `radiusMd` |
| `InlineNumericStepper` | `widgets/inline_numeric_stepper.dart` | +/− stepper for inline numeric inputs |
| `SectionLabel` | `widgets/section_label.dart` | ALL-CAPS JetBrains Mono section header |
| `PageHeader` | `widgets/page_header.dart` | Screen-level header |

```dart
IconChip(icon: Icons.close, onTap: () => Navigator.pop(context))
SectionLabel('HISTORY · LAST 5 SESSIONS')
```

### State / feedback

| Widget | File | Use |
|---|---|---|
| `ErrorState` | `error_state.dart` | Full-screen error + optional retry |
| `LoadingIndicator` | `loading.dart` | Centered animated loading |
| `EmptyState` | `empty_state.dart` | No-data placeholder with icon |
| `StatCard` | `widgets/stat_card.dart` | Icon + value + label stat tile |

### Swipe actions

| Widget | File | Use |
|---|---|---|
| `DismissibleEditBackground` | `dismissible_backgrounds.dart` | Blue left-swipe edit hint |
| `DismissibleDeleteBackground` | `dismissible_backgrounds.dart` | Red right-swipe delete hint — uses `cs.error` |

---

## 6 — Pattern examples

### A card with correct tokens

```dart
Container(
  padding: AppSpacing.paddingCard,
  decoration: BoxDecoration(
    color: context.colors.surface,
    borderRadius: AppBorderRadius.radiusCard,
    border: Border.all(color: context.colors.outlineVariant),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Title', style: context.textTheme.titleMedium),
      AppSpacing.gapSm,
      Text('Body copy', style: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.onSurfaceVariant,
      )),
    ],
  ),
)
```

### A screen with correct scaffold

```dart
Scaffold(
  // Do NOT set backgroundColor — the theme sets OLED black / light-bg automatically
  body: Padding(
    padding: AppSpacing.paddingScreenDefault,
    child: ...
  ),
)
```

### Destructive / error color

```dart
Icon(Icons.delete, color: context.colors.error)
Text('Something went wrong', style: TextStyle(color: context.colors.error))
```

---

## 7 — When a token-compliance fix touches multiple similar widgets

Bringing several near-identical widgets onto tokens one at a time can *increase*
cross-file duplication instead of reducing it — replacing each widget's own
`Color(...)`/`EdgeInsets(...)` literals with the same `cs.*`/`AppSpacing.*` calls
makes them read even more alike than before. This happened with the four onboarding
step widgets: standardizing each independently added shared windows the duplication
metric (`dart.duplication` in `code-metrics.json`) picked up; it only net-improved
once the shared structure was pulled out into `OnboardingStepScaffold`.

Before token-fixing 2+ widgets that already share a layout shape (same scaffold,
same header/body/footer structure, same bottom-sheet chrome, etc.), check whether
extracting a shared widget is the better fix — see `OnboardingStepScaffold` and
`AppBottomSheet` for precedent. Do the extraction *and* the token fix together
rather than tokens now, extraction maybe-later.

### After changing a shared widget's public API

Removing or renaming a constructor parameter on a shared widget (e.g. dropping
color params once it switches to `context.colors` internally) passes `flutter
analyze` on `lib/` even when a test still calls the old signature — analyzer only
checks `lib/` by default, and the break only surfaces as a `test/` compile error in
CI. Before considering such a change done: `grep -rl '<WidgetName>(' test/` for
existing usages and update them in the same change.

---

## 8 — Anti-patterns checklist

Before submitting any UI code, verify none of these are present:

- [ ] `GymColors.dark*` used directly in a widget (not in `theme.dart`)
- [ ] `Colors.grey`, `Colors.red`, `Colors.blue`, etc. in widget files
- [ ] `Color(0xFF...)` raw hex in widget files
- [ ] `EdgeInsets.all(16)` or `EdgeInsets.symmetric(...)` with magic numbers
- [ ] `SizedBox(height: 12)` or similar magic-number spacers
- [ ] `BorderRadius.circular(...)` inline in widget code
- [ ] `GoogleFonts.inter(...)` or any `GoogleFonts.*` call in widget files
- [ ] `Theme.of(context).colorScheme` written longhand when `context.colors` is available
- [ ] `Theme.of(context).textTheme` written longhand when `context.textTheme` is available
- [ ] A new button/icon-button widget that duplicates `PrimaryButton`, `GhostButton`, or `IconChip`
- [ ] `isDark` branching with `GymColors.dark*` vs `GymColors.light*` — use `cs.*` instead
- [ ] A shared widget's constructor changed without grepping `test/` for existing callers

---

## 9 — Where things live

```
lib/ui/core/
├── themes/
│   ├── app_spacing.dart      ← AppSpacing tokens
│   ├── app_border_radius.dart ← AppBorderRadius tokens
│   ├── colors.dart            ← GymColors raw tokens + AppColors schemes
│   ├── theme.dart             ← AppTheme (materialDarkTheme / materialLightTheme)
│   └── typography.dart        ← CustomTypography (text scale)
├── widgets/
│   ├── primary_button.dart
│   ├── ghost_button.dart
│   ├── icon_chip.dart
│   ├── section_label.dart
│   ├── sheet_primary_button.dart
│   ├── page_header.dart
│   ├── stat_card.dart
│   └── ... (other shared widgets)
├── dismissible_backgrounds.dart
├── empty_state.dart
├── error_state.dart
└── loading.dart

lib/core/extensions/theme_extension.dart  ← context.colors / context.textTheme
```
