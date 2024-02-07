import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

final _store = <WeakReference<Element>, EffectCleanup?>{};

/// Create an effect callback in the build method
///
/// ```dart
/// import 'package:signals/signals_flutter.dart';
///
/// class Counter extends ... {
/// ...
///   @override
///   Widget build(BuildContext context) {
/// 	  const count = useSignal(context, 0);
/// 	  const doubleValue = useComputed(context, () => count.value * 2);
///
/// 	  useSignalEffect(context, () => {
/// 	  	console.log(`Value: ${count.value}, value x 2 = ${doubleValue.value}`);
/// 	  });
///
///     return Button(
///        onPressed: () => count.value++,
///        child: Text('Value: $count, value x 2 = $doubleValue');
///     );
///   }
/// }
/// ```
EffectCleanup useSignalEffect<T>(
  BuildContext context,
  dynamic Function() callback, {
  String? debugLabel,
}) {
  assert(context is Element);
  final current = _store.entries.firstWhere(
    (e) => e.key.target == context,
    orElse: () => MapEntry(WeakReference(context as Element), null),
  );
  return _store[current.key] ??= effect(
    callback,
    debugLabel: debugLabel,
    onDispose: () {
      _store.removeWhere((k, v) => k.target == context);
    },
  );
}
