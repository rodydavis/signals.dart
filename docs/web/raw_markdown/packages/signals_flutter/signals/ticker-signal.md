---
title: Ticker Signal
description: Ticker signal used to drive animations and can create animation controllers.
---

## tickerSignal

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


---

## TickerSignal

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="tickersignal"></a><a name="tickersignal"></a>`TickerSignal({Duration? initialDuration, super.options, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel})`

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

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createticker"></a>`Ticker createTicker(TickerCallback onTick)`

##### <a name="dispose"></a>`void dispose()`

##### <a name="toanimationcontroller"></a>`AnimationController toAnimationController({double? value, Duration? duration, Duration? reverseDuration, String? debugLabel, double lowerBound = 0.0, double upperBound = 1.0, AnimationBehavior animationBehavior = AnimationBehavior.normal})`

Create a new **AnimationController**

</details>
