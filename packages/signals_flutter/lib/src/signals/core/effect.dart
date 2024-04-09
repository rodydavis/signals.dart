import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../signals_flutter.dart';

/// Create an effect then watch signals and only call the callback with the widget is mounted.
///
/// ```dart
/// class State extends ... {
///  final count = createSignal(this, 0);
///
///  @override
///  void initState() {
///    super.initState();
///    createEffect(this, () {
///      print('count: ${_counter()}');
///    });
///  }
///
///  @override
///  Widget build(BuildContext context) {
///    return Row(
///     children: [
///       IconButton(icon: Icon(Icons.remove), onPressed: () => count.value--),
///       Text('$count, even=$isEven, odd=$isOdd'),
///       IconButton(icon: Icon(Icons.add), onPressed: () => count.value++),
///    ],
///   );
///  }
/// }
/// ```
void Function() createEffect<S extends StatefulWidget>(
  BuildContext context,
  dynamic Function() callback, {
  String? debugLabel,
  dynamic Function()? onDispose,
}) {
  assert(context is StatefulElement,
      'createEffect must be called in a StatefulElement like State<T>');
  final dispose = effect(
    () async {
      final cb = callback();
      if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
        await SchedulerBinding.instance.endOfFrame;
      }
      return cb;
    },
    debugLabel: debugLabel,
    onDispose: onDispose,
  );
  if (context is StatefulElement && context.state is SignalsAutoDisposeMixin) {
    final el = context.state as SignalsAutoDisposeMixin;
    el.addEffectDisposeCallback(dispose);
  }
  return dispose;
}
