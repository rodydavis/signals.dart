import 'signals.dart';

abstract class SignalsObserver {
  void onSignalCreated(Signal instance);

  void onSignalUpdated(Signal instance, dynamic value);

  void onComputedCreated(Computed instance);

  void onComputedUpdated(Computed instance, dynamic value);

  static SignalsObserver? instance;
}

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

  // ignore: avoid_print
  void log(String message) => print(message);
}
