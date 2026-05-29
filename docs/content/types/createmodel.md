---
title: "Type: createModel"
description: "API reference and details for createModel from signals.dart."
---

# createModel

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: createModel

```dart
SignalModelConstructor<T> createModel(T Function() factory, {SignalModelOptions options = const SignalModelOptions()})
```

Creates a new model constructor with an instanced factory.

A [SignalModel](/types/signalmodel) is a highly powerful architectural primitive designed to manage cohesive packages
of related state, business logic, actions, and side effects.

Under the hood, [SignalModel](/types/signalmodel) automatically tracks, scopes, and manages the lifecycle of any [Effect](/types/effect)s
instantiated during its factory execution. When the model is disposed (by calling <code>model.dispose()</code>),
all nested/captured effects are clean up automatically, ensuring complete prevention of memory leaks.

Furthermore, if the factory returns a standard Dart **Map**, and <code>wrapInAction</code> is enabled (default),
all nested function properties are automatically wrapped in batched [action](/types/action) transactions to optimize updates.

### 1. Advanced Architecture: Type-Safe Wrappers using Dart 3+ Extension Types
While dynamic subscript access <code>model['increment']()</code> is fast and flexible, it lacks static analysis safety.
To achieve compile-time type-safety, you can wrap the returned <code>SignalModel</code> in a standard Dart 3 **extension type**:

```dart
import 'package:signals/signals.dart';

// 1. Define the reactive model constructor
final counterModel = createModel(() {
  final count = signal(0);

  // Captured nested side-effect (e.g. logging or syncing to local storage)
  effect(() {
    print('Nested logger: count is ${count.value}');
  });

  return <String, dynamic>{
    'count': count,
    'increment': () => count.value++,
  };
});

// 2. Create a premium, compile-safe extension type wrapper
extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
  int get count => (_model['count'] as Signal<int>).value;
  set count(int val) => (_model['count'] as Signal<int>).value = val;

  void increment() => (_model['increment'] as Function)();
  void dispose() => _model.dispose();
}

void main() {
  // 3. Instantiate and wrap the model
  final counter = TypeSafeCounter(counterModel());

  // Now you have a beautifully autocomplete-friendly, compile-safe API!
  print(counter.count); // Prints: 0 (and registers effect print: Nested logger: count is 0)
  counter.increment();  // Prints: Nested logger: count is 1

  // Dispose when done to clean up all captured nested effects
  counter.dispose();
}
```

<Info>
  Favor using Dart 3 extension types whenever you define models. They cost zero runtime overhead
  (compiling down to the raw model) while granting complete compile-safe parameters and autocomplete functionality.
</Info>

## References

The **createModel** type is referenced and used in the following pages:

* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>

