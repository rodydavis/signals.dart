import 'batch.dart';
import 'untracked.dart';

/// Wraps a callback function into a reusable, batched, and untracked action.
///
/// An **action** is a higher-order function that takes a callback and returns a new function
/// with the exact same signature. When the returned function is executed, it runs the original
/// callback inside both a [batch] and an [untracked] block.
///
/// ### Why use `action` instead of `batch`?
///
/// 1. **Reusability**: `batch(fn)` executes the callback immediately. In contrast, `action(fn)`
///    returns a *reusable function* that you can store, pass around, and invoke multiple times
///    to perform batch transactions on demand.
/// 2. **Untracked Execution**: The callback runs inside `untracked`. If you invoke the action
///    from within an `effect` or a `computed` signal, the outer reactive context **will not**
///    establish subscriptions to any signals read inside the action.
///
/// ---
///
/// ### Example: Comparing Normal Updates vs. Action Batching
///
/// #### Without Actions (Standard Sequential Updates)
///
/// Every signal write immediately notifies active subscribers. This causes transient states
/// and redundant, intermediate executions:
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final a = signal('a');
/// final b = signal('b');
///
/// void main() {
///   // Set up a subscriber effect
///   effect(() => print('${a.value} ${b.value}'));
///   // Prints immediately: "a b"
/// 
///   a.value = 'aa'; // Prints: "aa b"
///   b.value = 'bb'; // Prints: "aa bb"
/// }
/// ```
/// Total prints: **3** (initial execution + 2 updates).
///
/// #### With Actions (Coalesced Transaction)
///
/// By wrapping the state-mutating function in [action], all updates are postponed and flushed
/// in a single notification block once the function completes:
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final a = signal('a');
/// final b = signal('b');
///
/// // Create a reusable action
/// final updateFields = action((String nextA, String nextB) {
///   a.value = nextA;
///   b.value = nextB;
/// });
///
/// void main() {
///   effect(() => print('${a.value} ${b.value}'));
///   // Prints immediately: "a b"
///
///   updateFields('aa', 'bb');
///   // The effect is deferred during execution and triggers exactly once at the end.
///   // Prints: "aa bb"
/// }
/// ```
/// Total prints: **2** (initial execution + 1 coalesced update).
///
/// ---
///
/// ### Type-Safety & Extensions
///
/// While `action` accepts any generic `Function`, Dart's static analysis benefits greatly from
/// type-safe variants or extensions. 
///
/// - **Type-safe functions**: Use `action0` through `action10` (e.g. `action2(...)` for 2 arguments) to preserve type arguments.
/// - **Extensions**: Call `.action` directly on any Dart function (e.g., `myFunction.action`).
Function action(Function fn) => switch (fn) {
      void Function() _ => () => batch(
            () => untracked(() => (fn as dynamic)()),
          ),
      void Function(Never) _ => (a) => batch(
            () => untracked(() => (fn as dynamic)(a)),
          ),
      void Function(Never, Never) _ => (a, b) => batch(
            () => untracked(() => (fn as dynamic)(a, b)),
          ),
      void Function(Never, Never, Never) _ => (a, b, c) => batch(
            () => untracked(() => (fn as dynamic)(a, b, c)),
          ),
      void Function(Never, Never, Never, Never) _ => (a, b, c, d) => batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d)),
          ),
      void Function(Never, Never, Never, Never, Never) _ => (a, b, c, d, e) =>
          batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d, e)),
          ),
      void Function(Never, Never, Never, Never, Never, Never) _ => (
          a,
          b,
          c,
          d,
          e,
          f,
        ) =>
          batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d, e, f)),
          ),
      void Function(Never, Never, Never, Never, Never, Never, Never) _ => (
          a,
          b,
          c,
          d,
          e,
          f,
          g,
        ) =>
          batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d, e, f, g)),
          ),
      void Function(
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
      ) _ =>
        (
          a,
          b,
          c,
          d,
          e,
          f,
          g,
          h,
        ) =>
          batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d, e, f, g, h)),
          ),
      void Function(
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
      ) _ =>
        (
          a,
          b,
          c,
          d,
          e,
          f,
          g,
          h,
          i,
        ) =>
          batch(
            () => untracked(() => (fn as dynamic)(a, b, c, d, e, f, g, h, i)),
          ),
      void Function(
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
        Never,
      ) _ =>
        (
          a,
          b,
          c,
          d,
          e,
          f,
          g,
          h,
          i,
          j,
        ) =>
          batch(
            () => untracked(
              () => (fn as dynamic)(a, b, c, d, e, f, g, h, i, j),
            ),
          ),
      _ => fn,
    };

// ---------------------------------------------------------------------------
// Type-safe Global Wrappers
// ---------------------------------------------------------------------------

/// Wraps a 0-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final increment = action0(() {
///   count.value++;
///   clicks.value++;
/// });
/// ```
R Function() action0<R>(R Function() fn) => () => batch(() => untracked(fn));

/// Wraps a 1-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final setName = action1((String newName) {
///   name.value = newName;
///   updatedAt.value = DateTime.now();
/// });
/// ```
R Function(A) action1<A, R>(R Function(A) fn) =>
    (a) => batch(() => untracked(() => fn(a)));

/// Wraps a 2-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final updateProfile = action2((String newName, int newAge) {
///   name.value = newName;
///   age.value = newAge;
/// });
/// ```
R Function(A, B) action2<A, B, R>(R Function(A, B) fn) =>
    (a, b) => batch(() => untracked(() => fn(a, b)));

/// Wraps a 3-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final setCoordinates = action3((double lat, double lng, String label) {
///   latitude.value = lat;
///   longitude.value = lng;
///   locationName.value = label;
/// });
/// ```
R Function(A, B, C) action3<A, B, C, R>(R Function(A, B, C) fn) =>
    (a, b, c) => batch(() => untracked(() => fn(a, b, c)));

/// Wraps a 4-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final updateUserData = action4((String name, int age, double score, bool active) {
///   userName.value = name;
///   userAge.value = age;
///   userScore.value = score;
///   userActive.value = active;
/// });
/// ```
R Function(A, B, C, D) action4<A, B, C, D, R>(R Function(A, B, C, D) fn) =>
    (a, b, c, d) => batch(() => untracked(() => fn(a, b, c, d)));

/// Wraps a 5-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
///
/// ### Example Usage
///
/// ```dart
/// final setConfig = action5((int w, int h, String title, bool dark, double opacity) {
///   width.value = w;
///   height.value = h;
///   appTitle.value = title;
///   themeDark.value = dark;
///   bgOpacity.value = opacity;
/// });
/// ```
R Function(A, B, C, D, E) action5<A, B, C, D, E, R>(
  R Function(A, B, C, D, E) fn,
) =>
    (a, b, c, d, e) => batch(() => untracked(() => fn(a, b, c, d, e)));

/// Wraps a 6-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
R Function(A, B, C, D, E, F) action6<A, B, C, D, E, F, R>(
  R Function(A, B, C, D, E, F) fn,
) =>
    (a, b, c, d, e, f) => batch(
          () => untracked(() => fn(a, b, c, d, e, f)),
        );

/// Wraps a 7-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
R Function(A, B, C, D, E, F, G) action7<A, B, C, D, E, F, G, R>(
  R Function(A, B, C, D, E, F, G) fn,
) =>
    (a, b, c, d, e, f, g) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g)),
        );

/// Wraps an 8-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
R Function(A, B, C, D, E, F, G, H) action8<A, B, C, D, E, F, G, H, R>(
  R Function(A, B, C, D, E, F, G, H) fn,
) =>
    (a, b, c, d, e, f, g, h) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g, h)),
        );

/// Wraps a 9-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
R Function(A, B, C, D, E, F, G, H, I) action9<A, B, C, D, E, F, G, H, I, R>(
  R Function(A, B, C, D, E, F, G, H, I) fn,
) =>
    (a, b, c, d, e, f, g, h, i) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g, h, i)),
        );

/// Wraps a 10-argument callback function in a type-safe action.
///
/// Executes [fn] inside a transaction-safe [batch] and [untracked] block.
R Function(
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
) action10<A, B, C, D, E, F, G, H, I, J, R>(
  R Function(A, B, C, D, E, F, G, H, I, J) fn,
) =>
    (a, b, c, d, e, f, g, h, i, j) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g, h, i, j)),
        );

// ---------------------------------------------------------------------------
// Idiomatic Dart Extensions
// ---------------------------------------------------------------------------

/// Extension on a 0-argument function to wrap it in a type-safe action.
///
/// Enables calling `.action` directly on any 0-argument function to wrap it.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
/// final clicks = signal(0);
///
/// void incrementCount() {
///   count.value++;
///   clicks.value++;
/// }
///
/// // Create a batched, untracked action from the function
/// final increment = incrementCount.action;
///
/// void main() {
///   effect(() => print('Count: ${count.value}, Clicks: ${clicks.value}'));
///   // Prints: "Count: 0, Clicks: 0"
///
///   increment();
///   // Updates both count and clicks inside a batch.
///   // Triggers the effect exactly once.
///   // Prints: "Count: 1, Clicks: 1"
/// }
/// ```
extension ActionExt0<R> on R Function() {
  /// Wraps the 0-argument function in a type-safe action.
  R Function() get action => () => batch(() => untracked(this));
}

/// Extension on a 1-argument function to wrap it in a type-safe action.
///
/// Enables calling `.action` directly on any 1-argument function to wrap it.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final name = signal('Jane');
/// final clicks = signal(0);
///
/// void updateName(String newName) {
///   name.value = newName;
///   clicks.value++;
/// }
///
/// // Create a batched, untracked action from the function
/// final setName = updateName.action;
///
/// void main() {
///   effect(() => print('Name: ${name.value}, Clicks: ${clicks.value}'));
///   // Prints: "Name: Jane, Clicks: 0"
///
///   setName('John');
///   // Updates both name and clicks inside a batch.
///   // Triggers the effect exactly once.
///   // Prints: "Name: John, Clicks: 1"
/// }
/// ```
extension ActionExt1<A, R> on R Function(A) {
  /// Wraps the 1-argument function in a type-safe action.
  R Function(A) get action => (a) => batch(() => untracked(() => this(a)));
}

/// Extension on a 2-argument function to wrap it in a type-safe action.
///
/// Enables calling `.action` directly on any 2-argument function to wrap it.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final name = signal('Jane');
/// final age = signal(25);
///
/// void updateProfile(String newName, int newAge) {
///   name.value = newName;
///   age.value = newAge;
/// }
///
/// // Create a batched, untracked action from the function
/// final setProfile = updateProfile.action;
///
/// void main() {
///   effect(() => print('Name: ${name.value}, Age: ${age.value}'));
///   // Prints: "Name: Jane, Age: 25"
///
///   setProfile('John', 30);
///   // Updates both name and age inside a batch.
///   // Triggers the effect exactly once.
///   // Prints: "Name: John, Age: 30"
/// }
/// ```
extension ActionExt2<A, B, R> on R Function(A, B) {
  /// Wraps the 2-argument function in a type-safe action.
  R Function(A, B) get action =>
      (a, b) => batch(() => untracked(() => this(a, b)));
}

/// Extension on a 3-argument function to wrap it in a type-safe action.
///
/// Enables calling `.action` directly on any 3-argument function to wrap it.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final latitude = signal(0.0);
/// final longitude = signal(0.0);
/// final locationName = signal('Unknown');
///
/// void setCoordinates(double lat, double lng, String label) {
///   latitude.value = lat;
///   longitude.value = lng;
///   locationName.value = label;
/// }
///
/// // Create a batched, untracked action from the function
/// final setCoords = setCoordinates.action;
///
/// void main() {
///   effect(() => print('${locationName.value}: (${latitude.value}, ${longitude.value})'));
///   // Prints: "Unknown: (0.0, 0.0)"
///
///   setCoords(37.7749, -122.4194, 'San Francisco');
///   // Updates latitude, longitude, and locationName inside a batch.
///   // Triggers the effect exactly once.
///   // Prints: "San Francisco: (37.7749, -122.4194)"
/// }
/// ```
extension ActionExt3<A, B, C, R> on R Function(A, B, C) {
  /// Wraps the 3-argument function in a type-safe action.
  R Function(A, B, C) get action =>
      (a, b, c) => batch(() => untracked(() => this(a, b, c)));
}

/// Extension on a 4-argument function to wrap it in a type-safe action.
extension ActionExt4<A, B, C, D, R> on R Function(A, B, C, D) {
  /// Wraps the 4-argument function in a type-safe action.
  R Function(A, B, C, D) get action =>
      (a, b, c, d) => batch(() => untracked(() => this(a, b, c, d)));
}

/// Extension on a 5-argument function to wrap it in a type-safe action.
extension ActionExt5<A, B, C, D, E, R> on R Function(A, B, C, D, E) {
  /// Wraps the 5-argument function in a type-safe action.
  R Function(A, B, C, D, E) get action =>
      (a, b, c, d, e) => batch(() => untracked(() => this(a, b, c, d, e)));
}

/// Extension on a 6-argument function to wrap it in a type-safe action.
extension ActionExt6<A, B, C, D, E, F, R> on R Function(A, B, C, D, E, F) {
  /// Wraps the 6-argument function in a type-safe action.
  R Function(A, B, C, D, E, F) get action => (a, b, c, d, e, f) => batch(
        () => untracked(() => this(a, b, c, d, e, f)),
      );
}

/// Extension on a 7-argument function to wrap it in a type-safe action.
extension ActionExt7<A, B, C, D, E, F, G, R> on R Function(
  A,
  B,
  C,
  D,
  E,
  F,
  G,
) {
  /// Wraps the 7-argument function in a type-safe action.
  R Function(A, B, C, D, E, F, G) get action => (a, b, c, d, e, f, g) => batch(
        () => untracked(() => this(a, b, c, d, e, f, g)),
      );
}

/// Extension on an 8-argument function to wrap it in a type-safe action.
extension ActionExt8<A, B, C, D, E, F, G, H, R> on R Function(
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
) {
  /// Wraps the 8-argument function in a type-safe action.
  R Function(A, B, C, D, E, F, G, H) get action =>
      (a, b, c, d, e, f, g, h) => batch(
            () => untracked(() => this(a, b, c, d, e, f, g, h)),
          );
}

/// Extension on a 9-argument function to wrap it in a type-safe action.
extension ActionExt9<A, B, C, D, E, F, G, H, I, R> on R Function(
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
) {
  /// Wraps the 9-argument function in a type-safe action.
  R Function(A, B, C, D, E, F, G, H, I) get action =>
      (a, b, c, d, e, f, g, h, i) => batch(
            () => untracked(() => this(a, b, c, d, e, f, g, h, i)),
          );
}

/// Extension on a 10-argument function to wrap it in a type-safe action.
extension ActionExt10<A, B, C, D, E, F, G, H, I, J, R> on R Function(
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
) {
  /// Wraps the 10-argument function in a type-safe action.
  R Function(A, B, C, D, E, F, G, H, I, J) get action =>
      (a, b, c, d, e, f, g, h, i, j) => batch(
            () => untracked(() => this(a, b, c, d, e, f, g, h, i, j)),
          );
}
