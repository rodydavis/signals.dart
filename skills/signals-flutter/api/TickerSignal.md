# function `tickerSignal`

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

## Signature

```dart
TickerSignal tickerSignal({Duration? initialDuration, SignalOptions<Duration>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

