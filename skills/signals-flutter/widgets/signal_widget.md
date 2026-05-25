# `SignalWidget` (Reactive Stateless / Stateful Widgets)

`SignalWidget` and `SignalStatefulWidget` are base subclasses providing reactive lifecycle tracking directly on full component levels, serving as high-performance, lightweight replacements for old mixins.

---

## 1. Creation

```dart
class MyComponent extends SignalWidget {
  const MyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // Reading any signal here dynamically subscribes the widget to updates
    return Text('Count: ${counter.value}');
  }
}
```

---

## 2. Transitioning from Mixins
Instead of using `State with SignalsMixin` which can incur significant overhead, subclass `SignalWidget` (for stateless components) or `SignalStatefulWidget` (for stateful ones) to enjoy automatic reactivity.
