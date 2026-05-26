import 'package:flutter/widgets.dart';

import '../core/readonly.dart';
import '../core/signal.dart';

/// A premium dependency-injection / state propagation widget that allows passing
/// reactive signals down the Flutter widget tree using [InheritedNotifier].
/// 
/// `SignalProvider` makes a signal accessible to all child widgets in the subtree.
/// Any child widget that reads the signal using `SignalProvider.of<T>(context)` will
/// automatically rebuild when the signal's value changes, while parent widgets remain unaffected.
/// 
/// ### Example Usage
/// 
/// First, define a custom signal or class that extends [FlutterSignal]:
/// ```dart
/// class CounterSignal extends FlutterSignal<int> {
///   CounterSignal([super.value = 0]);
/// 
///   void increment() => value++;
/// }
/// ```
/// 
/// Next, wrap your widget subtree with `SignalProvider`:
/// ```dart
/// SignalProvider<CounterSignal>(
///   create: () => CounterSignal(0),
///   child: const CounterDisplay(),
/// )
/// ```
/// 
/// Inside a child widget, access the signal using `SignalProvider.of`:
/// ```dart
/// class CounterDisplay extends StatelessWidget {
///   const CounterDisplay({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     // Obtain the counter signal and automatically subscribe this widget to rebuilds:
///     final counter = SignalProvider.of<CounterSignal>(context)!;
/// 
///     return Scaffold(
///       body: Center(
///         child: Text(
///           'Count: ${counter.value}',
///           style: Theme.of(context).textTheme.headlineMedium,
///         ),
///       ),
///       floatingActionButton: FloatingActionButton(
///         // Use listen: false to obtain the reference without subscribing to rebuilds:
///         onPressed: () => SignalProvider.of<CounterSignal>(context, listen: false)!.increment(),
///         child: const Icon(Icons.add),
///       ),
///     );
///   }
/// }
/// ```
/// 
/// > [!TIP]
/// > When retrieving the signal in callbacks (like `onPressed`), always pass `listen: false` to avoid
/// > subscribing the callback's enclosing widget to unnecessary rebuilds.
class SignalProvider<T extends FlutterReadonlySignal>
    extends InheritedNotifier<T> {
  /// Creates a [SignalProvider] that exposes a [FlutterReadonlySignal] to its descendents.
  /// 
  /// The [create] callback is invoked once to instantiate the signal.
  /// The [child] is the widget subtree that will have access to the signal.
  SignalProvider({
    super.key,
    required T Function() create,
    required super.child,
  }) : _setup = create;

  final T Function() _setup;

  @override
  // ignore: overridden_fields
  late final T notifier = _setup();

  /// Retrieves the [SignalProvider] instance of the specified type [T] from the [BuildContext].
  /// 
  /// - If [listen] is true (default), the calling widget is registered as a dependent
  ///   on the provider, causing the widget to rebuild whenever the signal changes.
  /// - If [listen] is false, the provider is located without subscribing the widget
  ///   to rebuilds. This is ideal for obtaining callbacks or methods from the signal
  ///   without introducing rebuild overhead.
  static SignalProvider<T>? providerOf<T extends FlutterSignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<SignalProvider<T>>();
    } else {
      return context.findAncestorWidgetOfExactType<SignalProvider<T>>();
    }
  }

  /// Retrieves the reactive signal instance of type [T] directly from the nearest [SignalProvider].
  /// 
  /// - If [listen] is true (default), the calling widget will automatically subscribe
  ///   to the signal and rebuild whenever the signal's value changes.
  /// - If [listen] is false, the signal is returned without establishing a subscription.
  ///   Use `listen: false` when mutating the signal inside action callbacks.
  static T? of<T extends FlutterSignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance = SignalProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
