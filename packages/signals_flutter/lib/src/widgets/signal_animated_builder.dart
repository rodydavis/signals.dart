import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;
import 'signal_widget.dart';

/// A reactive widget that builds itself when signals change, with support
/// for an optional pre-built [child] to optimize rendering performance.
///
/// `SignalAnimatedBuilder` is a drop-in replacement for Flutter's native [AnimatedBuilder].
///
/// ```dart
/// final counter = signal(0);
/// ...
/// SignalAnimatedBuilder(
///   child: const HeavyWidget(),
///   builder: (context, child) {
///     return Column(
///       children: [
///         Text('${counter.value}'),
///         child!, // HeavyWidget is not rebuilt when counter updates!
///       ],
///     );
///   },
/// )
/// ```
class SignalAnimatedBuilder extends SignalWidget {
  /// Constructor for [SignalAnimatedBuilder].
  const SignalAnimatedBuilder({
    super.key,
    required this.builder,
    this.child,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// The widget to rebuild when any signals change.
  final Widget Function(BuildContext context, Widget? child) builder;

  /// Optional pre-built child subtree that does not rebuild.
  final Widget? child;

  /// Optional debug label to use for devtools.
  final String? debugLabel;

  /// List of optional dependencies to watch.
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  Widget build(BuildContext context) {
    for (final dep in dependencies) {
      dep.value;
    }
    return builder(context, child);
  }
}
