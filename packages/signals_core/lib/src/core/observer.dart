import 'signals.dart';

/// A class that listens to signals and computed changes.
abstract class SignalsObserver {
  /// Called when a signal is created.
  void onSignalCreated(Signal instance);

  /// Called when a signal is updated.
  void onSignalUpdated(Signal instance, dynamic value);

  /// Called when a computed is created.
  void onComputedCreated(Computed instance);

  /// Called when a computed is updated.
  void onComputedUpdated(Computed instance, dynamic value);

  /// The current observer instance.
  static SignalsObserver? instance;
}

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
