import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';
// coverage:ignore-start
/// [WidgetsBinding] signal that tracks the current [AppLifecycleState]
///
/// [initWidgetsBindingSignals] is required to be called in the main method
final appLifecycleSignal = signal<AppLifecycleState>(AppLifecycleState.resumed);

bool _setup = false;

/// Call this method in main to setup the signals to
/// react to the WidgetsBinding instance
///
/// ```dart
/// void main() {
///   ...
///   initWidgetsBindingSignals();
///   runApp(...);
/// }
/// ```
///
/// Then in your application you can react to the app lifecycle
/// and accessibility focus signal.
///
/// ```dart
/// effect(() {
///   print('current lifecycle: $appLifecycleSignal');
/// });
///
/// effect(() {
///   print("current accessibility focus: $accessibilityFocusSignal");
/// });
/// ```
void initWidgetsBindingSignals([WidgetsBinding? binding]) {
  if (_setup) return;
  _setup = true;

  final widgetsBinding = binding ?? WidgetsBinding.instance;
  final observer = AppLifecycleListener(onStateChange: appLifecycleSignal.set);
  widgetsBinding.addObserver(observer);
}
// coverage:ignore-end