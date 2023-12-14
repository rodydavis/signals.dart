import 'package:flutter/material.dart';
import 'package:signals_core/signals_core.dart';

import 'extension.dart';

/// [Watch] is a drop-in replacement for [Builder] that will rebuild
/// when any signals inside the builder change
class Watch<T extends Widget> extends StatefulWidget {
  const Watch(this.builder, {super.key, this.debugLabel});

  /// The widget to rebuild when any signals change
  final T Function(BuildContext context) builder;
  final String? debugLabel;

  @override
  State<Watch<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<Watch<T>> {
  Widget? child;
  EffectCleanup? fn;

  @override
  void reassemble() {
    super.reassemble();
    clearSubscribers();
    reloadSignalsDevTools();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (child != null) rebuild();
  }

  @override
  void dispose() {
    fn?.call();
    super.dispose();
  }

  void rebuild() {
    if (!mounted) return;
    final result = widget.builder(context);
    if (result == child) return;
    child = result;
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    fn ??= effect(
      () {
        if (child == null) {
          child = widget.builder(context);
        } else {
          rebuild();
        }
      },
      debugLabel: widget.debugLabel,
    );
    return child!;
  }
}
