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
        final args = [];
        if (a0 is! _Sentinel) args.add(a0);
        if (a1 is! _Sentinel) args.add(a1);
        if (a2 is! _Sentinel) args.add(a2);
        if (a3 is! _Sentinel) args.add(a3);
        if (a4 is! _Sentinel) args.add(a4);
        if (a5 is! _Sentinel) args.add(a5);
        if (a6 is! _Sentinel) args.add(a6);
        if (a7 is! _Sentinel) args.add(a7);
        if (a8 is! _Sentinel) args.add(a8);
        if (a9 is! _Sentinel) args.add(a9);
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
