import 'package:flutter/material.dart';

import '../signals.dart';

/// [Watch] Widget that will rebuild when any signals
/// inside the builder change
class Watch<T extends Widget> extends StatefulWidget {
  const Watch(this.builder, {super.key});

  /// The widget to rebuild when any signals change
  final T Function() builder;

  @override
  State<Watch<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<Watch<T>> {
  late final signal = computed(() => widget.builder());
  EffectCleanup? fn;

  void init() {
    fn?.call();
    fn = effect(() {
      signal.value;
      if (mounted) {
        (context as Element).markNeedsBuild();
      }
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    init();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    fn?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return signal.value;
  }
}
