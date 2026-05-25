import 'batch.dart';
import 'untracked.dart';

/// Wraps a dynamic callback function in an action.
///
/// When the returned function is called, it executes the original function
/// inside a [batch] and [untracked] block.
/// Supports functions of up to 10 positional arguments.
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
R Function() action0<R>(R Function() fn) => () => batch(() => untracked(fn));

/// Wraps a 1-argument callback function in a type-safe action.
R Function(A) action1<A, R>(R Function(A) fn) =>
    (a) => batch(() => untracked(() => fn(a)));

/// Wraps a 2-argument callback function in a type-safe action.
R Function(A, B) action2<A, B, R>(R Function(A, B) fn) =>
    (a, b) => batch(() => untracked(() => fn(a, b)));

/// Wraps a 3-argument callback function in a type-safe action.
R Function(A, B, C) action3<A, B, C, R>(R Function(A, B, C) fn) =>
    (a, b, c) => batch(() => untracked(() => fn(a, b, c)));

/// Wraps a 4-argument callback function in a type-safe action.
R Function(A, B, C, D) action4<A, B, C, D, R>(R Function(A, B, C, D) fn) =>
    (a, b, c, d) => batch(() => untracked(() => fn(a, b, c, d)));

/// Wraps a 5-argument callback function in a type-safe action.
R Function(A, B, C, D, E) action5<A, B, C, D, E, R>(
  R Function(A, B, C, D, E) fn,
) =>
    (a, b, c, d, e) => batch(() => untracked(() => fn(a, b, c, d, e)));

/// Wraps a 6-argument callback function in a type-safe action.
R Function(A, B, C, D, E, F) action6<A, B, C, D, E, F, R>(
  R Function(A, B, C, D, E, F) fn,
) =>
    (a, b, c, d, e, f) => batch(
          () => untracked(() => fn(a, b, c, d, e, f)),
        );

/// Wraps a 7-argument callback function in a type-safe action.
R Function(A, B, C, D, E, F, G) action7<A, B, C, D, E, F, G, R>(
  R Function(A, B, C, D, E, F, G) fn,
) =>
    (a, b, c, d, e, f, g) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g)),
        );

/// Wraps an 8-argument callback function in a type-safe action.
R Function(A, B, C, D, E, F, G, H) action8<A, B, C, D, E, F, G, H, R>(
  R Function(A, B, C, D, E, F, G, H) fn,
) =>
    (a, b, c, d, e, f, g, h) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g, h)),
        );

/// Wraps a 9-argument callback function in a type-safe action.
R Function(A, B, C, D, E, F, G, H, I) action9<A, B, C, D, E, F, G, H, I, R>(
  R Function(A, B, C, D, E, F, G, H, I) fn,
) =>
    (a, b, c, d, e, f, g, h, i) => batch(
          () => untracked(() => fn(a, b, c, d, e, f, g, h, i)),
        );

/// Wraps a 10-argument callback function in a type-safe action.
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
extension ActionExt0<R> on R Function() {
  /// Wraps the 0-argument function in a type-safe action.
  R Function() get action => () => batch(() => untracked(this));
}

/// Extension on a 1-argument function to wrap it in a type-safe action.
extension ActionExt1<A, R> on R Function(A) {
  /// Wraps the 1-argument function in a type-safe action.
  R Function(A) get action => (a) => batch(() => untracked(() => this(a)));
}

/// Extension on a 2-argument function to wrap it in a type-safe action.
extension ActionExt2<A, B, R> on R Function(A, B) {
  /// Wraps the 2-argument function in a type-safe action.
  R Function(A, B) get action =>
      (a, b) => batch(() => untracked(() => this(a, b)));
}

/// Extension on a 3-argument function to wrap it in a type-safe action.
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
