import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;
import 'signal_widget.dart';

/// A reactive builder widget designed for performance optimizations using child caching.
/// 
/// `SignalAnimatedBuilder` is the modern, drop-in replacement for Flutter's native [AnimatedBuilder]
/// or the deprecated `WatchBuilder`.
/// 
/// When you have a complex or computationally heavy widget subtree that does *not* depend on
/// any signal values, you should pass it as the [child] parameter. This subtree is cached
/// and is *never* rebuilt when the signals mutate, delivering a massive rendering boost.
/// 
/// ### Performance Optimization Example
/// ```dart
/// final count = signal(0);
/// 
/// class OptimizedCounter extends StatelessWidget {
///   const OptimizedCounter({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: SignalAnimatedBuilder(
///         // 1. Define the heavy subtree once. It will be cached:
///         child: const HeavyComplexSubtreeWidget(),
///         
///         // 2. The builder receives the cached child:
///         builder: (context, cachedChild) {
///           return Column(
///             mainAxisAlignment: MainAxisAlignment.center,
///             children: [
///               Text('Dynamic Count: ${count.value}'),
///               const SizedBox(height: 20),
///               // 3. Render the cached child directly:
///               cachedChild!,
///             ],
///           );
///         },
///       ),
///       floatingActionButton: FloatingActionButton(
///         onPressed: () => count.value++,
///         child: const Icon(Icons.add),
///       ),
///     );
///   }
/// }
/// ```
/// 
/// > [!TIP]
/// > Always use `SignalAnimatedBuilder` when rendering dynamic signal values alongside static,
/// > heavy subtrees. This minimizes CPU cycles and avoids rebuilding static layouts on frame updates.
class SignalAnimatedBuilder extends SignalWidget {
  /// Creates a [SignalAnimatedBuilder] widget.
  /// 
  /// The [builder] constructs the widget tree around the cached [child].
  /// The [dependencies] is an optional list of signals to watch explicitly.
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
