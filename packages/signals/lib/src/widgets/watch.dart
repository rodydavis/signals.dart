import 'package:flutter/material.dart';

import '../signals.dart';

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
  late Widget child;
  EffectCleanup? fn;
  bool _initialized = false;

  void init() {
    fn?.call();
    fn = effect(() {
      child = widget.builder(context);
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
      _initialized = true;
    });
  }

  @override
  void dispose() {
    fn?.call();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    child = widget.builder(context);
    if (mounted) {
      (context as Element).markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return widget.builder(context);
    } else {
      return child;
    }
  }
}
