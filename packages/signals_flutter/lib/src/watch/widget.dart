import 'package:flutter/material.dart';
import 'package:signals_core/signals_core.dart';

/// [Watch] is a drop-in replacement for [Builder] that will rebuild
/// when any signals inside the builder change
class Watch<T extends Widget> extends StatefulWidget {
  const Watch(this.builder, {super.key, this.debugLabel});

  const Watch.builder({super.key, required this.builder, this.debugLabel});

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
  void didUpdateWidget(covariant Watch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) rebuild();
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
