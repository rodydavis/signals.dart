---
title: "Type: TickerSignal"
description: "API reference and details for TickerSignal from signals.dart."
---

# TickerSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: TickerSignal

Ticker signal used to drive animations and can create animation controllers

```dart
void main() {
  final ticker = TickerSignal(); // could be a global
  final controller = ticker.toAnimationController(); // can be local or global
  final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
  final alpha = IntTween(begin: 0, end: 255).animate(curve);
  ...
  final alphaSignal = alpha.toSignal(); // can be converted to a signal
}
```

### Members of TickerSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **TickerSignal** | <code>constructor</code> | <code>dart TickerSignal({Duration? initialDuration, super.options, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel})</code> | Ticker signal used to drive animations and can create animation controllers |
| **createTicker** | <code>method</code> | <code>dart Ticker createTicker(TickerCallback onTick)</code> |  |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |
| **toAnimationController** | <code>method</code> | <code>dart AnimationController toAnimationController({double? value, Duration? duration, Duration? reverseDuration, String? debugLabel, double lowerBound = 0.0, double upperBound = 1.0, AnimationBehavior animationBehavior = AnimationBehavior.normal})</code> | Create a new **AnimationController** |

## Function: tickerSignal

```dart
TickerSignal tickerSignal({Duration? initialDuration, SignalOptions<Duration>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

Ticker signal used to drive animations and can create animation controllers

```dart
void main() {
  final ticker = tickerSignal(); // could be a global
  final controller = ticker.toAnimationController(); // can be local or global
  final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
  final alpha = IntTween(begin: 0, end: 255).animate(curve);
  ...
  final alphaSignal = alpha.toSignal(); // can be converted to a signal
}
```

## References

The **TickerSignal** type is referenced and used in the following pages:

* [Ticker Signal](/packages/signals_flutter/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [Ticker Signal](/packages/signals/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>

