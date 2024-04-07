import 'package:flutter/material.dart';

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
  State<S> widget,
  dynamic Function() callback, {
  String? debugLabel,
  dynamic Function()? onDispose,
}) {
  final dispose = effect(
    () {
      final context = widget.context;
      if (context is Element && context.mounted) {
        return callback();
      }
    },
    debugLabel: debugLabel,
    onDispose: onDispose,
  );
  if (widget case SignalsAutoDisposeMixin w) {
    w.addEffectDisposeCallback(dispose);
  }
  return dispose;
}
