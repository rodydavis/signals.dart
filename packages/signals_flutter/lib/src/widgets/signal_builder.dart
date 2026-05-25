import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;
import 'signal_widget.dart';

/// Localized surgical builder for signal changes.
///
/// ```dart
/// final counter = signal(0);
/// ...
/// SignalBuilder(
///   builder: (context) => Text('${counter.value}'),
/// )
/// ```
class SignalBuilder extends SignalWidget {
  /// Constructor for [SignalBuilder].
  const SignalBuilder({
    super.key,
    required this.builder,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// The widget to rebuild when any signals change.
  final Widget Function(BuildContext context) builder;

  /// Optional debug label to use for devtools.
  final String? debugLabel;

  /// List of optional dependencies to watch.
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  Widget build(BuildContext context) {
    for (final dep in dependencies) {
      dep.value;
    }
    return builder(context);
  }
}
