import 'batch.dart';
import 'untracked.dart';

/// Wraps a callback function in an action.
///
/// When the returned function is called, it executes the original function
/// inside a [batch] and [untracked] block.
/// Supports functions of up to 6 positional arguments.
Function action(Function fn) {
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

/// Wraps a 0-argument callback function in a type-safe action.
R Function() action0<R>(R Function() fn) {
  return () => batch(() => untracked(fn));
}

/// Wraps a 1-argument callback function in a type-safe action.
R Function(A) action1<A, R>(R Function(A) fn) {
  return (a) => batch(() => untracked(() => fn(a)));
}

/// Wraps a 2-argument callback function in a type-safe action.
R Function(A, B) action2<A, B, R>(R Function(A, B) fn) {
  return (a, b) => batch(() => untracked(() => fn(a, b)));
}

/// Wraps a 3-argument callback function in a type-safe action.
R Function(A, B, C) action3<A, B, C, R>(R Function(A, B, C) fn) {
  return (a, b, c) => batch(() => untracked(() => fn(a, b, c)));
}

/// Wraps a 4-argument callback function in a type-safe action.
R Function(A, B, C, D) action4<A, B, C, D, R>(R Function(A, B, C, D) fn) {
  return (a, b, c, d) => batch(() => untracked(() => fn(a, b, c, d)));
}

/// Wraps a 5-argument callback function in a type-safe action.
R Function(A, B, C, D, E) action5<A, B, C, D, E, R>(R Function(A, B, C, D, E) fn) {
  return (a, b, c, d, e) => batch(() => untracked(() => fn(a, b, c, d, e)));
}

/// Wraps a 6-argument callback function in a type-safe action.
R Function(A, B, C, D, E, F) action6<A, B, C, D, E, F, R>(
    R Function(A, B, C, D, E, F) fn) {
  return (a, b, c, d, e, f) => batch(() => untracked(() => fn(a, b, c, d, e, f)));
}
