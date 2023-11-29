import 'package:flutter/material.dart';

import 'signals.dart';

/// [Watch] Widget that will rebuild when any single
/// inside the builder changes
class Watch<T extends Widget> extends StatefulWidget {
  const Watch(this.builder, {super.key});

  /// The widget to rebuild when the signal changes
  final T Function() builder;

  @override
  State<Watch<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<Watch<T>> {
  late final signal = computed(() => widget.builder());
  late Widget child = signal.value;

  EffectCleanup? fn;

  @override
  void initState() {
    super.initState();
    fn = effect(() {
      child = signal.value;
      if (mounted) {
        (context as Element).markNeedsBuild();
      }
    });
  }

  @override
  void dispose() {
    fn?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
