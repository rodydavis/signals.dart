part of 'signals.dart';

/// {@template observer}
/// You can observe all signal values in the dart application by providing an implementation of `SignalsObserver`:
///
/// ```dart
/// abstract class SignalsObserver {
///   void onSignalCreated(Signal instance);
///   void onSignalUpdated(Signal instance, dynamic value);
///   void onComputedCreated(Computed instance);
///   void onComputedUpdated(Computed instance, dynamic value);
///   static SignalsObserver? instance;
/// }
/// ```
///
/// > There is a prebuilt `LoggingSignalsObserver` for printing updates to the console.
///
/// To add the observer override the instance at the start of the application:
///
/// ```dart
/// void main() {
///     SignalsObserver.instance = LoggingSignalsObserver(); // or custom observer
///     ...
/// }
/// ```
///
/// This will have a slight performance hit since every update will be tracked via the observer. It is recommended to only set the `SignalsObserver.instance` in debug or profile mode.
/// @link https://dartsignals.dev/utilities/observer
/// {@endtemplate}
abstract class SignalsObserver {
  /// Called when a signal is created.
  void onSignalCreated(Signal instance);

  /// Called when a signal is updated.
  void onSignalUpdated(Signal instance, dynamic value);

  /// Called when a computed is created.
  void onComputedCreated(Computed instance);

  /// Called when a computed is updated.
  void onComputedUpdated(Computed instance, dynamic value);

  // coverage:ignore-start
  void _onEffectCreated(_Effect instance) {}

  void _onEffectCalled(_Effect instance) {}

  void _onEffectRemoved(_Effect instance) {}
  // coverage:ignore-end

  /// The current observer instance.
  static SignalsObserver? instance = DevToolsSignalsObserver();
}

// coverage:ignore-start
/// Logs all signals and computed changes to the console.
class LoggingSignalsObserver extends SignalsObserver {
  @override
  void onComputedCreated(Computed instance) {
    log('computed created: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onComputedUpdated(Computed instance, value) {
    log('computed updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onSignalCreated(Signal instance) {
    log('signal created: [${instance.globalId}|${instance.debugLabel}] => ${instance.peek()}');
  }

  @override
  void onSignalUpdated(Signal instance, value) {
    log('signal updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  /// Logs a message to the console.
  void log(String message) => print(message);
}
// coverage:ignore-end
