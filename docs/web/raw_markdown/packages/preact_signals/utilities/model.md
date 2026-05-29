---
title: Model
description: Creates a new model constructor with an instanced factory.
---

## createModel

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


---

## SignalModel

A premium wrapper for cohesive state packages constructed with [createModel](/types/createmodel).

It holds the instanced model **value** and all the [Effect](/types/effect)s that were captured
during its construction. Disposing the [SignalModel](/types/signalmodel) automatically disposes of all
nested/captured effects, completely avoiding memory leaks.

### Premium Pattern: Dart 3+ Extension Type Wrappers
To avoid unchecked subscript access like <code>model['count'].value</code>, wrap your model in an extension type:

```dart
extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
  int get count => (_model['count'] as Signal<int>).value;
  set count(int val) => (_model['count'] as Signal<int>).value = val;
  void increment() => (_model['increment'] as Function)();
  void dispose() => _model.dispose();
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalmodel"></a><a name="signalmodel"></a>`SignalModel(this.value, this._effects, {this.options = const SignalModelOptions()})`

Creates a new model instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="value"></a>`T value`

The instanced model value.

##### <a name="options"></a>`SignalModelOptions options`

Options used to configure this model.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="[]"></a>`dynamic [](Object? key)`

Access properties dynamically if the underlying **value** is a **Map**.

##### <a name="[]="></a>`void []=(dynamic key, dynamic val)`

Set properties dynamically if the underlying **value** is a **Map**.

##### <a name="call"></a>`T call()`

Returns the **value** of this model. Alias for [.value]

##### <a name="dispose"></a>`void dispose()`

Disposes of all captured effects.

</details>



---

## SignalModelOptions

Options for configuring a [SignalModel](/types/signalmodel).

Provides configuration for debug labeling (**name**) and whether to automatically wrap Map functions
in transaction-safe, batched actions (**wrapInAction**).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final options = const SignalModelOptions(
  name: 'user-profile-model',
  wrapInAction: true,
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalmodeloptions"></a><a name="signalmodeloptions"></a>`SignalModelOptions({this.name, this.wrapInAction = true})`

Creates a new instance of [SignalModelOptions](/types/signalmodeloptions).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="name"></a>`String? name`

The name or debug label of the model.

##### <a name="wrapinaction"></a>`bool wrapInAction`

Whether to automatically wrap returned Map functions in actions.
Defaults to true.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a>`SignalModelOptions copyWith({String? name, bool? wrapInAction})`

Copy options with new values.

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## SignalModelConstructor

A constructor for models that manages nested effects.

The model constructor starts capturing effects when called, storing them inside the returned [SignalModel](/types/signalmodel).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final myModel = SignalModelConstructor(() => 'data');
final model = myModel();
print(model.value); // Prints: data
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalmodelconstructor"></a><a name="signalmodelconstructor"></a>`SignalModelConstructor(this._factory, {this.options = const SignalModelOptions()})`

Creates a new instance of [SignalModelConstructor](/types/signalmodelconstructor).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="options"></a>`SignalModelOptions options`

Options used to configure this constructor.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="call"></a>`SignalModel<T> call()`

Instantiates a new [SignalModel](/types/signalmodel) instance.

</details>
