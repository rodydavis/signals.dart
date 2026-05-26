import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;
import 'signal_builder.dart';

/// A deprecated widget for watching signal changes in the widget tree.
/// 
/// :::caution
/// **DEPRECATED**: Use [SignalBuilder] instead for superior, self-contained reactivity
/// and consistent API design.
/// :::
/// 
/// ### Migration to [SignalBuilder]
/// ```dart
/// // Deprecated legacy pattern:
/// Watch((context) => Text('$counter'))
/// 
/// // Modern, streamlined pattern:
/// SignalBuilder(builder: (context) => Text('${counter.value}'))
/// ```
@Deprecated(
  'Use SignalBuilder instead for superior reactivity and consistent naming.',
)
class Watch<T extends Widget> extends StatelessWidget {
  /// Minimal builder for signal changes that rerender a widget tree.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// Watch((context) => Text('$counter'))
  /// ```
  const Watch(
    this.builder, {
    super.key,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// Drop in replacement for the Flutter builder widget.
  ///
  /// ```diff
  /// final counter = signal(0);
  /// ...
  /// - Builder(
  /// + Watch.builder(
  ///   builder: (context) {
  ///     return Text('$counter');
  ///   }
  /// )
  /// ```
  const Watch.builder({
    super.key,
    required this.builder,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// The widget to rebuild when any signals change
  final T Function(BuildContext context) builder;

  /// Optional debug label to use for devtools
  final String? debugLabel;

  /// List of optional dependencies to watch
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      dependencies: dependencies,
      builder: builder,
    );
  }
}
