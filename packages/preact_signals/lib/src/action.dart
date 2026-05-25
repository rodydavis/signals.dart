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
Function action(Function fn, {ActionOptions? options}) {
  return ([
    Object? a0 = const _Sentinel(),
    Object? a1 = const _Sentinel(),
    Object? a2 = const _Sentinel(),
    Object? a3 = const _Sentinel(),
    Object? a4 = const _Sentinel(),
    Object? a5 = const _Sentinel(),
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
        return Function.apply(fn, args);
      });
    });
  };
}

/// Wraps a 0-argument callback function in a type-safe action.
R Function() action0<R>(R Function() fn, {ActionOptions? options}) {
  return () => batch(() => untracked(fn));
}

/// Wraps a 1-argument callback function in a type-safe action.
R Function(A) action1<A, R>(R Function(A) fn, {ActionOptions? options}) {
  return (a) => batch(() => untracked(() => fn(a)));
}

/// Wraps a 2-argument callback function in a type-safe action.
R Function(A, B) action2<A, B, R>(R Function(A, B) fn,
    {ActionOptions? options}) {
  return (a, b) => batch(() => untracked(() => fn(a, b)));
}
