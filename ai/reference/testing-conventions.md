# Testing Conventions — gym_workouts

Read this file in full before writing, reviewing, or expanding tests. It covers the
concrete mechanics; pair it with the `flutter-tester` agent's own instructions for
role/approach.

---

## 1 — File organization

- Tests live under `test/`, mirroring the `lib/` structure path-for-path: a BLoC at
  `lib/ui/reports/bloc/report_bloc.dart` gets its test at
  `test/ui/reports/bloc/report_bloc_test.dart`.
- One test file per source file, named `<source>_test.dart`.

## 2 — Mocking: mocktail only

This project depends on both `mocktail` and `mockito`, but in practice **only
mocktail is used** (33 files import it; 0 import mockito, no generated
`*.mocks.dart` files exist). Always use mocktail for new tests — never introduce
mockito's `@GenerateMocks` codegen pattern.

```dart
class MockWorkoutRepository extends Mock implements WorkoutRepository {}
class FakeUserWorkout extends Fake implements UserWorkout {}
```

- `Mock` for interfaces/classes you stub methods on.
- `Fake` for a throwaway instance only needed to satisfy `registerFallbackValue` —
  it doesn't need real field values.

### `registerFallbackValue` — when it's actually required

`any()`/`captureAny()` need a registered fallback **only** for types mocktail can't
auto-generate a dummy for. Mocktail already has trivial fallbacks built in for:
`bool`, `int`, `double`, `String`, `List<T>` (any T — the covariance trick works),
`Map<K,V>`, `Set<T>`, `DateTime`, and a couple of others.

**You must call `registerFallbackValue` for:**
- Enums (e.g. `ReportPeriod`, `WeightUnit`) — not covered by the trivial list.
- Any custom class/entity passed to `any()` (register a `Fake` instance).

```dart
setUpAll(() {
  registerFallbackValue(ReportPeriod.fourWeeks); // enum — needs it
  registerFallbackValue(FakeUserWorkout());       // custom class — needs it
  // any(named: 'sessions') for List<WorkoutSession> does NOT need registration
});
```

Skipping this produces a clear `StateError` at test-run time naming the missing
type — don't guess, just register what the error asks for.

## 3 — BLoC testing: `blocTest`

Use `bloc_test`'s `blocTest<BlocType, StateType>` — not raw `test()` calling
`bloc.add()` — for every BLoC:

```dart
blocTest<ReportBloc, ReportState>(
  'emits [Loading, Error] when no user is authenticated',
  setUp: () {
    when(() => mockAuthRepository.getCurrentUserId()).thenAnswer((_) async => const Right(null));
  },
  build: () => ReportBloc(authRepository: mockAuthRepository, /* ... */),
  act: (bloc) => bloc.add(const LoadReportEvent()),
  expect: () => [const ReportLoading(), const ReportError('User not authenticated')],
  verify: (_) {
    verify(() => someRepository.someMethod(any())).called(1);
  },
);
```

- `setUp` (per-test stubbing) runs before `build`; keep shared/default stubs in a
  helper function (e.g. `stubHappyPath()`) called from each test's `setUp` so
  variations only override what differs.
- Prefer a fresh `Mock*` instance per test (`setUp` at the `group`/`main` level,
  not shared mutable state) — mirrors what every existing `*_bloc_test.dart` does.
- For side-effecting dependencies with no useful return value to assert on (e.g.
  `AnalyticsService`), a hand-written recording fake is often clearer than a mock:
  ```dart
  class RecordingAnalyticsService implements AnalyticsService {
    String? lastTrackedTheme;
    @override
    Future<void> trackThemeChanged({required String theme}) async { lastTrackedTheme = theme; }
    // ...implement the rest as no-ops
  }
  ```

### Avoid flaky `DateTime.now()` assertions

Don't assert exact equality between two independently-computed
`DateTime.now()`-derived values (e.g. the bloc's internal call and the test's
verify) — they can differ by milliseconds. Use `captureAny` and assert a tolerance,
or don't assert the exact instant at all:

```dart
final captured = verify(
  () => mockRepo.getSessionHistory(userId: userId, startDate: captureAny(named: 'startDate'), limit: 100),
).captured;
final capturedStartDate = captured.single as DateTime;
expect(expectedStartDate.difference(capturedStartDate).inSeconds.abs(), lessThan(5));
```

## 4 — Widget tests

31 files use `testWidgets`. No golden-image tests exist in this project — stick to
behavioral assertions (`find.text(...)`, `find.byType(...)`, tapping and pumping)
rather than introducing golden tests unless explicitly asked.

## 5 — Coverage: the `firebase_options.dart` trap

`flutter test --coverage` **requires `lib/firebase_options.dart` to exist**, real or
stubbed. If it's missing, every test file that transitively imports it (directly or
via `main.dart`/router/screens) fails to even compile, and Dart's coverage collector
silently **drops those source files from `lcov.info` entirely** instead of counting
them as uncovered. The result is an inflated, wrong coverage percentage that looks
fine locally but doesn't match CI (which stubs the file).

Before running `flutter test --coverage` locally, create the same stub CI uses
(`.github/workflows/pr-checks.yml` / `update-metrics.yml`) if the real file isn't
committed:

```bash
cat > lib/firebase_options.dart << 'EOF'
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => _stub;
  static const FirebaseOptions _stub = FirebaseOptions(
    apiKey: 'ci-stub', appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000', projectId: 'gym-workouts',
    storageBucket: 'gym-workouts.firebasestorage.app',
    iosBundleId: 'com.anoguez.gymWorkouts',
  );
}
EOF
```
Remove it afterward if it's not meant to be committed (check whether the real file
has landed yet — see `.gitignore` and `.claude/CLAUDE.md`'s Firebase Configuration
section). Never let this stub leak into `lib/` in a commit alongside real source
changes — it inflates `dart.loc`/`dart.fileCount` in `code-metrics.json`.

## 6 — Finding coverage gaps

After a full `flutter test --coverage` run, find the biggest zero/low-coverage
files by lines (not just percentage, to prioritize by real impact):

```bash
awk '
/^SF:/ { file=$0; sub("SF:", "", file); hit=0; total=0 }
/^DA:/ { total++; split($0, a, ","); if (a[2]+0 > 0) hit++ }
/^end_of_record/ { if (total > 0) printf "%.1f\t%d\t%s\n", (hit/total)*100, total, file }
' coverage/lcov.info | sort -t$'\t' -k1,1n -k2,2nr | head -30
```

**Prioritize by ROI, not just by size:**
- **High ROI**: BLoCs (`lib/ui/**/bloc/*.dart`), domain services/calculators
  (`lib/domain/services/`) — pure logic, mock 1-3 repository interfaces, cheap to
  test thoroughly. Do these first.
- **Low ROI**: `lib/data/services/*_impl.dart` (thin Firestore wrappers) and
  `lib/core/services/firebase_service.dart`/`firestore_service_impl.dart` — testing
  these means mocking the Firestore SDK itself, which is heavier for less
  confidence gained. Usually not worth it unless specifically asked.

## 7 — Updating the coverage baseline

Once new tests are in and the full suite passes, refresh `code-metrics.json` and
`README.md` together so the "before" number in future PRs is accurate:

```bash
node tools/code-metrics/bin/code-metrics.js run --update-readme --update-baseline
```

Don't hand-edit the coverage number in `code-metrics.json` — always regenerate it
from a real `flutter test --coverage` run so the baseline reflects an actual
measurement, not a guess.
