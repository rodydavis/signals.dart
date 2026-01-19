import 'package:flutter/widgets.dart';

import '../core/readonly.dart';
import 'signal.dart';

/// Takes a list of signals and a child and provides them to the widget tree
class MultiSignalProvider extends StatelessWidget {
  /// Takes a list of signals and a child and provides them to the widget tree
  const MultiSignalProvider({
    super.key,
    required this.signals,
    required this.child,
  });

  /// List of signals to provide
  final List<FlutterReadonlySignal Function()> signals;

  /// Child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final signal in signals.reversed) {
      tree = SignalProvider(
        create: signal,
        child: tree,
      );
    }
    return tree;
  }
}
