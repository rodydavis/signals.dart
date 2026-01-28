/// Signals integration for Nocterm - reactive state management for terminal UIs.
///
/// This library provides seamless integration between the signals reactive
/// programming library and Nocterm's terminal UI framework.
///
/// ## Getting Started
///
/// Add signals_nocterm to your pubspec.yaml:
///
/// ```yaml
/// dependencies:
///   signals_nocterm: ^0.1.0
/// ```
///
/// ## Usage with SignalsMixin
///
/// Use [SignalsMixin] with your [State] class to automatically manage signals:
///
/// ```dart
/// class Counter extends StatefulComponent {
///   const Counter({super.key});
///
///   @override
///   State<Counter> createState() => _CounterState();
/// }
///
/// class _CounterState extends State<Counter> with SignalsMixin {
///   late final _count = createSignal(0);
///   late final _doubled = createComputed(() => _count() * 2);
///
///   @override
///   void initState() {
///     super.initState();
///     createEffect(() {
///       print('Count: ${_count()}, Doubled: ${_doubled()}');
///     });
///   }
///
///   @override
///   Component build(BuildContext context) {
///     return Center(
///       child: Text('Count: ${_count()}, Doubled: ${_doubled()}'),
///     );
///   }
/// }
/// ```
///
/// ## Usage with Watch
///
/// Use [Watch] component or [watchSignal] function for fine-grained rebuilds:
///
/// ```dart
/// class MyComponent extends StatelessComponent {
///   MyComponent({super.key});
///
///   final count = signal(0);
///
///   @override
///   Component build(BuildContext context) {
///     return Watch((context) => Text('Count: ${count()}'));
///   }
/// }
/// ```
///
/// Or use [watchSignal] in your build method:
///
/// ```dart
/// @override
/// Component build(BuildContext context) {
///   final value = watchSignal(context, mySignal);
///   return Text('Value: $value');
/// }
/// ```
library;

export 'signals_core.dart';
export 'src/mixins/signals.dart';
export 'src/watch/watch.dart';
