import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../../signals_flutter.dart';
import 'scheduler_binding.dart';

/// Ticker signal used to drive animations and can create animation controllers
///
/// ```dart
/// void main() {
///   final ticker = TickerSignal(); // could be a global
///   final controller = ticker.toAnimationController(); // can be local or global
///   final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
///   final alpha = IntTween(begin: 0, end: 255).animate(curve);
///   ...
///   final alphaSignal = alpha.toSignal(); // can be converted to a signal
/// }
/// ```
class TickerSignal extends ValueSignal<Duration> implements TickerProvider {
  TickerSignal({
    Duration? initialDuration,
    super.debugLabel,
  }) : super(initialDuration ?? Duration.zero) {
    initSchedulerBindingSignals(); // no-op if already called
    _cleanup = effect(() {
      super.value = onPersistentFrameSignal();
    });
  }

  Ticker? _ticker;
  EffectCleanup? _cleanup;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _ticker = Ticker(
      onTick,
      debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null,
    );
    return _ticker!;
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _cleanup?.call();
    super.dispose();
  }

  AnimationController toAnimationController({
    double? value,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    AnimationBehavior animationBehavior = AnimationBehavior.normal,
  }) {
    return AnimationController(
      vsync: this,
      value: value,
      duration: duration,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      lowerBound: lowerBound,
      upperBound: upperBound,
      animationBehavior: animationBehavior,
    );
  }
}

/// Ticker signal used to drive animations and can create animation controllers
///
/// ```dart
/// void main() {
///   final ticker = tickerSignal(); // could be a global
///   final controller = ticker.toAnimationController(); // can be local or global
///   final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
///   final alpha = IntTween(begin: 0, end: 255).animate(curve);
///   ...
///   final alphaSignal = alpha.toSignal(); // can be converted to a signal
/// }
/// ```
TickerSignal tickerSignal({
  Duration? initialDuration,
  String? debugLabel,
}) {
  return TickerSignal(
    initialDuration: initialDuration,
    debugLabel: debugLabel,
  );
}
