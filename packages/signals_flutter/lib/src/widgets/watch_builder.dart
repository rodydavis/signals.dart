import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;
import 'signal_animated_builder.dart';

/// ## WatchBuilder
///
/// To watch a signal for changes in Flutter, use the `WatchBuilder` widget. This will only rebuild this widget method and not the entire widget tree.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return WatchBuilder(
///     child: const Icon(Icons.add),
///     builder: (context, child) => Row(children: [Text('$signal'), child!]),
///   );
/// }
/// ```
@Deprecated(
  'Use SignalAnimatedBuilder instead for superior reactivity and consistent naming.',
)
class WatchBuilder<T extends Widget> extends StatelessWidget {
  /// Minimal builder for signal changes that rerender a widget tree.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// WatchBuilder(
  ///   builder: (context, child) => Text('$counter')
  /// )
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
  Widget build(BuildContext context) {
    return SignalAnimatedBuilder(
      dependencies: dependencies,
      debugLabel: debugLabel,
      builder: builder,
      child: child,
    );
  }
}
