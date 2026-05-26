---
title: Model
description: Creates a new model constructor with an instanced factory.
---

## createModel

Creates a new model constructor with an instanced factory.

A [SignalModel](/packages/preact_signals/utilities/model) is an elegant wrapper around complex models (such as Maps or classes)
that tracks and automatically disposes of any [Effect](/packages/signals/core/effect)s created during the model's
instantiation.

When the returned [SignalModelConstructor](/packages/preact_signals/utilities/model) is invoked, it starts capturing nested effects.
If the factory returns a standard Dart **Map**, and `wrapInAction` is enabled (default), all nested
functions within that Map are automatically wrapped in batched [action](/packages/preact_signals/core/action)s.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

// Define a reactive counter model constructor
final counterModel = createModel(() {
  final count = signal(0);

  // Captured nested effect - will be disposed automatically!
  effect(() {
    print('Nested logger: count is ${count.value}');
  });

  return {
    'count': count,
    'increment': () => count.value++,
  };
});

void main() {
  // Instantiate the model
  final model = counterModel();

  final increment = model['increment'] as Function;
  increment(); // Prints: Nested logger: count is 1

  // Clean up all captured effects
  model.dispose();
}
```


---

## SignalModel

A wrapper for models constructed with [createModel](/packages/preact_signals/utilities/model).

It holds the instanced model **value** and all the [Effect](/packages/signals/core/effect)s that were captured
during its construction. Disposing the [SignalModel](/packages/preact_signals/utilities/model) automatically disposes of all
nested/captured effects, avoiding memory leaks.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final counterModel = createModel(() {
    final count = signal(0);
    effect(() => print('Count is: ${count.value}'));
    return {
      'count': count,
      'increment': () => count.value++,
    };
  });

  final model = counterModel();
  final increment = model['increment'] as Function;
  increment(); // Triggers print: Count is: 1

  // Disposes of captured effects
  model.dispose();
}
```


### Constructors

##### <a name="signalmodel"></a><a name="signalmodel"></a>`SignalModel(this.value, this._effects, {this.options = const SignalModelOptions()})`

Creates a new model instance.


### Properties

##### <a name="value"></a>`T value`

The instanced model value.

##### <a name="options"></a>`SignalModelOptions options`

Options used to configure this model.


### Methods

##### <a name="[]"></a>`dynamic [](Object? key)`

Access properties dynamically if the underlying **value** is a **Map**.

##### <a name="[]="></a>`void []=(dynamic key, dynamic val)`

Set properties dynamically if the underlying **value** is a **Map**.

##### <a name="dispose"></a>`void dispose()`

Disposes of all captured effects.



---

## SignalModelOptions

Options for configuring a [SignalModel](/packages/preact_signals/utilities/model).

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

##### <a name="signalmodeloptions"></a><a name="signalmodeloptions"></a>`SignalModelOptions({this.name, this.wrapInAction = true})`

Creates a new instance of [SignalModelOptions](/packages/preact_signals/utilities/model).


### Properties

##### <a name="name"></a>`String? name`

The name or debug label of the model.

##### <a name="wrapinaction"></a>`bool wrapInAction`

Whether to automatically wrap returned Map functions in actions.
Defaults to true.


### Methods

##### <a name="copywith"></a>`SignalModelOptions copyWith({String? name, bool? wrapInAction})`

Copy options with new values.

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`



---

## SignalModelConstructor

A constructor for models that manages nested effects.

The model constructor starts capturing effects when called, storing them inside the returned [SignalModel](/packages/preact_signals/utilities/model).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final myModel = SignalModelConstructor(() => 'data');
final model = myModel();
print(model.value); // Prints: data
```


### Constructors

##### <a name="signalmodelconstructor"></a><a name="signalmodelconstructor"></a>`SignalModelConstructor(this._factory, {this.options = const SignalModelOptions()})`

Creates a new instance of [SignalModelConstructor](/packages/preact_signals/utilities/model).


### Properties

##### <a name="options"></a>`SignalModelOptions options`

Options used to configure this constructor.


### Methods

##### <a name="call"></a>`SignalModel<T> call()`

Instantiates a new [SignalModel](/packages/preact_signals/utilities/model) instance.
