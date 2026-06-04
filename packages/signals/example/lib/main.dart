import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

/// Global signal managing the current theme [Brightness] of the application.
///
/// Useful for displaying how global state propagates reactively down the tree.
final brightness = signal<Brightness>(
  Brightness.light,
  options: SignalOptions(name: 'brightness'),
);

/// Global computed signal checking whether dark mode is currently enabled.
///
/// Derived directly from the [brightness] signal. Updates automatically whenever
/// [brightness] changes.
final isDarkMode = computed<bool>(
  () => brightness.value == Brightness.dark,
  options: ComputedOptions(name: 'isDarkMode'),
);

void main() {
  // A global effect that responds to theme changes.
  // It automatically triggers whenever the [brightness] signal changes.
  effect(() {
    debugPrint('Global theme changed to: ${brightness.value}');
  }, options: EffectOptions(name: 'themeEffect'));

  runApp(const MyApp());
}

/// The main application widget.
///
/// Extends [SignalWidget] to automatically watch signal values referenced in its [build]
/// method and trigger rebuilds seamlessly when those signals update.
class MyApp extends SignalWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: brightness.value,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: brightness.value,
        ),
      ),
      home: const Counter(),
    );
  }
}

/// A reactive Counter page demonstrating local stateful signals.
///
/// Extends [SignalStatefulWidget] to enable seamless usage of signals
/// within a stateful widget lifetime.
class Counter extends SignalStatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

/// State for the [Counter] widget.
class _CounterState extends State<Counter> {
  /// Local signal tracking the current counter value.
  final _counter = signal(
    0,
    options: SignalOptions(name: 'counter'),
  );

  /// Local computed signal derived from the [_counter] value.
  ///
  /// Automatically doubles the counter's current value without manual tracking.
  late final _doubleCounter = computed(
    () => _counter.value * 2,
    options: ComputedOptions(name: 'doubleCounter'),
  );

  /// The dispose function for the local counter effect.
  late final void Function() _disposeCounterEffect;

  @override
  void initState() {
    super.initState();

    // A local effect that prints updates to the console.
    // It automatically runs initially and re-runs whenever [_counter] changes.
    _disposeCounterEffect = effect(() {
      debugPrint(
          'Counter updated: ${_counter.value} (double: ${_doubleCounter.value})');
    }, options: EffectOptions(name: 'counterLogger'));
  }

  @override
  void dispose() {
    // Always dispose local effects to prevent memory leaks when the widget is unmounted.
    _disposeCounterEffect();
    super.dispose();
  }

  /// Increments the local counter.
  void _incrementCounter() => _counter.value++;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Counter'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: () {
              // Toggling this global signal will automatically rebuild
              // the MaterialApp and update the app's brightness theme.
              brightness.value =
                  isDarkMode.value ? Brightness.light : Brightness.dark;
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Double value: ${_doubleCounter.value}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
