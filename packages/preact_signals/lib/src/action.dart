import 'batch.dart';
import 'untracked.dart';
import 'options.dart';

/// Wraps a callback function in an action.
///
/// When the returned function is called, it executes the original function
/// inside a [batch] and [untracked] block.
/// Supports functions of up to 6 positional arguments.
Function action(Function fn, {ActionOptions? options}) {
  if (fn is void Function()) {
    return () => batch(() => untracked(fn));
  }
  if (fn is void Function(Never)) {
    return (a) => batch(() => untracked(() => (fn as Function)(a)));
  }
  if (fn is void Function(Never, Never)) {
    return (a, b) => batch(() => untracked(() => (fn as Function)(a, b)));
  }
  if (fn is void Function(Never, Never, Never)) {
    return (a, b, c) => batch(() => untracked(() => (fn as Function)(a, b, c)));
  }
  if (fn is void Function(Never, Never, Never, Never)) {
    return (a, b, c, d) =>
        batch(() => untracked(() => (fn as Function)(a, b, c, d)));
  }
  if (fn is void Function(Never, Never, Never, Never, Never)) {
    return (a, b, c, d, e) =>
        batch(() => untracked(() => (fn as Function)(a, b, c, d, e)));
  }
  if (fn is void Function(Never, Never, Never, Never, Never, Never)) {
    return (a, b, c, d, e, f) =>
        batch(() => untracked(() => (fn as Function)(a, b, c, d, e, f)));
  }
  return fn;
}

/// Extension on 0-argument functions to wrap them in a type-safe action.
extension ActionFunction0Extension<R> on R Function() {
  /// Wraps this function in a type-safe action.
  R Function() toAction({ActionOptions? options}) {
    return () => batch(() => untracked(this));
  }
}

/// Extension on 1-argument functions to wrap them in a type-safe action.
extension ActionFunction1Extension<A, R> on R Function(A) {
  /// Wraps this function in a type-safe action.
  R Function(A) toAction({ActionOptions? options}) {
    return (a) => batch(() => untracked(() => this(a)));
  }
}

/// Extension on 2-argument functions to wrap them in a type-safe action.
extension ActionFunction2Extension<A, B, R> on R Function(A, B) {
  /// Wraps this function in a type-safe action.
  R Function(A, B) toAction({ActionOptions? options}) {
    return (a, b) => batch(() => untracked(() => this(a, b)));
  }
}

/// Extension on 3-argument functions to wrap them in a type-safe action.
extension ActionFunction3Extension<A, B, C, R> on R Function(A, B, C) {
  /// Wraps this function in a type-safe action.
  R Function(A, B, C) toAction({ActionOptions? options}) {
    return (a, b, c) => batch(() => untracked(() => this(a, b, c)));
  }
}

/// Extension on 4-argument functions to wrap them in a type-safe action.
extension ActionFunction4Extension<A, B, C, D, R> on R Function(A, B, C, D) {
  /// Wraps this function in a type-safe action.
  R Function(A, B, C, D) toAction({ActionOptions? options}) {
    return (a, b, c, d) => batch(() => untracked(() => this(a, b, c, d)));
  }
}

/// Extension on 5-argument functions to wrap them in a type-safe action.
extension ActionFunction5Extension<A, B, C, D, E, R> on R Function(A, B, C, D, E) {
  /// Wraps this function in a type-safe action.
  R Function(A, B, C, D, E) toAction({ActionOptions? options}) {
    return (a, b, c, d, e) => batch(() => untracked(() => this(a, b, c, d, e)));
  }
}

/// Extension on 6-argument functions to wrap them in a type-safe action.
extension ActionFunction6Extension<A, B, C, D, E, F, R> on R Function(A, B, C, D, E, F) {
  /// Wraps this function in a type-safe action.
  R Function(A, B, C, D, E, F) toAction({ActionOptions? options}) {
    return (a, b, c, d, e, f) => batch(() => untracked(() => this(a, b, c, d, e, f)));
  }
}
