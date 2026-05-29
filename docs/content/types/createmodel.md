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

### 1. Type-Safe Models using Dart 3+ Records (Recommended)
The simplest and most built-in way to define a compile-safe model is to return a Dart **record** from your factory.
Records provide immediate type safety, autocomplete, and compile-time verification without any wrapper boilerplates.

```dart
import 'package:signals/signals.dart';

// Define the reactive model constructor returning a Record
final counterModel = createModel(() {
  final count = signal(0);

  // Captured nested side-effect (e.g. logging or syncing to local storage)
  effect(() {
    print('Nested logger: count is ${count.value}');
  });

  return (
    count: count,
    increment: () => count.value++,
  );
});

void main() {
  // Instantiate the model
  final model = counterModel();

  // Access properties type-safely via .value
  print(model.value.count.value); // Prints: 0 (and registers effect print: Nested logger: count is 0)
  model.value.increment();        // Prints: Nested logger: count is 1

  // Dispose when done to clean up all captured nested effects
  model.dispose();
}
```

### 2. Object-Oriented Style: Type-Safe Wrappers using Dart 3+ Extension Types
While records are great for lightweight structures, you can wrap the returned Map-based <code>SignalModel</code> in a standard Dart 3 **extension type** when you prefer a class-like API (e.g. implementing getters/setters or hiding subscript lookups).

```dart
import 'package:signals/signals.dart';

// 1. Define the reactive model constructor returning a Map
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
  Favor using Dart 3 records or extension types when defining models. They cost zero runtime overhead
  while granting complete compile-safe parameters and autocomplete functionality.
</Info>

## References

The **createModel** type is referenced and used in the following pages:

* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

