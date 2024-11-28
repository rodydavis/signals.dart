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
  void onSignalCreated<T>(Signal<T> instance, T value);

  /// Called when a signal is updated.
  void onSignalUpdated<T>(Signal<T> instance, T value);

  /// Called when a computed is created.
  void onComputedCreated<T>(Computed<T> instance);

  /// Called when a computed is updated.
  void onComputedUpdated<T>(Computed<T> instance, T value);

  /// Called when a effect is created.
  void onEffectCreated(Effect instance) {}

  /// Called when a effect is called.
  void onEffectCalled(Effect instance) {}

  /// Called when a effect is disposed.
  void onEffectRemoved(Effect instance) {}

  /// The current observer instance.
  static SignalsObserver? instance =
      kDebugMode ? DevToolsSignalsObserver() : null;
}

// coverage:ignore-start
/// Logs all signals and computed changes to the console.
class LoggingSignalsObserver extends SignalsObserver {
  @override
  void onComputedCreated<T>(Computed<T> instance) {
    log('computed created: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onComputedUpdated<T>(Computed<T> instance, T value) {
    log('computed updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onSignalCreated<T>(Signal<T> instance, T value) {
    log('signal created: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onSignalUpdated<T>(Signal<T> instance, T value) {
    log('signal updated: [${instance.globalId}|${instance.debugLabel}] => $value');
  }

  @override
  void onEffectCreated(Effect instance) {
    log('effect created: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onEffectCalled(Effect instance) {
    log('effect called: [${instance.globalId}|${instance.debugLabel}]');
  }

  @override
  void onEffectRemoved(Effect instance) {
    log('effect removed: [${instance.globalId}|${instance.debugLabel}]');
  }

  /// Logs a message to the console.
  void log(String message) => developer.log(message);
}
// coverage:ignore-end
