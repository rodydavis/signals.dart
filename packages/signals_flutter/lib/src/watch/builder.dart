part of 'watch.dart';

/// ## Watch
///
/// To watch a signal for changes in Flutter, use the `Watch` widget. This will only rebuild this widget method and not the entire widget tree.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Watch((context, _) => Text('$signal'));
/// }
/// ```
///
/// This will also automatically unsubscribe when the widget is disposed.
///
/// Any inherited widgets referenced to inside the Watch scope will be subscribed to for updates ([MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html), [Theme](https://api.flutter.dev/flutter/material/Theme-class.html), etc.) and retrigger the builder method.
///
/// There is also a drop in replacement for builder:
///
/// ```diff
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
/// -  return Builder(
/// +  return Watch.builder(
///     builder: (context, _) => Text('$signal'),
///   );
/// }
/// ```
class WatchBuilder<T extends Widget> extends StatefulWidget {
  /// Minimal builder for signal changes that rerender a widget tree.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// Watch((context) => Text('$counter'))
  /// ```
  const WatchBuilder({
    super.key,
    required this.builder,
    this.debugLabel,
    this.dependencies = const [],
    this.child,
  });

  /// The widget to rebuild when any signals change
  final T Function(BuildContext context, Widget? child) builder;

  /// Optional debug label to use for devtools
  final String? debugLabel;

  /// Cached widget to pass in
  final Widget? child;

  /// List of optional dependencies to watch
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  State<WatchBuilder<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<WatchBuilder<T>>
    with SignalsMixin {
  late final result = createComputed(
    () {
      return widget.builder(context, widget.child);
    },
    debugLabel: widget.debugLabel,
  );
  bool _init = true;

  @override
  void initState() {
    super.initState();
    for (final dep in widget.dependencies) {
      bindSignal(dep);
    }
  }

  // coverage:ignore-start
  @override
  void reassemble() {
    super.reassemble();
    final target = core.SignalsObserver.instance;
    if (target is core.DevToolsSignalsObserver) {
      target.reassemble();
    }
  }
  // coverage:ignore-end

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // Called on first build (we do not need to rebuild yet)
      _init = false;
      return;
    }
    result.recompute();
  }

  @override
  void didUpdateWidget(covariant WatchBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dependencies != widget.dependencies) {
      for (final dep in oldWidget.dependencies) {
        final idx = widget.dependencies.indexOf(dep);
        if (idx == -1) unbindSignal(dep);
      }
      for (final dep in widget.dependencies) {
        bindSignal(dep);
      }
    }

    if (oldWidget.builder != widget.builder) {
      result.recompute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return result.value;
  }
}
