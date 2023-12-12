import 'package:flutter/material.dart';

import '../core/signals.dart';
import 'extension.dart';

/// [Watch] is a drop-in replacement for [Builder] that will rebuild
/// when any signals inside the builder change
class Watch<T extends Widget> extends StatefulWidget {
  const Watch(this.builder, {super.key});

  /// The widget to rebuild when any signals change
  final T Function(BuildContext context) builder;

  @override
  State<Watch<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<Watch<T>> {
  Widget? child;
  EffectCleanup? fn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  @override
  void reassemble() {
    super.reassemble();
    clearSubscribers();
    init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rebuild();
  }

  @override
  void dispose() {
    fn?.call();
    super.dispose();
  }

  void init() {
    fn?.call();
    fn = effect(rebuild);
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
    child ??= widget.builder(context);
    return child!;
  }
}
