import 'listenable.dart';

typedef EffectCallback = dynamic Function();
typedef EffectCleanup = void Function();

abstract class Effect implements Listenable {
  @override
  EffectOptions get options;

  EffectCallback get callback;

  Function? cleanup;

  /// Activate the effect starting with the callback
  EffectCleanup call() {
    try {
      callback();
    } catch (e) {
      dispose();
      rethrow;
    }
    // Return a bound function instead of a wrapper like `() => effect._dispose()`,
    // because bound functions seem to be just as fast and take up a lot less memory.
    return dispose;
  }

  void dispose() {
    cleanup?.call();
  }
}

class EffectOptions extends ListenableOptions {
  final EffectCleanup? onDispose;

  const EffectOptions({
    super.debugLabel,
    this.onDispose,
  });
}
