import 'batch.dart';
import 'untracked.dart';
import 'options.dart';

class _Sentinel {
  const _Sentinel();
}

/// Wraps a callback function in an action.
///
/// When the returned function is called, it executes the original function
/// inside a [batch] and [untracked] block.
/// Supports up to 10 positional arguments. For functions with more arguments,
/// use [actionList].
Function action(Function fn, {ActionOptions? options}) {
  return ([
    Object? a0 = const _Sentinel(),
    Object? a1 = const _Sentinel(),
    Object? a2 = const _Sentinel(),
    Object? a3 = const _Sentinel(),
    Object? a4 = const _Sentinel(),
    Object? a5 = const _Sentinel(),
    Object? a6 = const _Sentinel(),
    Object? a7 = const _Sentinel(),
    Object? a8 = const _Sentinel(),
    Object? a9 = const _Sentinel(),
  ]) {
    return batch(() {
      return untracked(() {
        final args = [
          if (a0 is! _Sentinel) a0,
          if (a1 is! _Sentinel) a1,
          if (a2 is! _Sentinel) a2,
          if (a3 is! _Sentinel) a3,
          if (a4 is! _Sentinel) a4,
          if (a5 is! _Sentinel) a5,
          if (a6 is! _Sentinel) a6,
          if (a7 is! _Sentinel) a7,
          if (a8 is! _Sentinel) a8,
          if (a9 is! _Sentinel) a9,
        ];
        return Function.apply(fn, args);
      });
    });
  };
}

/// Wraps a callback function in an action that is invoked with a list of arguments.
///
/// This has no limit on the number of arguments.
Function actionList(Function fn, {ActionOptions? options}) {
  return (List<dynamic> args) {
    return batch(() {
      return untracked(() {
        return Function.apply(fn, args);
      });
    });
  };
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


/// Extension on any function to wrap it in an action that accepts a list of arguments.
extension ActionFunctionListExtension on Function {
  /// Wraps this function in an action that can be invoked with a list of arguments.
  dynamic Function(List<dynamic> args) toActionList({ActionOptions? options}) {
    return (List<dynamic> args) {
      return batch(() {
        return untracked(() {
          return Function.apply(this, args);
        });
      });
    };
  }
}
