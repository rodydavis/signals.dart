---
title: signals-dart AI Skill
description: Advanced reactive state primitives, collections, mixins, and utilities of signals_core. (v7.0.0)
---

# signals-dart AI Developer Skill

> Advanced reactive state primitives, collections, mixins, and utilities of signals_core. (v7.0.0)

---

### 📥 Installation

To instantly install this AI developer skill into your local workspace under `.agents/skills/`, run:

```bash
npx skills add rodydavis/signals.dart/tree/main/skills/signals-dart
```

---

## 📄 SKILL.md Preview

# signals-dart API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-dart` (version `7.0.0`).

---

## 🚀 Reactive Primitives Cheat-Sheet

Here is a curated reference of all reactivity constructs available in this package:

### signal (prefix: `sig`)
- **Category**: Primitive
- **Description**: An observable box containing a mutable value. Reading its value registers a dependency implicitly.

**Standard Usage Example**:
```dart
final counter = signal(0, 
  options: SignalOptions(name: 'counter')
);

counter.value++; // triggers rebuilds

```

---
### Async Signal (prefix: `asig`)
- **Category**: Primitive
- **Description**: An async Signal Object mapping loading, data success, and error failure states cleanly.

**Standard Usage Example**:
```dart
final data = asyncSignal(AsyncState.loading(), 
  options: AsyncSignalOptions(name: 'fetchUser')
);

```

---
### Computed (prefix: `comp`)
- **Category**: Derived
- **Description**: Combine multiple signals into a derived, lazily-cached, read-only signal.

**Standard Usage Example**:
```dart
final isEven = computed(() => 
  counter.value % 2 == 0,
  options: ComputedOptions(name: 'isEven')
);

```

---
### AsyncComputed (prefix: `ascomp`)
- **Category**: Derived
- **Description**: Asynchronous Computed is syntax sugar around FutureSignal for async dependent tasks.

**Standard Usage Example**:
```dart
final apiResults = computedAsync(() => 
  fetchFromApi(searchQuery.value),
  options: AsyncSignalOptions(name: 'apiResults')
);

```

---
### linkedSignal (prefix: `linksig`)
- **Category**: Writable Derived
- **Description**: A writable derived signal that allows manual updates and resets to a source computation on mutation.

**Standard Usage Example**:
```dart
final email = signal('bob@email.com');
final display = linkedSignal(() => email.value);

display.value = 'custom@email.com'; // write
email.value = 'alice@email.com'; // resets display to alice

```

---
### ChangeStackSignal (prefix: `undosig`)
- **Category**: Utilities
- **Description**: Track signal values over time, exposing simple, robust undo/redo capabilities.

**Standard Usage Example**:
```dart
final history = changeStack(0);
history.value = 1;
history.undo(); // back to 0

```

---
### IterableSignal (prefix: `itrsig`)
- **Category**: Collections
- **Description**: Iterable signals wrap collection items lazy-traversals mapped to custom reactivity layer.

**Standard Usage Example**:
```dart
final elements = iterableSignal([1, 2, 3]);

```

---
### ListSignal (prefix: `lstsig`)
- **Category**: Collections
- **Description**: Optimized list wrapper proxying standard operations to support element-level reactivity.

**Standard Usage Example**:
```dart
final items = listSignal([1, 2]);
items.add(3); // Reacts automatically

```

---
### MapSignal (prefix: `mpsig`)
- **Category**: Collections
- **Description**: Granular map wrapper supporting isolated dictionary element lookup triggers.

**Standard Usage Example**:
```dart
final profile = mapSignal({'username': 'alice'});
profile['username'] = 'bob'; // Mutates and triggers reactives

```

---
### SetSignal (prefix: `stsig`)
- **Category**: Collections
- **Description**: Custom set wrapper ignoring duplicate entries and triggering mutations on unique inserts.

**Standard Usage Example**:
```dart
final tags = setSignal({'flutter'});
tags.add('dart');

```

---
### FutureSignal (prefix: `fusig`)
- **Category**: Primitive
- **Description**: Bypasses stream subscription overhead and resolves the future-evaluation loop elegantly.

**Standard Usage Example**:
```dart
final userProfile = futureSignal(() => fetchProfile(userId.value));

```

---
### StreamSignal (prefix: `strsig`)
- **Category**: Primitive
- **Description**: Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states.

**Standard Usage Example**:
```dart
final messages = streamSignal(() => chatSocket.messages);

```

---
### Signal Container (Read-only) (prefix: `rsigcon`)
- **Category**: Utilities
- **Description**: Returns a read-only parameterized caching Signal Container.

**Standard Usage Example**:
```dart
final userContainer = readonlySignalContainer<String, User>((userId) {
  return computed(() => users.value[userId]);
});

```

---
### Signal Container (prefix: `sigcon`)
- **Category**: Utilities
- **Description**: Returns a mutable parameterized caching Signal Container.

**Standard Usage Example**:
```dart
final activeCounters = signalContainer<String, int>((key) {
  return signal(0);
});

```

---
### Value Signal (prefix: `valsig`)
- **Category**: Utilities
- **Description**: Custom Value Signal class definition template.

**Standard Usage Example**:
```dart
class CounterSignal extends ValueSignal<int> {
  CounterSignal(super.value) : super(debugLabel: 'Counter');
}

```

---

## 📦 Parsed Library API & Signature Reference

The following APIs are exported and available inside this package. Use them according to these signature patterns:

### function `reloadSignalsDevTools`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Reload the devtools

**Signature**:
```dart
void reloadSignalsDevTools()
```


---
### function `disableSignalsDevTools`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Disable the devtools

**Signature**:
```dart
void disableSignalsDevTools()
```


---
### function `signalsDevToolsEnabled`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Check if the signals devtools are enabled

**Signature**:
```dart
bool signalsDevToolsEnabled
```


---
### function `signalsDevToolsEnabled`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Manually enable/disable signals devtools

**Signature**:
```dart
signalsDevToolsEnabled(bool value)
```


---
### class `DevToolsSignalsObserver`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Signals DevTools observer


#### Members of `DevToolsSignalsObserver`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **DevToolsSignalsObserver** | `constructor` | `DevToolsSignalsObserver()` | Create a DevToolsSignalsObserver and register the VM service extensions. |
| **enabled** | `method` | `bool enabled` | Check if devTools is enabled |
| **enabled** | `method` | `enabled(bool value)` | Enable/Disable devTools |
| **reassemble** | `method` | `void reassemble()` | Reload the signals devTools |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` |  |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` |  |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` |  |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` |  |
| **log** | `method` | `void log(String message)` | Logs a message to the console. |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` |  |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` |  |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` |  |
| **getNodes** | `method` | `Map<String, dynamic> getNodes()` | Returns a map representation of all active signals, computeds, and effects
in the reactive graph. |

---
### class `TimerSignal`

Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal)


#### Members of `TimerSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **every** | `field` | `Duration every` | Trigger an **TimerSignalEvent** every duration |
| **TimerSignal** | `constructor` | `TimerSignal({required this.every, super.cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})` | Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal) |

---
### extension `TimerSignalDurationUtils`

Expose Duration as a [TimerSignal](/types/timersignal)


#### Members of `TimerSignalDurationUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `TimerSignal toSignal({bool? cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})` | Expose Duration as a [TimerSignal](/types/timersignal) |

---
### function `timerSignal`

Create a [TimerSignal](/types/timersignal)

**Signature**:
```dart
TimerSignal timerSignal(Duration every, {bool? cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```


---
### class `ListSignal`

A reactive [Signal](/types/signal) that holds a **List** and implements the **List** interface.

[ListSignal](/types/listsignal) lets you listen to changes on a list reactively and mutate it directly using
standard list operations (like <code>add</code>, <code>addAll</code>, <code>remove</code>, operators <code>[]</code> and <code>[]=</code>, etc.).
Any mutations automatically trigger reactive updates to all active listeners (e.g., inside an
[effect](/types/effect) or [computed](/types/computed)).

Additionally, [ListSignal](/types/listsignal) defines convenient operators:
- <code><<</code> injects/adds all items from an iterable into the list.
- <code>&</code> forks/concatenates the list with an iterable into a new [ListSignal](/types/listsignal).
- <code>|</code> pipes/concatenates the list with another signal holding an iterable into a new [ListSignal](/types/listsignal).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final numbers = listSignal<int>([1, 2, 3]);

  effect(() {
    print('List content: $numbers, Length: ${numbers.length}');
  }); // Prints: "List content: [1, 2, 3], Length: 3"

  // Standard mutation (triggers updates)
  numbers.add(4); // Prints: "List content: [1, 2, 3, 4], Length: 4"

  // Update via index operator (triggers updates)
  numbers[0] = 10; // Prints: "List content: [10, 2, 3, 4], Length: 4"

  // Injection operator (triggers updates)
  numbers << [5, 6]; // Prints: "List content: [10, 2, 3, 4, 5, 6], Length: 6"
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign <code>numbers.value = ...</code> manually!
</Success>


#### Members of `ListSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ListSignal** | `constructor` | `ListSignal(super.value, {ListSignalOptions<E>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [ListSignal](/types/listsignal) with the given **value**. |
| **<<** | `method` | `ListSignal<E> <<(Iterable<E> other)` | Inject: Update current signal value with iterable |
| **&** | `method` | `ListSignal<E> &(Iterable<E> other)` | Fork: create a new signal which value is the concatenation of source signal and iterable parameter |
| **|** | `method` | `ListSignal<E> |(Signal<Iterable<E>> other)` | Pipe: create a new signal by sending value from source to other |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### function `listSignal`

Creates a [ListSignal](/types/listsignal) initialized with the provided **list**.

This is a convenience helper function for creating reactive list signals.

```dart
import 'package:signals/signals.dart';

final list = listSignal([1, 2, 3]);
```

**Signature**:
```dart
ListSignal<T> listSignal(List<T> list, {ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalListUtils`

Utility extension methods on **List** to convert them to [ListSignal](/types/listsignal)s.


#### Members of `SignalListUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `ListSignal<T> toSignal({ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **List** to a reactive [ListSignal](/types/listsignal).

```dart
import 'package:signals/signals.dart';

final myList = [1, 2, 3];
final signal = myList.toSignal();
``` |

---
### class `ListSignalOptions`

Configuration options for a [ListSignal](/types/listsignal).


#### Members of `ListSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ListSignalOptions** | `constructor` | `ListSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [ListSignalOptions](/types/listsignaloptions) instance. |
| **copyWith** | `method` | `ListSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<List<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `MapSignal`

A reactive [Signal](/types/signal) that holds a **Map** and implements the **Map** interface.

[MapSignal](/types/mapsignal) lets you listen to changes on a map reactively and mutate it directly using
standard map operations (like adding/modifying keys with <code>operator []=</code>, <code>addAll</code>, <code>remove</code>,
<code>clear</code>, etc.). Any mutations automatically trigger reactive updates to all active listeners
(e.g., inside an [effect](/types/effect) or [computed](/types/computed)).

Additionally, [MapSignal](/types/mapsignal) defines convenient operators:
- <code><<</code> injects/adds all entries from another map into the current map.
- <code>&</code> forks/concatenates the map with another map into a new [MapSignal](/types/mapsignal).
- <code>|</code> pipes/concatenates the map with another signal holding a map into a new [MapSignal](/types/mapsignal).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final settings = mapSignal<String, dynamic>({
    'theme': 'light',
    'notifications': true,
  });

  effect(() {
    print('Theme is currently: ${settings['theme']}');
  }); // Prints: "Theme is currently: light"

  // Update key/value pair directly (triggers updates)
  settings['theme'] = 'dark'; // Prints: "Theme is currently: dark"

  // Expose standard Map methods
  settings.remove('notifications');
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign <code>settings.value = ...</code> manually!
</Success>


#### Members of `MapSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MapSignal** | `constructor` | `MapSignal(super.value, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [MapSignal](/types/mapsignal) with the given **value**. |
| **<<** | `method` | `MapSignal<K, V> <<(Map<K, V> other)` | Inject: Update current signal value with iterable |
| **&** | `method` | `MapSignal<K, V> &(Map<K, V> other)` | Fork: create a new signal with value is the concatenation of source signal and iterable parameter |
| **|** | `method` | `MapSignal<K, V> |(Signal<Map<K, V>> other)` | Pipe: create a new signal by sending value from source to other |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### function `mapSignal`

Creates a [MapSignal](/types/mapsignal) initialized with the provided **map**.

This is a convenience helper function for creating reactive map signals.

```dart
import 'package:signals/signals.dart';

final settings = mapSignal({'theme': 'dark'});
```

**Signature**:
```dart
MapSignal<K, V> mapSignal(Map<K, V> map, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalMapUtils`

Utility extension methods on **Map** to convert them to [MapSignal](/types/mapsignal)s.


#### Members of `SignalMapUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `MapSignal<K, V> toSignal({MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **Map** to a reactive [MapSignal](/types/mapsignal).

```dart
import 'package:signals/signals.dart';

final myMap = {'key': 'value'};
final signal = myMap.toSignal();
``` |

---
### class `MapSignalOptions`

Configuration options for a [MapSignal](/types/mapsignal).


#### Members of `MapSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MapSignalOptions** | `constructor` | `MapSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [MapSignalOptions](/types/mapsignaloptions) instance. |
| **copyWith** | `method` | `MapSignalOptions<K, V> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Map<K, V>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `SetSignal`

A reactive [Signal](/types/signal) that holds a **Set** and implements the **Set** interface.

[SetSignal](/types/setsignal) lets you listen to changes on a set reactively and mutate it directly using
standard set operations (like <code>add</code>, <code>addAll</code>, <code>remove</code>, <code>clear</code>, etc.). Any mutations
automatically trigger reactive updates to all active listeners (e.g., inside an [effect](/types/effect)
or [computed](/types/computed)).

Additionally, [SetSignal](/types/setsignal) defines convenient operators:
- <code><<</code> injects/adds all items from another set into the current set.
- <code>&</code> forks/unions the set with another set into a new [SetSignal](/types/setsignal).
- <code>|</code> pipes/unions the set with another signal holding an iterable into a new [SetSignal](/types/setsignal).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final numbers = setSignal<int>({1, 2, 3});

  effect(() {
    print('Set content: $numbers, Length: ${numbers.length}');
  }); // Prints: "Set content: {1, 2, 3}, Length: 3"

  // Standard mutation (triggers updates)
  numbers.add(4); // Prints: "Set content: {1, 2, 3, 4}, Length: 4"

  // Removing an element (triggers updates)
  numbers.remove(1); // Prints: "Set content: {2, 3, 4}, Length: 3"

  // Set intersection (reactive query)
  final common = numbers.intersection({3, 4, 5});
  print(common); // Prints: {3, 4}
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign <code>numbers.value = ...</code> manually!
</Success>


#### Members of `SetSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SetSignal** | `constructor` | `SetSignal(super.value, {SetSignalOptions<E>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [SetSignal](/types/setsignal) with the given **value**. |
| **<<** | `method` | `SetSignal<E> <<(Set<E> other)` | Inject: Update current signal value with iterable |
| **&** | `method` | `SetSignal<E> &(Set<E> other)` | Fork: create a new signal with value is the concatenation of source signal and iterable parameter |
| **|** | `method` | `SetSignal<E> |(Signal<Iterable<E>> other)` | Pipe: create a new signal by sending value from source to other |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### function `setSignal`

Creates a [SetSignal](/types/setsignal) initialized with the provided **set**.

This is a convenience helper function for creating reactive set signals.

```dart
import 'package:signals/signals.dart';

final mySet = setSignal({1, 2, 3});
```

**Signature**:
```dart
SetSignal<T> setSignal(Set<T> list, {SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalSetUtils`

Utility extension methods on **Set** to convert them to [SetSignal](/types/setsignal)s.


#### Members of `SignalSetUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `SetSignal<T> toSignal({SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **Set** to a reactive [SetSignal](/types/setsignal).

```dart
import 'package:signals/signals.dart';

final mySet = {1, 2, 3};
final signal = mySet.toSignal();
``` |

---
### class `SetSignalOptions`

Configuration options for a [SetSignal](/types/setsignal).


#### Members of `SetSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SetSignalOptions** | `constructor` | `SetSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [SetSignalOptions](/types/setsignaloptions) instance. |
| **copyWith** | `method` | `SetSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Set<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `QueueSignal`

A [Signal](/types/signal) that holds a **Queue**.


#### Members of `QueueSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **QueueSignal** | `constructor` | `QueueSignal(super.value, {QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [QueueSignal](/types/queuesignal) with the given **value**. |

---
### function `queueSignal`

Creates a [QueueSignal](/types/queuesignal) with the given **list** (Queue).

**Signature**:
```dart
QueueSignal<T> queueSignal(Queue<T> list, {QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalQueueUtils`

Utility extension methods on **Queue** to convert them to [QueueSignal](/types/queuesignal)s.


#### Members of `SignalQueueUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `QueueSignal<T> toSignal({QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})` | Convert an existing list to [QueueSignal](/types/queuesignal) |

---
### class `QueueSignalOptions`

Configuration options for a [QueueSignal](/types/queuesignal).


#### Members of `QueueSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **QueueSignalOptions** | `constructor` | `QueueSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [QueueSignalOptions](/types/queuesignaloptions) instance. |
| **copyWith** | `method` | `QueueSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Queue<T>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `IterableSignal`

A reactive [Signal](/types/signal) that holds an **Iterable** and implements the **Iterable** interface.

[IterableSignal](/types/iterablesignal) allows you to listen to changes on an iterable collection reactively. It
exposes all standard **Iterable** properties and methods (like <code>length</code>, <code>first</code>, <code>map</code>, <code>where</code>, etc.)
directly on the signal itself. Calling these methods inside a reactive context (like an <code>effect</code>
or <code>computed</code> block) will automatically track them as dependencies.

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final items = iterableSignal<int>([1, 2, 3]);

  effect(() {
    print('Items length: ${items.length}, First: ${items.first}');
  }); // Prints: "Items length: 3, First: 1"

  // Update the signal by assigning a new iterable
  items.value = [10, 20, 30, 40]; // Prints: "Items length: 4, First: 10"
}
```

<Warning>
Direct mutation of the items inside the iterable will NOT trigger updates. To reactively mutate collections,
use specialized signals like <a href="/types/listsignal">ListSignal</a>, <a href="/types/setsignal">SetSignal</a>, or <a href="/types/mapsignal">MapSignal</a>.
</Warning>


#### Members of `IterableSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **IterableSignal** | `constructor` | `IterableSignal(super.value, {IterableSignalOptions<E>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [IterableSignal](/types/iterablesignal) with the given **value**. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### function `iterableSignal`

Creates an [IterableSignal](/types/iterablesignal) holding the provided **iterable**.

This is a convenience function that instantiates an [IterableSignal](/types/iterablesignal), which delegates
all standard **Iterable** operations reactively and tracks changes.

### Example Usage

```dart
import 'package:signals/signals.dart';

final s = iterableSignal([1, 2, 3]);
print(s.length); // 3
```

**Signature**:
```dart
IterableSignal<T> iterableSignal(Iterable<T> iterable, {IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalIterableUtils`

Utility extension methods on **Iterable** to convert them to [IterableSignal](/types/iterablesignal)s.


#### Members of `SignalIterableUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `IterableSignal<T> toSignal({IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})` | Convert an existing **Iterable** to an [IterableSignal](/types/iterablesignal).

This returns an [IterableSignal](/types/iterablesignal) initialized with the current collection.

```dart
import 'package:signals/signals.dart';

final numbers = [1, 2, 3];
final signal = numbers.toSignal();
``` |

---
### class `IterableSignalOptions`

Configuration options for a [IterableSignal](/types/iterablesignal).


#### Members of `IterableSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **IterableSignalOptions** | `constructor` | `IterableSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [IterableSignalOptions](/types/iterablesignaloptions) instance. |
| **copyWith** | `method` | `IterableSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Iterable<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `ChangeStackSignal`

A reactive [Signal](/types/signal) that records its history of values, allowing undo and redo operations.

[ChangeStackSignal](/types/changestacksignal) stores successive values of the signal in a double-ended queue.
This allows you to revert back to previous values using **undo** and re-apply undone values
using **redo**. You can also specify an optional **limit** parameter to cap the history queue size.

<Info>
If you only need access to the initial and immediate previous values of a signal (without a full
history stack or undo/redo mechanisms), use the lightweight <a href="/types/trackedsignalmixin">TrackedSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final counter = ChangeStackSignal<int>(0, limit: 5);

  effect(() {
    print('Counter: ${counter.value}');
  }); // Prints: "Counter: 0"

  counter.value = 1; // Prints: "Counter: 1"
  counter.value = 2; // Prints: "Counter: 2"

  print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"

  // Perform undo operation (automatically triggers reactive updates)
  counter.undo(); // Prints: "Counter: 1"
  counter.undo(); // Prints: "Counter: 0"

  // Perform redo operation
  counter.redo(); // Prints: "Counter: 1"
}
```

<Warning>
This class works best with values that are immutable or copied when updated.
If you mutate an object in-place directly without assigning a new value using the <code>.value</code>
setter or <code>set(...)</code>, the history queue will store references to the same mutated object, and
undo/redo operations will not reflect changes correctly.
</Warning>


#### Members of `ChangeStackSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ChangeStackSignal** | `constructor` | `ChangeStackSignal(super.value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})` | Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided **value**. |

---
### function `changeStack`

Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided **value**.

This is a convenience helper function for creating reactive undo/redo history signals.
You can pass a **limit** to restrict the maximum history stack size.

```dart
import 'package:signals/signals.dart';

final s = changeStack(0, limit: 10);
s.value = 1;
s.undo(); // Returns to 0
```

**Signature**:
```dart
ChangeStackSignal<T> changeStack(T value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})
```


---
### class `ChangeSignalOptions`

Configuration options for a [ChangeStackSignal](/types/changestacksignal).


#### Members of `ChangeSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | `field` | `int? limit` | The limit of changes to keep in the undo/redo stack. |
| **ChangeSignalOptions** | `constructor` | `ChangeSignalOptions({this.limit, super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [ChangeSignalOptions](/types/changesignaloptions) instance. |
| **copyWith** | `method` | `ChangeSignalOptions<T> copyWith({int? limit, String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `TrackedSignal`

A signal that stores the initial and previous value


#### Members of `TrackedSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **TrackedSignal** | `constructor` | `TrackedSignal(super.value, {TrackedSignalOptions<T>? options, @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: TrackedSignalOptions(name: ...) instead') String? debugLabel})` | A signal that stores the initial and previous value |

---
### function `trackedSignal`

Create a signal that stores the initial and previous value

**Signature**:
```dart
TrackedSignal<T> trackedSignal(T value, {TrackedSignalOptions<T>? options, @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: TrackedSignalOptions(name: ...) instead') String? debugLabel})
```


---
### class `TrackedSignalOptions`

Configuration options for a [TrackedSignal](/types/trackedsignal).


#### Members of `TrackedSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **TrackedSignalOptions** | `constructor` | `TrackedSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [TrackedSignalOptions](/types/trackedsignaloptions) instance. |
| **copyWith** | `method` | `TrackedSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `SignalContainer`

Signal container used to create signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

Example of settings and SharedPreferences:

```dart
class Settings {
  final SharedPreferences prefs;
  EffectCleanup? _cleanup;

  Settings(this.prefs) {
    _cleanup = effect(() {
      for (final entry in setting.store.entries) {
        final value = entry.value.peek();
        if (prefs.getString(entry.key.$1) != value) {
          prefs.setString(entry.key.$1, value).ignore();
        }
      }
    });
  }

  late final setting = signalContainer<String, (String, String)>(
    (val) => signal(prefs.getString(val.$1) ?? val.$2),
    cache: true,
  );

  Signal<String> get darkMode => setting(('dark-mode', 'false'));

  void dispose() {
    _cleanup?.call();
    setting.dispose();
  }
}

void main() {
 // Load or find instance
 late final SharedPreferences prefs = ...;

 // Create settings
 final settings = Settings(prefs);

 // Get value
 print('dark mode: ${settings.darkMode}');

 // Update value
 settings.darkMode.value = 'true';
}
```


#### Members of `SignalContainer`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cache** | `field` | `bool cache` | If true then signals will be cached when created |
| **onEvict** | `field` | `void Function(Arg key, S signal)? onEvict` | Optional callback when a signal is removed/evicted from the cache |
| **store** | `field` | `store` | Store of created signals (if cache is true) |
| **SignalContainer** | `constructor` | `SignalContainer(this._create, {this.cache = false, this.onEvict})` | Signal container used to create multiple signals via args |
| **call** | `method` | `S call(Arg arg)` | Create the signal with the given args |
| **remove** | `method` | `S? remove(Arg arg)` | Remove a signal from the cache |
| **containsKey** | `method` | `bool containsKey(Arg arg)` | Check if signal is currently stored in the cache |
| **clear** | `method` | `void clear()` | Clear the cache |
| **dispose** | `method` | `void dispose()` | Dispose of all created signals |
| **length** | `method` | `int length` | Returns the number of cached signals. |
| **isEmpty** | `method` | `bool isEmpty` | Returns true if the cache is empty. |
| **isNotEmpty** | `method` | `bool isNotEmpty` | Returns true if the cache is not empty. |
| **keys** | `method` | `Iterable<Arg> keys` | Returns all currently cached keys. |
| **values** | `method` | `Iterable<S> values` | Returns all currently cached signals. |
| **entries** | `method` | `Iterable<MapEntry<Arg, S>> entries` | Returns all currently cached entries. |
| **lookup** | `method` | `S? lookup(Arg arg)` | Retrieve the cached signal for **arg** if it exists, without creating a new one if it is missing. |
| **removeWhere** | `method` | `void removeWhere(bool Function(Arg key, S signal) test)` | Filter and remove matching cached signals. |

---
### function `readonlySignalContainer`

Create a signal container used to instance signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

The signals cannot be updated but allows for
using computed where the value is only derived from other signals.

**Signature**:
```dart
SignalContainer<T, Arg, ReadonlySignal<T>> readonlySignalContainer(ReadonlySignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, ReadonlySignal<T> signal)? onEvict})
```


---
### function `signalContainer`

Create a signal container used to instance signals based on args

```dart
final container = signalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');

cacheA.value = 'a';
cacheB.value = 'b';
cacheC.value = 'c';
```

**Signature**:
```dart
SignalContainer<T, Arg, Signal<T>> signalContainer(Signal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Signal<T> signal)? onEvict})
```


---
### function `computedContainer`

Create a signal container for computed signals based on args.

```dart
final container = computedContainer<int, int>((arg) {
  return computed(() => sourceSignal.value * arg);
});
```

**Signature**:
```dart
SignalContainer<T, Arg, Computed<T>> computedContainer(Computed<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Computed<T> signal)? onEvict})
```


---
### function `futureSignalContainer`

Create a signal container for FutureSignals based on args.

```dart
final container = futureSignalContainer<Post, int>((id) {
  return futureSignal(() => fetchPost(id));
});
```

**Signature**:
```dart
SignalContainer<AsyncState<T>, Arg, FutureSignal<T>> futureSignalContainer(FutureSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, FutureSignal<T> signal)? onEvict})
```


---
### function `streamSignalContainer`

Create a signal container for StreamSignals based on args.

```dart
final container = streamSignalContainer<Message, int>((roomId) {
  return streamSignal(() => listenToRoom(roomId));
});
```

**Signature**:
```dart
SignalContainer<AsyncState<T>, Arg, StreamSignal<T>> streamSignalContainer(StreamSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, StreamSignal<T> signal)? onEvict})
```


---
### class `SignalsError`

Signal usage error


#### Members of `SignalsError`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **message** | `field` | `String message` | Signals error pretty print message |
| **SignalsError** | `constructor` | `SignalsError(this.message)` | Signal usage error |
| **toString** | `method` | `String toString()` |  |

---
### class `SignalsReadAfterDisposeError`

Error to throw if a signal is read after it is disposed


#### Members of `SignalsReadAfterDisposeError`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalsReadAfterDisposeError** | `constructor` | `SignalsReadAfterDisposeError(ReadonlySignal instance)` | Error to throw if a signal is read after it is disposed |

---
### class `LazySignalInitializationError`

Lazy signal must value value set before it is read


#### Members of `LazySignalInitializationError`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **LazySignalInitializationError** | `constructor` | `LazySignalInitializationError(ReadonlySignal instance)` | Lazy signal must value value set before it is read |

---
### class `SignalsWriteAfterDisposeError`

Error to throw if a signal is written to after it is disposed


#### Members of `SignalsWriteAfterDisposeError`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalsWriteAfterDisposeError** | `constructor` | `SignalsWriteAfterDisposeError(ReadonlySignal instance)` | Error to throw if a signal is written to after it is disposed |

---
### class `EffectCycleDetectionError`

Cycle detection usually means you have updated
a signal inside an effect and are reading by value.



---
### class `EffectOptions`

Configuration options for reactive [Effect](/types/effect)s extending **signals.EffectOptions**.


#### Members of `EffectOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **onDispose** | `field` | `void Function()? onDispose` | Callback called when the effect is disposed. |
| **EffectOptions** | `constructor` | `EffectOptions({super.name, this.autoDispose = false, this.onDispose})` | Creates a new [EffectOptions](/types/effectoptions) instance. |
| **copyWith** | `method` | `EffectOptions copyWith({String? name, bool? autoDispose, void Function()? onDispose})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `ReadonlySignalOptions`

Configuration options for a [ReadonlySignal](/types/readonlysignal) extending **signals.ReadonlySignalOptions**.


#### Members of `ReadonlySignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **toSignalOptions** | `method` | `SignalOptions<T> toSignalOptions` | Convert to [SignalOptions](/types/signaloptions) |
| **ReadonlySignalOptions** | `constructor` | `ReadonlySignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})` | Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance. |
| **copyWith** | `method` | `ReadonlySignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `SignalOptions`

Configuration options for a [Signal](/types/signal) extending **signals.SignalOptions**.


#### Members of `SignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **SignalOptions** | `constructor` | `SignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched, super.equality})` | Creates a new [SignalOptions](/types/signaloptions) instance. |
| **copyWith** | `method` | `SignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `ComputedOptions`

Configuration options for a [Computed](/types/computed) extending **signals.ComputedOptions**.


#### Members of `ComputedOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **ComputedOptions** | `constructor` | `ComputedOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})` | Creates a new [ComputedOptions](/types/computedoptions) instance. |
| **copyWith** | `method` | `ComputedOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `SignalsObserver`

You can observe all signal values in the dart application by providing an implementation of <code>SignalsObserver</code>:

```dart
abstract class SignalsObserver {
  void onSignalCreated(Signal instance);
  void onSignalUpdated(Signal instance, dynamic value);
  void onComputedCreated(Computed instance);
  void onComputedUpdated(Computed instance, dynamic value);
  static SignalsObserver? instance;
}
```

> There is a prebuilt <code>LoggingSignalsObserver</code> for printing updates to the console.

To add the observer override the instance at the start of the application:

```dart
void main() {
    SignalsObserver.instance = LoggingSignalsObserver(); // or custom observer
    ...
}
```

This will have a slight performance hit since every update will be tracked via the observer. It is recommended to only set the <code>SignalsObserver.instance</code> in debug or profile mode.


#### Members of `SignalsObserver`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` | Called when a signal is created. |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` | Called when a signal is updated. |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` | Called when a computed is created. |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` | Called when a computed is updated. |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` | Called when a effect is created. |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` | Called when a effect is called. |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` | Called when a effect is disposed. |
| **instance** | `field` | `static SignalsObserver? instance` | The current observer instance. |

---
### class `LoggingSignalsObserver`

Logs all signals and computed changes to the console.


#### Members of `LoggingSignalsObserver`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` |  |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` |  |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` |  |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` |  |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` |  |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` |  |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` |  |
| **log** | `method` | `void log(String message)` | Logs a message to the console. |

---
### class `Effect`

An <code>Effect</code> is the passive consumer of the reactive model. It allows you to run arbitrary side-effects (such as logging, database writes, or UI rendering updates) whenever any of its tracked dependencies mutate.

Any signal accessed via <code>.value</code> inside the effect callback is automatically registered as a dependency. When a dependency changes, the effect is re-run.

### Core Example
```dart
import 'package:signals/signals.dart';

final counter = signal(0);

// Create an active effect: prints "Count: 0" immediately
final dispose = effect(() {
  print('Count: ${counter.value}');
});

// Updating the signal re-runs the effect: prints "Count: 1"
counter.value = 1;

// Clean up the effect to unsubscribe from updates
dispose();
```

---

## Key API Capabilities

### 1. Lifecycle Cleanup Callback
You can return an optional <code>void Function()</code> from the effect callback block. This cleanup function is automatically invoked the next time the effect is re-run, or when the effect is permanently disposed. This is perfect for cancelling timers, sockets, or other active event channels.

```dart
final counter = signal(0);

effect(() {
  final count = counter.value;
  final timer = Timer(Duration(seconds: 1), () => print('Timer fired for $count'));

  // Cleanup function called before re-run or dispose
  return () => timer.cancel();
});
```

### 2. Lifecycle Listeners via <code>onDispose</code>
You can attach explicit cleanup routines that run when the effect is destroyed by passing <code>onDispose</code> in the options or by calling <code>.onDispose(callback)</code> directly on the effect instance.

```dart
final counter = signal(0);
final dispose = effect(
  () => print(counter.value),
  options: EffectOptions(
    onDispose: () => print('Effect has been unmounted!'),
  ),
);

dispose(); // Prints: "Effect has been unmounted!"
```

---

## ⚠️ Warning: Preventing Cycles
Mutating a signal *directly* inside an effect that reads that same signal will cause an infinite loop (cycle), throwing a <code>StackOverflowError</code> or a cycle exception. To read a signal inside an effect without subscribing to its updates, wrap the read operation in <code>untracked()</code>.

```dart
final a = signal(0);
final b = signal(0);

effect(() {
  // Active subscription to a
  final valA = a.value;

  // Read b non-reactively using untracked to prevent circular subscriptions
  final valB = untracked(() => b.value);

  print('A: $valA, B: $valB');
});
```


#### Members of `Effect`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **debugLabel** | `method` | `String? debugLabel` | Label used for debugging |
| **Effect** | `constructor` | `Effect(super.fn, {EffectOptions? options, @Deprecated('Use options: EffectOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: EffectOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: EffectOptions(onDispose: ...) instead') void Function()? onDispose})` | The <code>effect</code> function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [<code>computed(fn)</code>](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside <code>effect</code>.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Updating one of its dependencies will automatically trigger
// the effect above, and will print "John Doe" to the console.
name.value = "John";
```

You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
final dispose = effect(() => print(fullName.value));

// Destroy effect and subscriptions
dispose();

// Update does nothing, because no one is subscribed anymore.
// Even the computed `fullName` signal won't change, because it knows
// that no one listens to it.
surname.value = "Doe 2";
```

## Cleanup Callback

You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
  return () => print('Effect destroyed');
});

// Destroy effect and subscriptions
dispose();
```

## On Dispose Callback

You can also pass a callback to <code>effect</code> that will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
}, onDispose: () => print('Effect destroyed'));

// Destroy effect and subscriptions
dispose();
```

## Warning About Cycles

Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [<code>untracked(fn)</code>](/core/untracked) to read a signal without subscribing to it.

```dart
import 'dart:async';

import 'package:signals/signals.dart';

Future<void> main() async {
  final completer = Completer<void>();
  final age = signal(0);

  effect(() {
    print('You are ${age.value} years old');
    age.value++; // <-- This will throw a cycle error
  });

  await completer.future;
}
``` |
| **call** | `method` | `void Function() call()` |  |
| **dispose** | `method` | `void dispose()` |  |
| **disposed** | `method` | `bool disposed` | Check if the effect is disposed |
| **disposed** | `method` | `disposed(bool value)` | Force an effect to be disposed |
| **onDispose** | `method` | `EffectCleanup onDispose(void Function() cleanup)` | Add a cleanup function to be called when the signal is disposed

```dart
final counter = signal(0);
final effectCount = signal(0);

final cleanup = counter.onDispose(() {
 print('Counter has been disposed');
});

// Remove the cleanup function
cleanup();
``` |

---
### function `effect`

The <code>effect</code> function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [<code>computed(fn)</code>](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside <code>effect</code>.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Updating one of its dependencies will automatically trigger
// the effect above, and will print "John Doe" to the console.
name.value = "John";
```

You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
final dispose = effect(() => print(fullName.value));

// Destroy effect and subscriptions
dispose();

// Update does nothing, because no one is subscribed anymore.
// Even the computed `fullName` signal won't change, because it knows
// that no one listens to it.
surname.value = "Doe 2";
```

## Cleanup Callback

You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
  return () => print('Effect destroyed');
});

// Destroy effect and subscriptions
dispose();
```

## On Dispose Callback

You can also pass a callback to <code>effect</code> that will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
}, onDispose: () => print('Effect destroyed'));

// Destroy effect and subscriptions
dispose();
```

## Warning About Cycles

Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [<code>untracked(fn)</code>](/core/untracked) to read a signal without subscribing to it.

```dart
import 'dart:async';

import 'package:signals/signals.dart';

Future<void> main() async {
  final completer = Completer<void>();
  final age = signal(0);

  effect(() {
    print('You are ${age.value} years old');
    age.value++; // <-- This will throw a cycle error
  });

  await completer.future;
}
```

**Signature**:
```dart
EffectCleanup effect(EffectCallback fn, {EffectOptions? options, @Deprecated('Use options: EffectOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: EffectOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: EffectOptions(onDispose: ...) instead') void Function()? onDispose})
```


---
### class `Computed`

A <code>Computed</code> signal represents derived reactive state. It combines the values of multiple dependency signals into a new read-only signal, automatically re-evaluating whenever any of its dependencies mutate.

Computed signals are **lazily evaluated** and **memoized** by default:
- **Lazy Evaluation:** The computed callback is only executed when the computed signal is actively read or listened to.
- **Memoization:** The computed signal caches its return value and will not re-run its callback if its dependency values have not changed or if no active listeners exist.
- **Glitch-Free Propagation:** The reactive graph updates topologically. This guarantees that intermediate "glitches" (inconsistent state views) are physically impossible during multiple simultaneous signal updates.

### Core Example
```dart
import 'package:signals/signals.dart';

final firstName = signal("Jane");
final lastName = signal("Doe");

// Create a derived computed signal
final fullName = computed(() => "${firstName.value} ${lastName.value}");

// Accessing .value: prints "Jane Doe"
print(fullName.value);

// Update a dependency: fullName will automatically reflect changes on next read
firstName.value = "John";
print(fullName.value); // Prints "John Doe"
```

Any signal accessed inside the computed callback block is automatically registered as a dependency.

---

## Key API Capabilities

### 1. Forcing Re-evaluation via <code>.recompute()</code>
In advanced scenarios where a computed value depends on external, non-reactive variables, you can force the computed block to discard its cache and re-evaluate immediately using <code>.recompute()</code>.

```dart
final externalTime = DateTime.now();
final timeString = computed(() {
  return "Time: ${externalTime.toIso8601String()}";
});

// Force re-runs the callback
timeString.recompute();
```

### 2. Resource Management & Disposal
Like standard signals, a computed signal can be configured to automatically garbage-collect itself when it has no active subscribers.

- **Auto-Dispose:** Set <code>autoDispose: true</code> in the options. The computed signal will release its cached value, clear all dependency listeners, and enter a frozen state once all active subscriptions are terminated.
- **Lifecyle Callbacks:** Register custom routines via <code>.onDispose(callback)</code> to clean up external streams or resources used within the computed block.

```dart
final s = computed(
  () => 42,
  options: ComputedOptions(autoDispose: true),
);

s.onDispose(() => print('Computed destroyed'));

final dispose = s.subscribe((_) {});
dispose(); // Prints: "Computed destroyed"
```

---

## Flutter Integration
In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class EvenOddWidget extends SignalStatefulWidget {
  const EvenOddWidget({super.key});

  @override
  State<EvenOddWidget> createState() => _EvenOddWidgetState();
}

class _EvenOddWidgetState extends State<EvenOddWidget> {
  final counter = signal(0);

  // Derived state tied directly to the State object lifecycle
  late final isEven = computed(() => counter.value.isEven);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Rebuilds implicitly when isEven.value changes
        child: Text('Is Even: ${isEven.value}'),
      ),
    );
  }
}
```

---

## Testing Strategies
Testing derived computed states is extremely straightforward. You can easily test them directly as raw values or sequence them in asynchronous flows by converting the computed signal into a Dart stream via <code>.toStream()</code>.

```dart
test('computed stream emissions', () async {
  final a = signal(0);
  final doubleVal = computed(() => a.value * 2);
  final stream = doubleVal.toStream();

  a.value = 1;
  a.value = 2;

  await expectLater(stream, emitsInOrder([0, 2, 4]));
});
```
You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it.


#### Members of `Computed`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Computed** | `constructor` | `Computed(super.fn, {ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel})` | Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

> <code>Computed</code> class extends the [<code>Signal</code>](/core/signal/) class, so you can use it anywhere you would use a signal.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the <code>computed</code>'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

> Computed signals are both lazily evaluated and memoized

## Force Re-evaluation

You can force a computed signal to re-evaluate by calling its <code>.recompute</code> method. This will re-run the computed callback and update the computed signal's value.

```dart
final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

fullName.recompute(); // Re-runs the computed callback
```

## Disposing

### Auto Dispose

If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = computed(() => 0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

This means that it will no longer react to changes in its dependencies.

```dart
final s = computed(() => 0);
s.dispose();
final value = s.value; // 0
final b = computed(() => s.value); // 0
// b will not react to changes in s
```

You can check if a signal is disposed by calling the <code>.disposed</code> method.

```dart
final s = computed(() => 0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = computed(() => 0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```


## Flutter

In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterWidget extends SignalStatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final counter = signal(0);
  late final isEven = computed(() => counter.value.isEven);
  late final isOdd = computed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

No manual <code>Watch</code> widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.

## Testing

Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.

```dart
test('test as stream', () {
    final a = signal(0);
    final s = computed(() => a());
    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 3;

    expect(stream, emitsInOrder([0, 1, 2, 3]));
});
```

<code>emitsInOrder</code> is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.

You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it. |
| **overrideWith** | `method` | `Computed<T> overrideWith(T val)` | Override the current signal with a new value as if it was created with it.

This does not trigger any updates.

```dart
var counter = computed(() => 0);

// Override the signal with a new value
counter = counter.overrideWith(1);
``` |
| **debugLabel** | `method` | `String? debugLabel` |  |
| **recompute** | `method` | `void recompute()` | Call the computed function and update the value |
| **dispose** | `method` | `void dispose()` |  |
| **readonly** | `method` | `ReadonlySignal<T> readonly()` | Returns a readonly signal |
| **unsubscribeFromNode** | `method` | `void unsubscribeFromNode(Node node)` |  |
| **value** | `method` | `T value` |  |
| **internalValue** | `method` | `internalValue(T value)` |  |

---
### function `computed`

Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

> <code>Computed</code> class extends the [<code>Signal</code>](/core/signal/) class, so you can use it anywhere you would use a signal.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the <code>computed</code>'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

> Computed signals are both lazily evaluated and memoized

## Force Re-evaluation

You can force a computed signal to re-evaluate by calling its <code>.recompute</code> method. This will re-run the computed callback and update the computed signal's value.

```dart
final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

fullName.recompute(); // Re-runs the computed callback
```

## Disposing

### Auto Dispose

If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = computed(() => 0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

This means that it will no longer react to changes in its dependencies.

```dart
final s = computed(() => 0);
s.dispose();
final value = s.value; // 0
final b = computed(() => s.value); // 0
// b will not react to changes in s
```

You can check if a signal is disposed by calling the <code>.disposed</code> method.

```dart
final s = computed(() => 0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = computed(() => 0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```


## Flutter

In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterWidget extends SignalStatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final counter = signal(0);
  late final isEven = computed(() => counter.value.isEven);
  late final isOdd = computed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

No manual <code>Watch</code> widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.

## Testing

Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.

```dart
test('test as stream', () {
    final a = signal(0);
    final s = computed(() => a());
    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 3;

    expect(stream, emitsInOrder([0, 1, 2, 3]));
});
```

<code>emitsInOrder</code> is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.

You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it.

**Signature**:
```dart
Computed<T> computed(ComputedCallback<T> compute, {ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel})
```


---
### class `Signal`

Simple writeable signal


#### Members of `Signal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Signal** | `constructor` | `Signal(super.internalValue, {SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})` | Simple writeable signal.

```dart
final count = signal(0);
print(count.value); // 0
count.value++;
print(count.value); // 1
``` |
| **Signal.lazy** | `constructor` | `Signal.lazy({SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})` | Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = Signal.lazy<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
``` |
| **debugLabel** | `method` | `String? debugLabel` |  |
| **equalityCheck** | `method` | `signals.SignalEquality<T> equalityCheck` | Optional method to check if to values are the same |
| **set** | `method` | `bool set(T val, {bool force = false})` |  |
| **value** | `method` | `T value` |  |
| **readonly** | `method` | `ReadonlySignal<T> readonly()` | Returns a readonly signal |
| **unsubscribeFromNode** | `method` | `void unsubscribeFromNode(Node node)` |  |
| **overrideWith** | `method` | `Signal<T> overrideWith(T val)` | Override the current signal with a new value as if it was created with it.

This does not trigger any updates.

```dart
var counter = signal(0);

// Override the signal with a new value
counter = counter.overrideWith(1);
``` |

---
### function `signal`

A <code>Signal</code> is a reactive container for a value that changes over time. It forms the bedrock of the reactive framework, allowing fine-grained, glitch-free propagation of state updates to dependent computeds and effects.

You can read a signal's current state, mutate it to dispatch updates, or subscribe to changes by accessing its <code>.value</code> property inside any active reactive context.

### Core Example
```dart
import 'package:signals/signals.dart';

// Create a reactive signal holding an integer
final counter = signal(0);

// Read the value: prints 0
print(counter.value);

// Write to a signal: dispatches updates to all downstreams synchronously
counter.value = 1;
```

---

## Key API Capabilities

### 1. Reading & Writing via <code>.value</code>
The <code>.value</code> property is the default way to interact with a signal.
- **Inside a Reactive Context:** Accessing <code>.value</code> inside a [computed](/types/computed) block or [effect](/types/effect) callback automatically registers the signal as a dependency, establishing an active subscription.
- **Outside a Reactive Context:** Acts as a standard getter and setter, allowing you to fetch or update the underlying state.

### 2. Non-reactive Reads via <code>.peek()</code>
If you need to read a signal's current value *without* subscribing to its updates inside a reactive context, use the <code>.peek()</code> method. This is invaluable when writing to another signal inside an effect based on the previous state, preventing infinite update loops (cycles).

```dart
final counter = signal(0);
final effectTriggerCount = signal(0);

effect(() {
  // Subscribes to changes of `counter`
  final current = counter.value;
  print('Counter updated: $current');

  // Read current count non-reactively and increment.
  // The effect will NOT subscribe to `effectTriggerCount`.
  effectTriggerCount.value = effectTriggerCount.peek() + 1;
});
```

### 3. Accessing the Previous State via <code>.previousValue</code>
Signals automatically cache their immediately preceding value. Accessing <code>.previousValue</code> lets you perform diffing or historic analysis. Like <code>.peek()</code>, reading <code>.previousValue</code> does not establish a reactive dependency.

```dart
final username = signal("initial_user");

effect(() {
  print('Current Username: ${username.value}');
  print('Previous Username: ${username.previousValue}');
});

username.value = "new_user";
// Prints:
// Current Username: new_user
// Previous Username: initial_user
```

### 4. Force Updates via <code>.set()</code>
When dealing with mutable data types (e.g., custom class instances, collections), mutating properties directly does not change the instance reference. You can force an update using <code>.set(..., force: true)</code> to skip standard equality checks and notify all downstreams.

```dart
final numbers = signal([1, 2, 3]);

// Modify the list in-place and force notify
numbers.value.add(4);
numbers.set(numbers.value, force: true);
```

---

## Lifecycle & Resource Management

### Auto-Disposal
If a signal is constructed with <code>autoDispose: true</code>, it will automatically destroy itself when it no longer has active reactive listeners (subscriptions). This prevents memory leaks by freeing resources as soon as they are out of scope.

```dart
final s = signal(0, options: SignalOptions(autoDispose: true));

s.onDispose(() => print('Signal has been disposed!'));

// Create active subscriber
final dispose = s.subscribe((_) {});

// Cancel subscription: s has no listeners, so it self-disposes
dispose();
// Prints: "Signal has been disposed!"
```

You can manually verify the lifecycle state using <code>.disposed</code>, or register custom clean-up routines via <code>.onDispose(callback)</code>.

---

## Flutter Integration
In Flutter applications, manage state and reactivity seamlessly by using [SignalWidget](/types/signalwidget) (for stateless widgets) or [SignalStatefulWidget](/types/signalstatefulwidget) (for stateful widgets).
These widgets establish an implicit reactive context directly at the element layer. Any signal accessed via <code>.value</code> inside the <code>build</code> method is automatically tracked, and the widget automatically rebuilds when they mutate.

### Stateless Example with [SignalWidget](/types/signalwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class CounterDisplay extends SignalWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Stateful Example with [SignalStatefulWidget](/types/signalstatefulwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterDisplay extends SignalStatefulWidget {
  const CounterDisplay({super.key});

  @override
  State<CounterDisplay> createState() => _CounterDisplayState();
}

class _CounterDisplayState extends State<CounterDisplay> {
  // Local signal scoped to this widget state:
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Testing Strategies

### 1. Converting to Streams
You can convert any reactive signal into a standard Dart **Stream** by calling <code>.toStream()</code>. This is highly beneficial for testing signal value sequences in order using test matchers.

```dart
test('emits sequential count updates in order', () async {
  final counter = signal(0);
  final stream = counter.toStream();

  counter.value = 1;
  counter.value = 2;

  await expectLater(stream, emitsInOrder([0, 1, 2]));
});
```

### 2. Dependency Injection & Mock Overrides
Global or lazy signals used across your application can be mocked or overridden during testing via <code>.overrideWith(value)</code>. This returns a new signal sharing the same global identifier, helping you mock complex state dependencies seamlessly.

```dart
test('mocking global signals', () {
  final apiToken = signal("production_token");

  // Override with test mock token
  apiToken.overrideWith("mock_test_token");

  expect(apiToken.value, "mock_test_token");
});
```

**Signature**:
```dart
Signal<T> signal(T value, {SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```


---
### function `lazySignal`

Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = lazySignal<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
```

**Signature**:
```dart
Signal<T> lazySignal({SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```


---
### function `batch`

The <code>batch</code> function allows you to combine multiple signal writes into one single update that is triggered at the end when the callback completes.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Combines both signal writes into one update. Once the callback
// returns the `effect` will trigger and we'll log "Foo Bar"
batch(() {
	name.value = "Foo";
	surname.value = "Bar";
});
```

When you access a signal that you wrote to earlier inside the callback, or access a computed signal that was invalidated by another signal, we'll only update the necessary dependencies to get the current value for the signal you read from. All other invalidated signals will update at the end of the callback function.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);
final _double = computed(() => counter.value * 2);
final _triple = computed(() => counter.value * 3);

effect(() => print(_double.value, _triple.value));

batch(() {
	counter.value = 1;
	// Logs: 2, despite being inside batch, but `triple`
	// will only update once the callback is complete
	print(_double.value);
});
// Now we reached the end of the batch and call the effect
```

Batches can be nested and updates will be flushed when the outermost batch call completes.

```dart
import 'package:signals/signals.dart';

final counter = signal(0);
effect(() => print(counter.value));

batch(() {
	batch(() {
		// Signal is invalidated, but update is not flushed because
		// we're still inside another batch
		counter.value = 1;
	});

	// Still not updated...
});
// Now the callback completed and we'll trigger the effect.
```

**Signature**:
```dart
T batch(BatchCallback<T> fn)
```


---
### function `untracked`

In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use <code>untracked</code> to prevent any subscriptions from happening.

```dart
final counter = signal(0);
final effectCount = signal(0);
final fn = () => effectCount.value + 1;

effect(() {
	print(counter.value);

	// Whenever this effect is triggered, run `fn` that gives new value
	effectCount.value = untracked(fn);
});
```

**Signature**:
```dart
T untracked(UntrackedCallback<T> fn)
```


---
### variable `onSignalRead`

Global callback when any signal is read.

**Signature**:
```dart
void Function(signals.ReadonlySignal)? onSignalRead
```


---
### mixin `ReadonlySignalMixin`

Readonly signal mixin for adding addition helper methods


#### Members of `ReadonlySignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **isInitialized** | `method` | `bool isInitialized` | Check if a signal value is set (does not subscribe) |
| **debugLabel** | `method` | `String? debugLabel` | Debug label for Debug Mode
Debug label for Debug Mode |
| **value** | `method` | `T value` |  |
| **peek** | `method` | `T peek()` |  |

---
### function `readonly`

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/types/readonlysignal) containing **value**. Under the hood, a mutable [Signal](/types/signal)
is created, but it is returned under the [ReadonlySignal](/types/readonlysignal) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks).

Returns:
- A [ReadonlySignal](/types/readonlysignal) containing the initial value.

### Example Usage

```dart
import 'package:signals_core/signals_core.dart';

final configUrl = readonly('https://api.example.com');

void main() {
  effect(() {
    print("Connecting to: ${configUrl.value}");
  });
}
```

<Warning>
  If you are trying to derive a value from other signals, do not use <a href="/types/readonly">readonly</a>. Use <a href="/types/computed">computed</a> instead
  to ensure the derived signal automatically re-evaluates when its source signals change.
</Warning>

**Signature**:
```dart
ReadonlySignal<T> readonly(T value, {ReadonlySignalOptions<T>? options, @Deprecated('Use options: ReadonlySignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ReadonlySignalOptions(name: ...) instead') String? debugLabel})
```


---
### mixin `SignalsAutoDisposeMixin`

Mixin to enable autodispose on a signal


#### Members of `SignalsAutoDisposeMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Throws and error if read after dispose and can be
disposed on last unsubscribe. |
| **disposed** | `method` | `bool disposed` | Check if the effect is disposed |
| **onDispose** | `method` | `void Function() onDispose(void Function() cleanup)` | Add a cleanup function to be called when the signal is disposed

```dart
final counter = signal(0);
final effectCount = signal(0);

final cleanup = counter.onDispose(() {
 print('Counter has been disposed');
});

// Remove the cleanup function
cleanup();
``` |
| **disposed** | `method` | `disposed(bool value)` | Force a signal to be disposed |
| **dispose** | `method` | `void dispose()` | Dispose the signal |

---
### class `LinkedSignalPreviousState`

Previous state of a [LinkedSignal](/types/linkedsignal), containing both the **source** value
and the computed **value** from that source version.


#### Members of `LinkedSignalPreviousState`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **source** | `field` | `S source` | The source value. |
| **value** | `field` | `T value` | The computed value. |
| **LinkedSignalPreviousState** | `constructor` | `LinkedSignalPreviousState(this.source, this.value)` | Creates a [LinkedSignalPreviousState](/types/linkedsignalpreviousstate). |

---
### class `LinkedSignalOptions`

Options for creating a [LinkedSignal](/types/linkedsignal).


#### Members of `LinkedSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computation** | `field` | `T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation` | Custom computation logic that runs when the source changes. |
| **sourceEquality** | `field` | `bool Function(S a, S b)? sourceEquality` | Optional equality check for the source values. |
| **LinkedSignalOptions** | `constructor` | `LinkedSignalOptions({this.computation, this.sourceEquality, super.name, super.autoDispose})` | Creates [LinkedSignalOptions](/types/linkedsignaloptions). |
| **copyWith** | `method` | `LinkedSignalOptions<T, S> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation, bool Function(S a, S b)? sourceEquality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `LinkedSignal`

A highly powerful, mutable computed signal that derives its default value from an underlying source,
but allows manual write overrides. Crucially, **whenever the underlying source value changes, the signal**
**automatically discards any local manual overrides and resets back to the newly computed default.**

This hybrid behavior is the perfect solution for synchronizing local edit state with external remote state.

### 1. Real-World Use Case: Profile Form Editor
Imagine you are building a profile editor where the user can modify their username:
- The initial/remote username is fetched from a database and held in a source signal.
- The text input field is bound to a local signal.
- The user should be able to edit the field locally (overriding the remote default).
- If the selected user changes (e.g., they switch to a different profile in a list), the text field must automatically discard any local changes and reset to the new user's username.

```dart
// The remote/source state
final selectedUser = signal(User(id: 1, name: 'Alice'));

// The local editable state linked to the remote source
final username = linkedSignal(() => selectedUser.value.name);

print(username.value); // 'Alice'

// User edits the text field:
username.value = 'Bob';
print(username.value); // 'Bob' (local override active)

// Switch remote profile:
selectedUser.value = User(id: 2, name: 'Charlie');

// Local overrides are discarded and reset to the new source:
print(username.value); // 'Charlie'
```

### 2. Custom Computations using <code>LinkedSignalOptions</code>
By default, a linked signal directly passes the source value through. You can customize this mapping using a custom <code>computation</code> function that has access to both the current source value and the previous state:

```dart
final counter = signal(10);

final doubled = linkedSignal(
  () => counter.value,
  options: LinkedSignalOptions(
    computation: (sourceVal, prev) {
      print('Source changed to $sourceVal. Previous value was: ${prev?.value}');
      return sourceVal * 2;
    },
  ),
);
```

### 3. Custom Source Equality
To prevent unnecessary resets, you can supply a custom <code>sourceEquality</code> callback. The signal will only reset when the equality check returns <code>false</code>:

```dart
final selectedUser = signal(User(id: 1, name: 'Alice'));

final username = linkedSignal(
  () => selectedUser.value,
  options: LinkedSignalOptions(
    // Only reset when the user ID actually changes:
    sourceEquality: (a, b) => a.id == b.id,
  ),
);
```

<Info>
  Always use <code>LinkedSignal</code> rather than manual <code>effect</code> listeners to synchronize local editable values with remote defaults. It is simpler, avoids race conditions, and consumes significantly less memory.
</Info>


#### Members of `LinkedSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **LinkedSignal** | `constructor` | `LinkedSignal({required S Function() source, LinkedSignalOptions<T, S>? options})` | Creates a new [LinkedSignal](/types/linkedsignal). |
| **set** | `method` | `bool set(T val, {bool force = false})` |  |
| **value** | `method` | `T value` |  |
| **value** | `method` | `value(T val)` |  |
| **dispose** | `method` | `void dispose()` |  |

---
### function `linkedSignal`

{@macro linked_signal}

**Signature**:
```dart
LinkedSignal<T, S> linkedSignal(S Function() source, {LinkedSignalOptions<T, S>? options})
```


---
### class `Connect`

A highly powerful connector utility that allows you to dynamically stream and pipe multiple asynchronous streams directly into a single reactive [Signal](/types/signal).

The concept is inspired by **Angular Signals** integration with RxJS streams.

Start with an existing mutable [Signal](/types/signal) and call <code>connect(signal)</code> to create a connector instance.

### 1. Chaining Streams
You can bind multiple streams to feed the same destination signal. The connector will handle the subscription management for all streams seamlessly.

```dart
final counter = signal(0);
final connector = connect(counter);

final fastStream = Stream.periodic(Duration(seconds: 1), (i) => i);
final slowStream = Stream.periodic(Duration(seconds: 5), (i) => i * 10);

// Values from both streams will be piped into the counter signal!
connector.from(fastStream).from(slowStream);
```

### 2. The Shift Operator (<code><<</code>)
For a more concise and beautiful visual flow, you can use the shift operator (<code><<</code>) to chain streams:

```dart
final s = signal(0);
final c = connect(s);

c << fastStream << slowStream;
```

### 3. Lifecycle and Disposal
To avoid memory leaks, make sure to dispose the connector when it is no longer needed. Disposing the connector will automatically cancel all underlying active stream subscriptions.

```dart
connector.dispose(); // Cancels all stream subscriptions safely
```


#### Members of `Connect`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Connect** | `constructor` | `Connect(this.signal)` | Connects a **Stream** to a [Signal](/types/signal). |
| **signal** | `field` | `Signal<T> signal` | Internal signal to connect to. |
| **from** | `method` | `Connect<T, S> from(Stream<S> source, {bool? cancelOnError, Function? onError, Function? onDone, void Function(T)? onValue})` | Connects a **Stream** to a [Signal](/types/signal).

```dart
final counter = signal(0);
final c = connect(counter);

final s1 = Stream.value(1);
final s2 = Stream.value(2);

c.from(s1).from(s2);

c.dispose();
``` |
| **<<** | `method` | `Connect<T, S> <<(Stream<S> source)` | Synonym for <code>from(Stream<T> source)</code> |
| **dispose** | `method` | `void dispose()` | Cancels all subscriptions. |

---
### function `connect`

The idea for <code>connect</code> comes from Anguar Signals with RxJS:

<iframe width="560" height="315" src="https://www.youtube.com/embed/R7-KdADEq0A?si=kK8XasbBedE3sPrR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Start with a signal and then use the <code>connect</code> method to create a connector.
Streams will feed Signal value.

```dart
final s = signal(0);
final c = connect(s);
```

### to

Add streams to the connector.

```dart
final s = signal(0);
final c = connect(s);

final s1 = Stream.value(1);
final s2 = Stream.value(2);

c.from(s1).from(s2); // These can be chained
```

### dispose

Cancel all subscriptions.

```dart
final s = signal(0);
final c = connect(s);

final s1 = Stream.value(1);
final s2 = Stream.value(2);

c.from(s1).from(s2);
// or
c << s1 << s2

c.dispose(); // This will cancel all subscriptions
```

**Signature**:
```dart
Connect<T, S> connect(Signal<T> signal, [Stream<S>? stream])
```


---
### class `AsyncState`

A sealed union representing the lifecycle states of an asynchronous operation.

<code>AsyncState<T></code> is commonly wrapped by <code>AsyncSignal</code> or returned by asynchronous
computed signals (<code>computedAsync</code>, <code>computedFrom</code>) to model loading, success (data),
and error outcomes.

### State Hierarchy
The states are modeled as a robust hierarchy of immutable types:
- [AsyncLoading](/types/asyncloading): Pure loading state with no pre-existing data.
- [AsyncData](/types/asyncdata): Success state holding a resolved value of type <code>T</code>.
  - [AsyncDataRefreshing](/types/asyncdatarefreshing): Refreshing in the background (holding historical data).
  - [AsyncDataReloading](/types/asyncdatareloading): Reloading (holding historical data).
- [AsyncError](/types/asyncerror): Failure state holding an error and optional stack trace.
  - [AsyncErrorRefreshing](/types/asyncerrorrefreshing): Refreshing in the background (holding historical error).
  - [AsyncErrorReloading](/types/asyncerrorreloading): Reloading (holding historical error).

### Pattern Matching & Switch Expressions
Standard Dart switch expressions provide type-safe branching across all states:

> [!IMPORTANT]
> **Branch Matching Order & Existing Value Preservation:**
> Since reloading and refreshing states (e.g., <code>AsyncDataRefreshing</code>, <code>AsyncDataReloading</code>) implement both <code>AsyncData</code> and <code>AsyncLoading</code>, matching on <code>AsyncLoading</code> **first** will prematurely swallow existing data!
> Always place <code>AsyncData</code> and <code>AsyncError</code> branches **before** <code>AsyncLoading</code> to ensure pre-existing data or error states are successfully rendered during refreshes:

```dart
final value = switch (state) {
    AsyncDataRefreshing<int> r => 'Refreshing with value: ${r.value}',
    AsyncDataReloading<int> r => 'Reloading with value: ${r.value}',
    AsyncData<int> data => 'Stable value: ${data.value}',
    AsyncErrorRefreshing<int> r => 'Refreshing error: ${r.error}',
    AsyncErrorReloading<int> r => 'Reloading error: ${r.error}',
    AsyncError<int> error => 'Stable error: ${error.error}',
    AsyncLoading<int>() => 'Pure Loading State (no prior data)',
};
```

### Standard Branching Methods (<code>map</code> and <code>maybeMap</code>)
If you prefer standard callbacks over switch expressions, use <code>map</code> or <code>maybeMap</code>:
```dart
state.map(
  data: (value) => 'Value: $value',
  error: (error, stackTrace) => 'Error: $error',
  loading: () => 'Loading...',
);
```


#### Members of `AsyncState`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncState** | `constructor` | `AsyncState()` |  |
| **AsyncState.dataReloading** | `constructor` | `AsyncState.dataReloading(T data)` | Create a state with a value that is reloading |
| **AsyncState.dataRefreshing** | `constructor` | `AsyncState.dataRefreshing(T data)` | Create a state with a value that is refreshing |
| **AsyncState.data** | `constructor` | `AsyncState.data(T data)` | Create a state with a value |
| **AsyncState.errorReloading** | `constructor` | `AsyncState.errorReloading(Object error, [StackTrace? stackTrace])` | Create a state with an error that is reloading |
| **AsyncState.errorRefreshing** | `constructor` | `AsyncState.errorRefreshing(Object error, [StackTrace? stackTrace])` | Create a state with an error that is refreshing |
| **AsyncState.error** | `constructor` | `AsyncState.error(Object error, [StackTrace? stackTrace])` | Create a state with an error |
| **AsyncState.loading** | `constructor` | `AsyncState.loading()` | Create a loading state |
| **hasValue** | `method` | `bool hasValue` | Returns true if the state has a value |
| **hasError** | `method` | `bool hasError` | Returns true if the state has an error |
| **isLoading** | `method` | `bool isLoading` | Check if the state is a loading state |
| **isRefreshing** | `method` | `bool isRefreshing` | Returns true if the state is refreshing with a loading flag,
 has a value or error and is not the loading state |
| **isReloading** | `method` | `bool isReloading` | Returns true if the state is reloading with having a value or error,
and is the loading state |
| **requireValue** | `method` | `T requireValue` | Force unwrap the value of the state.

This will throw an error if the state does not have a value. |
| **value** | `method` | `T? value` | Returns the value of the state. |
| **error** | `method` | `Object? error` | Returns the error of the state. |
| **stackTrace** | `method` | `StackTrace? stackTrace` | Returns the stack trace of the state. |
| **map** | `method` | `E map({required AsyncDataBuilder<E, T> data, required AsyncErrorBuilder<E> error, required AsyncStateBuilder<E> loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing})` | Map the state to a value.

```dart
final signal = StreamSignal<int>();
signal.value.map(
 data: (value) => 'Value: $value',
 error: (error, stackTrace) => 'Error: $error',
 loading: () => 'Loading...',
);
```

The error <code>Function</code> below can be one of two types:
- (dynamic) -> FutureOr
- (dynamic, StackTrace) -> FutureOr |
| **maybeMap** | `method` | `E maybeMap({AsyncDataBuilder<E, T>? data, AsyncErrorBuilder<E>? error, AsyncStateBuilder<E>? loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing, required AsyncStateBuilder<E> orElse})` | Map the state to a value with optional or else.

```dart
final signal = StreamSignal<int>();
signal.value.maybeMap(
 data: (value) => 'Value: $value',
 orElse: () => 'Loading...',
);
```

The error <code>Function</code> below can be one of two types:
- (dynamic) -> FutureOr
- (dynamic, StackTrace) -> FutureOr |
| **==** | `method` | `bool ==(covariant AsyncState<T> other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `AsyncDataReloading`

A loading state with a value. Signals the query conditions that led to the data
has changed and is being reloaded.


#### Members of `AsyncDataReloading`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncDataReloading** | `constructor` | `AsyncDataReloading(super.data)` | Create a state with a value that is reloading |
| **isLoading** | `method` | `bool isLoading` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |

---
### class `AsyncDataRefreshing`

A loading state with a value. Signals the query conditions that led to the data
has remained the same and is being refreshed


#### Members of `AsyncDataRefreshing`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncDataRefreshing** | `constructor` | `AsyncDataRefreshing(super.data)` | Create a state with a value that is refreshing |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |

---
### class `AsyncData`

State for an [AsyncState](/types/asyncstate) with a value


#### Members of `AsyncData`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncData** | `constructor` | `AsyncData(T data)` | State for an [AsyncState](/types/asyncstate) with a value |
| **hasValue** | `method` | `bool hasValue` |  |
| **hasError** | `method` | `bool hasError` |  |
| **value** | `field` | `T value` |  |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **requireValue** | `method` | `T requireValue` |  |
| **error** | `method` | `Object? error` |  |
| **stackTrace** | `method` | `StackTrace? stackTrace` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `AsyncErrorReloading`

A loading state with an error. Signal the query conditions that led to the error
has changed and is being reloaded.


#### Members of `AsyncErrorReloading`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncErrorReloading** | `constructor` | `AsyncErrorReloading(super.error, super.stackTrace)` | Create a state with an error that is reloading |
| **isLoading** | `method` | `bool isLoading` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |

---
### class `AsyncErrorRefreshing`

A loading state with an error. Signal the query conditions that led to the error
has remained the same and is being refreshed.


#### Members of `AsyncErrorRefreshing`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncErrorRefreshing** | `constructor` | `AsyncErrorRefreshing(super.error, super.stackTrace)` | Create a state with an error that is refreshing |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |

---
### class `AsyncError`

State for an [AsyncState](/types/asyncstate) with an error


#### Members of `AsyncError`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncError** | `constructor` | `AsyncError(this.error, this.stackTrace)` | State for an [AsyncState](/types/asyncstate) with an error |
| **hasValue** | `method` | `bool hasValue` |  |
| **hasError** | `method` | `bool hasError` |  |
| **value** | `method` | `T? value` |  |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **requireValue** | `method` | `T requireValue` |  |
| **error** | `field` | `Object error` |  |
| **stackTrace** | `field` | `StackTrace stackTrace` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `AsyncLoading`

State for an [AsyncState](/types/asyncstate) with a loading state


#### Members of `AsyncLoading`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncLoading** | `constructor` | `AsyncLoading()` | State for an [AsyncState](/types/asyncstate) with a loading state |
| **hasValue** | `method` | `bool hasValue` |  |
| **hasError** | `method` | `bool hasError` |  |
| **value** | `method` | `T? value` |  |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **requireValue** | `method` | `T requireValue` |  |
| **error** | `method` | `Object? error` |  |
| **stackTrace** | `method` | `StackTrace? stackTrace` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `AsyncSignal`

A highly powerful [Signal](/types/signal) specifically designed for manual, imperative asynchronous state management.

Unlike declarative reactive signals like [futureSignal](/types/futuresignal) or [streamSignal](/types/streamsignal) (which automatically wrap and listen
to an existing <code>Future</code> or <code>Stream</code>), <code>AsyncSignal<T></code> gives you full manual/imperative control over pushing
async states ([AsyncState.loading](/types/asyncstate#loading), [AsyncState.data](/types/asyncstate#data), and [AsyncState.error](/types/asyncstate#error)) into the reactive graph.

This is the perfect state primitive for building custom repositories, handling manual user action triggers
(e.g., submitting a registration form, calling an API on button click), or bridging low-level callback-based APIs
into reactive states.

### 1. Imperative State Mutations
You can update the state of the signal directly using specialized mutation helpers:
- <code>setLoading()</code> puts the signal into a clean <code>AsyncLoading</code> state.
- <code>setValue(T data)</code> pushes a new <code>AsyncData</code> state containing the data.
- <code>setError(Object error, [StackTrace? stackTrace])</code> transitions the signal to an <code>AsyncError</code> state.

```dart
final authState = asyncSignal<User>(AsyncState.loading());

Future<void> login(String email, String password) async {
  try {
    authState.setLoading(); // Set UI to loading state
    final user = await authApi.signIn(email, password);
    authState.setValue(user); // Push success data
  } catch (err, stack) {
    authState.setError(err, stack); // Push error state
  }
}
```

### 2. Awaiting Async Completion via <code>.future</code>
An outstanding capability of <code>AsyncSignal</code> is its built-in <code>.future</code> getter. Any part of your code can await
this future. It returns a standard <code>Future<T></code> that resolves when the signal next receives a data value,
or throws if the signal next receives an error state.

```dart
final loginSignal = asyncSignal<User>(AsyncState.loading());

// Task A: Start background operation
Future.delayed(Duration(seconds: 2), () {
  loginSignal.setValue(User(name: 'Charlie'));
});

// Task B: Wait for the signal to resolve!
final user = await loginSignal.future; // Suspends execution until Task A completes!
print(user.name); // 'Charlie'
```

### 3. Rendering in Flutter using <code>Watch</code> and <code>AsyncState</code> Pattern matching
In your Flutter widgets, you can seamlessly watch the signal and use Dart's native pattern matching
on [AsyncState](/types/asyncstate) to render different widgets corresponding to the current asynchronous lifecycle:

```dart
Widget build(BuildContext context) {
  final state = authState.watch(context);

  return state.map(
    data: (user) => HomeScreen(user: user),
    error: (error, stackTrace) => ErrorWidget(error),
    loading: () => const CircularProgressIndicator(),
  );
}
```

### 4. Bridging callback/event-driven systems via <code>EventSink</code>
<code>AsyncSignal</code> implements Dart's standard **EventSink** interface. This allows it to act directly as an event sink
for streams, websockets, or callback listeners:

```dart
final messageLog = asyncSignal<String>(AsyncState.loading());
final chatStream = webSocket.stream.map((event) => event.toString());

// Automatically push all incoming messages and errors from the stream into the signal:
chatStream.listen(
  (msg) => messageLog.add(msg),
  onError: (err) => messageLog.addError(err),
  onDone: () => messageLog.close(),
);
```

<Info>
  Favor <code>AsyncSignal</code> when you need manual, callback-driven, or button-press-triggered state mutations.
  For auto-triggering, declarative, or read-only asynchronous data dependencies (like pulling data when an ID changes),
  favor <a href="/types/futuresignal">futureSignal</a> or <a href="/types/computedasync">computedAsync</a> instead.
</Info>


#### Members of `AsyncSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncSignal** | `constructor` | `AsyncSignal(super.value, {super.options})` | A [Signal](/types/signal) that stores value in [AsyncState](/types/asyncstate) |
| **future** | `method` | `Future<T> future` | The future of the signal completer |
| **isCompleted** | `method` | `bool isCompleted` | Returns true if the signal is completed an error or data |
| **setError** | `method` | `void setError(Object error, [StackTrace? stackTrace])` | Set the error with optional stackTrace to [AsyncError](/types/asyncerror) |
| **setValue** | `method` | `void setValue(T value)` | Set the value to [AsyncData](/types/asyncdata) |
| **setLoading** | `method` | `void setLoading([AsyncState<T>? state])` | Set the loading state to [AsyncLoading](/types/asyncloading) |
| **reset** | `method` | `void reset([AsyncState<T>? value])` | Reset the signal to the initial value |
| **init** | `method` | `void init()` | Initialize the signal |
| **reload** | `method` | `Future<void> reload()` | Reload the future |
| **refresh** | `method` | `Future<void> refresh()` | Refresh the future |
| **value** | `method` | `AsyncState<T> value` |  |
| **requireValue** | `method` | `T requireValue` | Returns the value of the signal |

---
### function `asyncSignal`

Helper function to create an [AsyncSignal](/types/asyncsignal) initialized with an [AsyncState](/types/asyncstate).

### Example
```dart
// Create an AsyncSignal initialized to a loading state
final counter = asyncSignal<int>(AsyncState.loading());

// Create an AsyncSignal initialized with initial data
final status = asyncSignal<String>(AsyncState.data('Active'));
```

**Signature**:
```dart
AsyncSignal<T> asyncSignal(AsyncState<T> value, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose})
```


---
### class `AsyncSignalOptions`

Configuration options for an [AsyncSignal](/types/asyncsignal).


#### Members of `AsyncSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | `field` | `T? initialValue` | The initial value of the async signal. |
| **dependencies** | `field` | `List<ReadonlySignal<dynamic>> dependencies` | The list of dependencies to watch/listen to. |
| **onDone** | `field` | `void Function()? onDone` | Optional function called when a stream completes. |
| **cancelOnError** | `field` | `bool? cancelOnError` | Whether to cancel the stream subscription on error. |
| **lazy** | `field` | `bool lazy` | Whether the execution is lazy. |
| **AsyncSignalOptions** | `constructor` | `AsyncSignalOptions({this.initialValue, this.dependencies = const [], this.onDone, this.cancelOnError, this.lazy = true, super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [AsyncSignalOptions](/types/asyncsignaloptions) instance. |
| **copyWith** | `method` | `AsyncSignalOptions<T> copyWith({T? initialValue, List<ReadonlySignal<dynamic>>? dependencies, void Function()? onDone, bool? cancelOnError, bool? lazy, bool? autoDispose, String? name, void Function()? watched, void Function()? unwatched})` | Creates a copy of this options with custom overrides. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `StreamSignal`

Stream signals wrap a standard asynchronous **Stream** and bridge it into the reactive state framework, exposing its emissions as a reactive [AsyncState](/types/asyncstate).

You can construct a stream signal via the helper function [streamSignal](/types/streamsignal) or by calling the <code>.toSignal()</code> extension method on any standard **Stream**.

### 1. Basic Stream Binding
```dart
final s = streamSignal(() => countStream());
```

Or via the extension:
```dart
final s = countStream().toSignal();
```

### 2. Consuming stream emissions reactively
Reading <code>.value</code> on a [StreamSignal](/types/streamsignal) returns an [AsyncState](/types/asyncstate) object:

```dart
effect(() {
  s.value.map(
    data: (val) => print('Stream emitted: $val'),
    error: (err, stack) => print('Stream encountered error: $err'),
    loading: () => print('Waiting for first stream emission...'),
  );
});
```

### 3. Subscription Lifecycle and Manual Control
A stream signal automatically manages the underlying **StreamSubscription**. It listens when the signal has active subscribers and automatically cleans up/cancels when disposed to prevent memory leaks.

You can also manually control the subscription state:
- **<code>pause()</code>**: Pauses the underlying stream subscription.
- **<code>resume()</code>**: Resumes a paused subscription.
- **<code>cancel()</code>**: Cancels the subscription and marks the stream signal as done.
- **<code>isDone</code>**: Returns whether the stream has finished emitting or has been cancelled.

```dart
final s = streamSignal(() => countStream());
s.pause(); // Temporarily halt stream values
```

### 4. Reactive Dependencies
Any reactive signals read synchronously inside the stream callback act as dependencies. When they mutate, the stream signal automatically cancels the current stream subscription, recreates a new stream using the updated values, and starts listening.

```dart
final query = signal('flutter');
final s = streamSignal(() {
  // Re-subscribes to a new database query stream every time the query changes!
  return db.watchItems(query.value);
});
```


#### Members of `StreamSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **StreamSignal** | `constructor` | `StreamSignal(Stream<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead') bool? cancelOnError, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead') void Function()? onDone, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})` | Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {
    yield 1;
};
final s = streamSignal(() => stream);
```

### toSignal()

```dart
final stream = () async* {
    yield 1;
};
final s = stream.toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the stream if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the stream to its initial state to recall on the next evaluation.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reset();
```

## .refresh()

Refresh the stream value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the stream value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the stream will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = streamSignal(() async* {
    final value = count();
    yield value;
});

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>streamSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = streamSignal(
    () async* {
        final value = count();
        yield value;
    },
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
``` |
| **isDone** | `method` | `bool isDone` | Check if the signal is done |
| **cancelOnError** | `field` | `bool? cancelOnError` | Cancel the subscription on error |
| **dependencies** | `field` | `List<ReadonlySignal<dynamic>> dependencies` | List of dependencies to recompute the stream |
| **last** | `method` | `Future<T> last` | First value of the stream |
| **first** | `method` | `Future<T> first` | Last value of the stream |
| **execute** | `method` | `Future<void> execute(Stream<T> src)` | Execute the stream |
| **isPaused** | `method` | `bool isPaused` | Check if the subscription is paused |
| **pause** | `method` | `void pause([Future<void>? resume])` | Pause the subscription |
| **resume** | `method` | `void resume()` | Resume the subscription |
| **cancel** | `method` | `Future<void> cancel()` | Cancel the subscription |
| **reload** | `method` | `Future<void> reload()` |  |
| **refresh** | `method` | `Future<void> refresh()` |  |
| **reset** | `method` | `void reset([AsyncState<T>? value])` |  |
| **dispose** | `method` | `void dispose()` |  |
| **value** | `method` | `AsyncState<T> value` |  |
| **setError** | `method` | `void setError(Object error, [StackTrace? stackTrace])` |  |

---
### function `streamSignal`

Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {
    yield 1;
};
final s = streamSignal(() => stream);
```

### toSignal()

```dart
final stream = () async* {
    yield 1;
};
final s = stream.toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the stream if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the stream to its initial state to recall on the next evaluation.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reset();
```

## .refresh()

Refresh the stream value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the stream value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the stream will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = streamSignal(() async* {
    final value = count();
    yield value;
});

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>streamSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = streamSignal(
    () async* {
        final value = count();
        yield value;
    },
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
```

**Signature**:
```dart
StreamSignal<T> streamSignal(Stream<T> Function() callback, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead') void Function()? onDone, @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead') bool? cancelOnError, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```


---
### class `FutureSignal`

Future signals wrap a standard asynchronous **Future** and bridge it into the reactive state framework, exposing its lifecycle and value as a reactive [AsyncState](/types/asyncstate).

You can construct a future signal via the helper function [futureSignal](/types/futuresignal) or by calling the <code>.toSignal()</code> extension method on any standard **Future**.

### 1. Basic Async Fetching
```dart
final s = futureSignal(() async {
  final data = await fetchUserData(123);
  return data;
});
```

Or via the extension:
```dart
final s = fetchUserData(123).toSignal();
```

### 2. Consuming and Pattern Matching <code>AsyncState</code>
Reading <code>.value</code> on a [FutureSignal](/types/futuresignal) returns an [AsyncState](/types/asyncstate) object. You can safely pattern-match or map this state to reactively build your user interface or perform side-effects:

```dart
effect(() {
  s.value.map(
    data: (user) => print('User fetched successfully: ${user.name}'),
    error: (err, stack) => print('Failed to fetch user: $err'),
    loading: () => print('Loading user...'),
  );
});
```

### 3. Reset, Refresh, and Reload
- **<code>reset()</code>**: Reverts the signal back to its initial/loading state.
- **<code>refresh()</code>**: Triggers a new evaluation of the future while maintaining the current data in the meantime (sets <code>isLoading</code> to true but does not discard existing data/error).
- **<code>reload()</code>**: Discards current state, sets the signal to <code>AsyncLoading</code>, and executes a fresh evaluation of the future.

```dart
final s = futureSignal(() => fetchConfig());
s.refresh(); // Triggers reload under the hood
```

### 4. Reactive Dependencies
Any reactive signals read *synchronously* inside the future callback are registered as dependencies. When they mutate, the future signal automatically invalidates and schedules a fresh fetch.

```dart
final userId = signal(123);
final userProfile = futureSignal(() async {
  // Subscribes to userId! Mutating userId automatically re-runs this future.
  final currentId = userId.value;
  return fetchUserProfile(currentId);
});
```

<Info>
  If you need to track dependencies across an asynchronous gap (i.e. reading a signal's value <em>after</em> an <code>await</code>), pass them explicitly in the <code>dependencies</code> list inside <code>AsyncSignalOptions</code> or the constructor to guarantee they are properly subscribed.
</Info>


#### Members of `FutureSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FutureSignal** | `constructor` | `FutureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})` | Future signals can be created by extension or method.

### futureSignal

```dart
final s = futureSignal(() async => 1);
```

### toSignal()

```dart
final s = Future(() => 1).toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the future if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final s = futureSignal(() => Future(() => 1));
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(() => Future(() => 1));
s.reset();
```

## .refresh()

Refresh the future value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final s = futureSignal(() => Future(() => 1));
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the future value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final s = futureSignal(() => Future(() => 1));
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the future will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = futureSignal(() async => count.value);

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>futureSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = futureSignal(
    () async => count.value,
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
``` |
| **dependencies** | `field` | `List<ReadonlySignal<dynamic>> dependencies` | List of dependencies to recompute the future |
| **dispose** | `method` | `void dispose()` |  |
| **reset** | `method` | `void reset([AsyncState<T>? value])` |  |
| **init** | `method` | `void init()` |  |
| **value** | `method` | `AsyncState<T> value` |  |
| **reload** | `method` | `Future<void> reload()` |  |
| **refresh** | `method` | `Future<void> refresh()` |  |

---
### function `futureSignal`

Future signals can be created by extension or method.

### futureSignal

```dart
final s = futureSignal(() async => 1);
```

### toSignal()

```dart
final s = Future(() => 1).toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the future if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final s = futureSignal(() => Future(() => 1));
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(() => Future(() => 1));
s.reset();
```

## .refresh()

Refresh the future value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final s = futureSignal(() => Future(() => 1));
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the future value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final s = futureSignal(() => Future(() => 1));
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the future will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = futureSignal(() async => count.value);

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>futureSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = futureSignal(
    () async => count.value,
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
```

**Signature**:
```dart
FutureSignal<T> futureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```


---
### function `computedFrom`

Create an asynchronous computed signal by explicitly declaring its dependencies.

<code>computedFrom</code> takes a list of **signals** and a **callback** function to compute
the value of the signal every time one of the declared **signals** changes.

Unlike [computedAsync](/types/computedasync), which tracks dependencies implicitly, <code>computedFrom</code> is
immune to the **Async Gap Gotcha** because all tracking is declared upfront.

### Why use <code>computedFrom</code>?
When writing asynchronous code, Dart yields control at every <code>await</code> keyword.
Implicit tracking (in [computedAsync](/types/computedasync) or [computed](/types/computed)) cannot track reads that happen
*after* an asynchronous gap because the active reactive reader context is lost.

<code>computedFrom</code> solves this by:
1. Subscribing to the list of input **signals** synchronously.
2. Reading their latest values synchronously.
3. Passing those resolved values into your callback as an ordered list of arguments.

### Example: Fetching user details when an ID signal changes

```dart
final userId = signal(123);

// The callback receives the current values of the declared signals
final userProfile = computedFrom([userId], (args) async {
  final currentId = args.first; // Type-safe list of dependencies
  return fetchUserProfileFromServer(currentId);
});

// userProfile is a FutureSignal<UserProfile> which can be pattern-matched
effect(() {
  userProfile.value.map(
    data: (profile) => print('Loaded profile: ${profile.name}'),
    error: (err, stack) => print('Error: $err'),
    loading: () => print('Fetching profile...'),
  );
});

// Updating userId automatically triggers a new asynchronous fetch
userId.value = 456;
```

**Signature**:
```dart
FutureSignal<T> computedFrom(List<ReadonlySignal<A>> signals, Future<T> Function(List<A> args) fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```


---
### function `computedAsync`

Create an asynchronous computed signal with implicit dependency tracking.

<code>computedAsync</code> takes an asynchronous **callback** function to compute the value
of the signal. Any signal read *synchronously* inside the callback is automatically
tracked as a dependency, and the computed signal is re-evaluated when any of those
dependencies change.

### ⚠️ The Async Gap Gotcha
Because Dart yields execution at every <code>await</code> expression, the reactive context that
automatically tracks reads is lost after an asynchronous gap.

**Rule:** All signal values MUST be read synchronously *before* the first <code>await</code> statement.

#### ❌ Incorrect Pattern (Signal read after await is NOT tracked):
```dart
final movie = computedAsync(() async {
  await Future.delayed(Duration(milliseconds: 100));
  // BUG: movieId is read AFTER an async gap.
  // Changes to movieId will NOT re-evaluate this computedAsync!
  return fetchMovie(movieId.value);
});
```

####  Correct Pattern (Read dependencies synchronously first):
```dart
final movie = computedAsync(() async {
  // Capture all dependency values synchronously at the start!
  final currentId = movieId.value;

  await Future.delayed(Duration(milliseconds: 100));
  // Use the captured local variable after the async gap
  return fetchMovie(currentId);
});
```

### Advanced Example: Search Query with Debouncing

```dart
final searchQuery = signal('');

final searchResults = computedAsync(() async {
  // Capture dependency synchronously
  final query = searchQuery.value;

  if (query.isEmpty) return <SearchResult>[];

  // Debounce: Wait 300ms before making the API request
  await Future.delayed(Duration(milliseconds: 300));

  return performSearchApiCall(query);
});
```

**Signature**:
```dart
FutureSignal<T> computedAsync(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```


---
### extension `SignalObjectUtils`

Connivent methods for signal values


#### Members of `SignalObjectUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<T> $` | Convert an existing Object to [Signal](/types/signal) |

---
### extension `SignalFutureUtils`

Extension on future to provide helpful methods for signals


#### Members of `SignalFutureUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toFutureSignal** | `method` | `FutureSignal<T> toFutureSignal({Duration? timeout, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], AsyncSignalOptions<T>? options})` | Convert an existing future to [FutureSignal](/types/futuresignal)

```dart
import 'package:signals/signals.dart';

final future = Future(() => 1);
final signal = future.toSignal();
``` |

---
### extension `SignalStreamUtils`

Extension on **Stream** to provide convenient utilities to convert streams into reactive signals.

```dart
import 'package:signals_core/signals_core.dart';

final myStream = Stream.periodic(Duration(seconds: 1), (x) => x).take(5);
final mySignal = myStream.toStreamSignal();
```


#### Members of `SignalStreamUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toStreamSignal** | `method` | `StreamSignal<T> toStreamSignal({bool? cancelOnError, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, AsyncSignalOptions<T>? options})` | Convert a stream to a signal

```dart
import 'package:signals/signals.dart';

Stream<int> createStream() async* {
    yield 1;
    yield 2;
    yield 3;
}
final stream = createStream();
final signal = stream.toSignal();
```

For returning a signal with the value that can be accessed sync use
stream.toSyncSignal instead. |
| **toSyncSignal** | `method` | `ReadonlySignal<T> toSyncSignal(T initialData)` | Convert a **Stream** to a synchronous [ReadonlySignal](/types/readonlysignal) and provide an initial value.

This is different from <code>toStreamSignal()</code> because it directly feeds the stream's values
into a standard <code>Signal<T></code>, allowing you to read the bare, synchronous values directly
instead of wrapping them in an [AsyncState](/types/asyncstate).

```dart
import 'package:signals_core/signals_core.dart';

final stream = Stream.value(42);
final syncSignal = stream.toSyncSignal(0);
print(syncSignal.value); // 0 (initially)
// After the stream emits:
// print(syncSignal.value); // 42
``` |

---
### extension `ReadonlySignalUtils`

Utility extensions on [ReadonlySignal](/types/readonlysignal) to bridge reactive programming with asynchronous streams and select sub-states.


#### Members of `ReadonlySignalUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toStream** | `method` | `Stream<T> toStream()` | Convert a signal to a **Stream** to be consumed as
a read only stream. |
| **select** | `method` | `Computed<R> select(R Function(ReadonlySignal<T>) selector, [ComputedOptions<R>? options])` | Select a sub-state value from this signal and return a computed signal that only notifies when that specific sub-state changes.

This is highly useful for nesting or destructuring complex objects or maps without triggering downstream updates on changes to unrelated fields.

```dart
import 'package:signals_core/signals_core.dart';

final user = signal({'name': 'John', 'age': 30});
final name = user.select((val) => val()['name'] as String);

effect(() => print('Name changed: ${name.value}'));

// Unrelated field update: does NOT trigger the name effect!
user.value = {'name': 'John', 'age': 31};

// Related field update: triggers the name effect!
user.value = {'name': 'Jane', 'age': 31};
``` |

---
### extension `WriteableSignalUtils`

Utility extensions on [Signal](/types/signal) providing functional programming wrappers like React-style hooks destructuring.


#### Members of `WriteableSignalUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **hooks** | `method` | `(T Function(), void Function(T)) hooks` | Easy destructure to get and set the value

```dart
final counter = signal(0);
...
final (getCount, setCount) = counter.hooks;
``` |

---
### extension `AsyncSignalState`

Extensions for [Signal<AsyncState<T>>]


#### Members of `AsyncSignalState`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **selectData** | `method` | `Computed<AsyncState<R>> selectData(R Function(T data) selector)` | Select from data when available, preserving async state |

---
### extension `BoolSignalExtension`

Helper extensions for [ReadonlySignal<bool>](/types/readonlysignal), enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations.

```dart
import 'package:signals_core/signals_core.dart';

final a = true.$;
final b = false.$;
final andResult = a & b.value; // false
final orResult = a | b.value; // true
```


#### Members of `BoolSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **&** | `method` | `bool &(bool other)` | The logical conjunction ("and") of this and **other**.

Returns <code>true</code> if both this and **other** are <code>true</code>, and <code>false</code> otherwise. |
| **|** | `method` | `bool |(bool other)` | The logical disjunction ("inclusive or") of this and **other**.

Returns <code>true</code> if either this or **other** is <code>true</code>, and <code>false</code> otherwise. |
| **^** | `method` | `bool ^(bool other)` | The logical exclusive disjunction ("exclusive or") of this and **other**.

Returns whether this and **other** are neither both <code>true</code> nor both <code>false</code>. |

---
### extension `SignalBoolExtensions`

Utility extension on **bool** to easily lift a boolean into a reactive [Signal](/types/signal).


#### Members of `SignalBoolExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<bool> $` | Lift a primitive **bool** into a reactive [Signal<bool>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final isEnabled = true.$;
print(isEnabled.value); // true
``` |

---
### extension `ComparableSignalExtension`

Helper extensions for [ReadonlySignal<Comparable<T>>]


#### Members of `ComparableSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **compareTo** | `method` | `int compareTo(T other)` | Compares this object to another object.

Returns a value like a **Comparator** when comparing <code>this</code> to **other**.
That is, it returns a negative integer if <code>this</code> is ordered before **other**,
a positive integer if <code>this</code> is ordered after **other**,
and zero if <code>this</code> and **other** are ordered together.

The **other** argument must be a value that is comparable to this object. |

---
### extension `SignalComparableExtensions`

Extensions for **Comparable<T>**


#### Members of `SignalComparableExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Comparable<T>> $` | Return a signal from a Comparable value |

---
### extension `DoubleSignalExtension`

Helper extensions for [ReadonlySignal<double>](/types/readonlysignal), enabling direct reactive arithmetic and rounding operations on double signals.

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 2.5.$;
final rounded = doubleSignal.round(); // 3
final negated = -doubleSignal; // -2.5
```


#### Members of `DoubleSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **remainder** | `method` | `double remainder(num other)` | Returns the remainder of this value divided by **other**. |
| **+** | `method` | `double +(num other)` | Returns the sum of this value and **other**. |
| **-** | `method` | `double -(num other)` | Returns the difference of this value and **other**. |
| ***** | `method` | `double *(num other)` | Returns the product of this value and **other**. |
| **%** | `method` | `double %(num other)` | Returns the modulo of this value and **other**. |
| **/** | `method` | `double /(num other)` | Returns the division of this value and **other**. |
| **~/** | `method` | `int ~/(num other)` | Returns the truncating division of this value and **other**. |
| **-** | `method` | `double -()` | Returns the negation of this value. |
| **abs** | `method` | `double abs()` | Returns the absolute value of this value. |
| **sign** | `method` | `double sign` | The sign of the double's numerical value.

Returns -1.0 if the value is less than zero,
+1.0 if the value is greater than zero,
and the value itself if it is -0.0, 0.0 or NaN. |
| **round** | `method` | `int round()` | Returns the integer closest to this number.

Rounds away from zero when there is no closest integer:
 <code>(3.5).round() == 4</code> and <code>(-3.5).round() == -4</code>.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(3.0.round()); // 3
print(3.25.round()); // 3
print(3.5.round()); // 4
print(3.75.round()); // 4
print((-3.5).round()); // -4
``` |
| **floor** | `method` | `int floor()` | Returns the greatest integer no greater than this number.

Rounds the number towards negative infinity.

Throws an **UnsupportedError** if this number is not finite
(NaN or infinity).
```dart
print(1.99999.floor()); // 1
print(2.0.floor()); // 2
print(2.99999.floor()); // 2
print((-1.99999).floor()); // -2
print((-2.0).floor()); // -2
print((-2.00001).floor()); // -3
``` |
| **ceil** | `method` | `int ceil()` | Returns the least integer that is not smaller than this number.

Rounds the number towards infinity.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(1.99999.ceil()); // 2
print(2.0.ceil()); // 2
print(2.00001.ceil()); // 3
print((-1.99999).ceil()); // -1
print((-2.0).ceil()); // -2
print((-2.00001).ceil()); // -2
``` |
| **truncate** | `method` | `int truncate()` | Returns the integer obtained by discarding any fractional
part of this number.

Rounds the number towards zero.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(2.00001.truncate()); // 2
print(1.99999.truncate()); // 1
print(0.5.truncate()); // 0
print((-0.5).truncate()); // 0
print((-1.5).truncate()); // -1
print((-2.5).truncate()); // -2
``` |
| **roundToDouble** | `method` | `double roundToDouble()` | Returns the integer double value closest to <code>this</code>.

Rounds away from zero when there is no closest integer:
 <code>(3.5).roundToDouble() == 4</code> and <code>(-3.5).roundToDouble() == -4</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>,
and <code>-0.0</code> is therefore considered closer to negative numbers than <code>0.0</code>.
This means that for a value <code>d</code> in the range <code>-0.5 < d < 0.0</code>,
the result is <code>-0.0</code>.
```dart
print(3.0.roundToDouble()); // 3.0
print(3.25.roundToDouble()); // 3.0
print(3.5.roundToDouble()); // 4.0
print(3.75.roundToDouble()); // 4.0
print((-3.5).roundToDouble()); // -4.0
``` |
| **floorToDouble** | `method` | `double floorToDouble()` | Returns the greatest integer double value no greater than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>0.0 < d < 1.0</code> will return <code>0.0</code>.
```dart
print(1.99999.floorToDouble()); // 1.0
print(2.0.floorToDouble()); // 2.0
print(2.99999.floorToDouble()); // 2.0
print((-1.99999).floorToDouble()); // -2.0
print((-2.0).floorToDouble()); // -2.0
print((-2.00001).floorToDouble()); // -3.0
``` |
| **ceilToDouble** | `method` | `double ceilToDouble()` | Returns the least integer double value no smaller than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>.
```dart
print(1.99999.ceilToDouble()); // 2.0
print(2.0.ceilToDouble()); // 2.0
print(2.00001.ceilToDouble()); // 3.0
print((-1.99999).ceilToDouble()); // -1.0
print((-2.0).ceilToDouble()); // -2.0
print((-2.00001).ceilToDouble()); // -2.0
``` |
| **truncateToDouble** | `method` | `double truncateToDouble()` | Returns the integer double value obtained by discarding any fractional
digits from <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>, and
in the range <code>0.0 < d < 1.0</code> it will return 0.0.
```dart
print(2.5.truncateToDouble()); // 2.0
print(2.00001.truncateToDouble()); // 2.0
print(1.99999.truncateToDouble()); // 1.0
print(0.5.truncateToDouble()); // 0.0
print((-0.5).truncateToDouble()); // -0.0
print((-1.5).truncateToDouble()); // -1.0
print((-2.5).truncateToDouble()); // -2.0
``` |

---
### extension `SignalDoubleExtensions`

Utility extension on **double** to easily lift a double into a reactive [Signal](/types/signal).


#### Members of `SignalDoubleExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<double> $` | Lift a primitive **double** into a reactive [Signal<double>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 3.14.$;
print(doubleSignal.value); // 3.14
``` |

---
### extension `IntSignalExtension`

Helper extensions for [ReadonlySignal<int>](/types/readonlysignal)


#### Members of `IntSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **&** | `method` | `int &(int other)` | Bit-wise and operator.

Treating both <code>this</code> and **other** as sufficiently large two's component
integers, the result is a number with only the bits set that are set in
both <code>this</code> and **other**

If both operands are negative, the result is negative, otherwise
the result is non-negative.
```dart
print((2 & 1).toRadixString(2)); // 0010 & 0001 -> 0000
print((3 & 1).toRadixString(2)); // 0011 & 0001 -> 0001
print((10 & 2).toRadixString(2)); // 1010 & 0010 -> 0010
``` |
| **|** | `method` | `int |(int other)` | Bit-wise or operator.

Treating both <code>this</code> and **other** as sufficiently large two's component
integers, the result is a number with the bits set that are set in either
of <code>this</code> and **other**

If both operands are non-negative, the result is non-negative,
otherwise the result is negative.

Example:
```dart
print((2 | 1).toRadixString(2)); // 0010 | 0001 -> 0011
print((3 | 1).toRadixString(2)); // 0011 | 0001 -> 0011
print((10 | 2).toRadixString(2)); // 1010 | 0010 -> 1010
``` |
| **^** | `method` | `int ^(int other)` | Bit-wise exclusive-or operator.

Treating both <code>this</code> and **other** as sufficiently large two's component
integers, the result is a number with the bits set that are set in one,
but not both, of <code>this</code> and **other**

If the operands have the same sign, the result is non-negative,
otherwise the result is negative.

Example:
```dart
print((2 ^ 1).toRadixString(2)); //  0010 ^ 0001 -> 0011
print((3 ^ 1).toRadixString(2)); //  0011 ^ 0001 -> 0010
print((10 ^ 2).toRadixString(2)); //  1010 ^ 0010 -> 1000
``` |
| **~** | `method` | `int ~()` | The bit-wise negate operator.

Treating <code>this</code> as a sufficiently large two's component integer,
the result is a number with the opposite bits set.

This maps any integer <code>x</code> to <code>-x - 1</code>. |
| **<<** | `method` | `int <<(int shiftAmount)` | Shift the bits of this integer to the left by **shiftAmount**.

Shifting to the left makes the number larger, effectively multiplying
the number by <code>pow(2, shiftAmount)</code>.

There is no limit on the size of the result. It may be relevant to
limit intermediate values by using the "and" operator with a suitable
mask.

It is an error if **shiftAmount** is negative.

Example:
```dart
print((3 << 1).toRadixString(2)); // 0011 -> 0110
print((9 << 2).toRadixString(2)); // 1001 -> 100100
print((10 << 3).toRadixString(2)); // 1010 -> 1010000
``` |
| **>>** | `method` | `int >>(int shiftAmount)` | Shift the bits of this integer to the right by **shiftAmount**.

Shifting to the right makes the number smaller and drops the least
significant bits, effectively doing an integer division by
<code>pow(2, shiftAmount)</code>.

It is an error if **shiftAmount** is negative.

Example:
```dart
print((3 >> 1).toRadixString(2)); // 0011 -> 0001
print((9 >> 2).toRadixString(2)); // 1001 -> 0010
print((10 >> 3).toRadixString(2)); // 1010 -> 0001
print((-6 >> 2).toRadixString); // 111...1010 -> 111...1110 == -2
print((-85 >> 3).toRadixString); // 111...10101011 -> 111...11110101 == -11
``` |
| **>>>** | `method` | `int >>>(int shiftAmount)` | Bitwise unsigned right shift by **shiftAmount** bits.

The least significant **shiftAmount** bits are dropped,
the remaining bits (if any) are shifted down,
and zero-bits are shifted in as the new most significant bits.

The **shiftAmount** must be non-negative.

Example:
```dart
print((3 >>> 1).toRadixString(2)); // 0011 -> 0001
print((9 >>> 2).toRadixString(2)); // 1001 -> 0010
print(((-9) >>> 2).toRadixString(2)); // 111...1011 -> 001...1110 (> 0)
``` |
| **modPow** | `method` | `int modPow(int exponent, int modulus)` | Returns this integer to the power of **exponent** modulo **modulus**.

The **exponent** must be non-negative and **modulus** must be
positive. |
| **modInverse** | `method` | `int modInverse(int modulus)` | Returns the modular multiplicative inverse of this integer
modulo **modulus**.

The **modulus** must be positive.

It is an error if no modular inverse exists. |
| **gcd** | `method` | `int gcd(int other)` | Returns the greatest common divisor of this integer and **other**.

If either number is non-zero, the result is the numerically greatest
integer dividing both <code>this</code> and <code>other</code>.

The greatest common divisor is independent of the order,
so <code>x.gcd(y)</code> is  always the same as <code>y.gcd(x)</code>.

For any integer <code>x</code>, <code>x.gcd(x)</code> is <code>x.abs()</code>.

If both <code>this</code> and <code>other</code> is zero, the result is also zero.

Example:
```dart
print(4.gcd(2)); // 2
print(8.gcd(4)); // 4
print(10.gcd(12)); // 2
print(10.gcd(0)); // 10
print((-2).gcd(-3)); // 1
``` |
| **isEven** | `method` | `bool isEven` | Returns true if and only if this integer is even. |
| **isOdd** | `method` | `bool isOdd` | Returns true if and only if this integer is odd. |
| **bitLength** | `method` | `int bitLength` | Returns the minimum number of bits required to store this integer.

The number of bits excludes the sign bit, which gives the natural length
for non-negative (unsigned) values.  Negative values are complemented to
return the bit position of the first bit that differs from the sign bit.

To find the number of bits needed to store the value as a signed value,
add one, i.e. use <code>x.bitLength + 1</code>.
```dart
x.bitLength == (-x-1).bitLength;

3.bitLength == 2;     // 00000011
2.bitLength == 2;     // 00000010
1.bitLength == 1;     // 00000001
0.bitLength == 0;     // 00000000
(-1).bitLength == 0;  // 11111111
(-2).bitLength == 1;  // 11111110
(-3).bitLength == 2;  // 11111101
(-4).bitLength == 2;  // 11111100
``` |
| **toUnsigned** | `method` | `int toUnsigned(int width)` | Returns the least significant **width** bits of this integer as a
non-negative number (i.e. unsigned representation).  The returned value has
zeros in all bit positions higher than **width**.
```dart
(-1).toUnsigned(5) == 31   // 11111111  ->  00011111
```
This operation can be used to simulate arithmetic from low level languages.
For example, to increment an 8 bit quantity:
```dart
q = (q + 1).toUnsigned(8);
```
<code>q</code> will count from <code>0</code> up to <code>255</code> and then wrap around to <code>0</code>.

If the input fits in **width** bits without truncation, the result is the
same as the input.  The minimum width needed to avoid truncation of <code>x</code> is
given by <code>x.bitLength</code>, i.e.
```dart
x == x.toUnsigned(x.bitLength);
``` |
| **toSigned** | `method` | `int toSigned(int width)` | Returns the least significant **width** bits of this integer, extending the
highest retained bit to the sign. This is the same as truncating the value
to fit in **width** bits using an signed 2-s complement representation. The
returned value has the same bit value in all positions higher than **width**.

```dart
                         //     V--sign bit-V
16.toSigned(5) == -16;   //  00010000 -> 11110000
239.toSigned(5) == 15;   //  11101111 -> 00001111
                         //     ^           ^
```
This operation can be used to simulate arithmetic from low level languages.
For example, to increment an 8 bit signed quantity:
```dart
q = (q + 1).toSigned(8);
```
<code>q</code> will count from <code>0</code> up to <code>127</code>, wrap to <code>-128</code> and count back up to
<code>127</code>.

If the input value fits in **width** bits without truncation, the result is
the same as the input.  The minimum width needed to avoid truncation of <code>x</code>
is <code>x.bitLength + 1</code>, i.e.
```dart
x == x.toSigned(x.bitLength + 1);
``` |
| **-** | `method` | `int -()` | Return the negative value of this integer.

The result of negating an integer always has the opposite sign, except
for zero, which is its own negation. |
| **abs** | `method` | `int abs()` | Returns the absolute value of this integer.

For any integer <code>value</code>,
the result is the same as <code>value < 0 ? -value : value</code>.

Integer overflow may cause the result of <code>-value</code> to stay negative. |
| **sign** | `method` | `int sign` | Returns the sign of this integer.

Returns 0 for zero, -1 for values less than zero and
+1 for values greater than zero. |
| **round** | `method` | `int round()` | Returns <code>this</code>. |
| **floor** | `method` | `int floor()` | Returns <code>this</code>. |
| **ceil** | `method` | `int ceil()` | Returns <code>this</code>. |
| **truncate** | `method` | `int truncate()` | Returns <code>this</code>. |
| **roundToDouble** | `method` | `double roundToDouble()` | Returns <code>this.toDouble()</code>. |
| **floorToDouble** | `method` | `double floorToDouble()` | Returns <code>this.toDouble()</code>. |
| **ceilToDouble** | `method` | `double ceilToDouble()` | Returns <code>this.toDouble()</code>. |
| **truncateToDouble** | `method` | `double truncateToDouble()` | Returns <code>this.toDouble()</code>. |
| **toRadixString** | `method` | `String toRadixString(int radix)` | Converts this **int** to a string representation in the given **radix**.

In the string representation, lower-case letters are used for digits above
'9', with 'a' being 10 and 'z' being 35.

The **radix** argument must be an integer in the range 2 to 36.

Example:
```dart
// Binary (base 2).
print(12.toRadixString(2)); // 1100
print(31.toRadixString(2)); // 11111
print(2021.toRadixString(2)); // 11111100101
print((-12).toRadixString(2)); // -1100
// Octal (base 8).
print(12.toRadixString(8)); // 14
print(31.toRadixString(8)); // 37
print(2021.toRadixString(8)); // 3745
// Hexadecimal (base 16).
print(12.toRadixString(16)); // c
print(31.toRadixString(16)); // 1f
print(2021.toRadixString(16)); // 7e5
// Base 36.
print((35 * 36 + 1).toRadixString(36)); // z1
``` |

---
### extension `SignalIntExtensions`

Extensions for **int**


#### Members of `SignalIntExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<int> $` | Return a signal from a int value |

---
### extension `ReadonlyIterableSignalExtension`

Helper extensions for [ReadonlySignal<Iterable>](/types/readonlysignal)


#### Members of `ReadonlyIterableSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | `method` | `bool any(bool Function(E element) test)` |  |
| **cast** | `method` | `Iterable<R> cast()` |  |
| **contains** | `method` | `bool contains(Object? value)` |  |
| **elementAt** | `method` | `E elementAt(int index)` |  |
| **every** | `method` | `bool every(bool Function(E element) test)` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **first** | `method` | `E first` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **iterator** | `method` | `Iterator<E> iterator` |  |
| **join** | `method` | `String join([String separator = ""])` |  |
| **last** | `method` | `E last` |  |
| **lastWhere** | `method` | `E lastWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Iterable<R> map(R Function(E e) toElement)` |  |
| **reduce** | `method` | `E reduce(E Function(E value, E element) combine)` |  |
| **single** | `method` | `E single` |  |
| **singleWhere** | `method` | `E singleWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **skip** | `method` | `Iterable<E> skip(int count)` |  |
| **skipWhile** | `method` | `Iterable<E> skipWhile(bool Function(E value) test)` |  |
| **take** | `method` | `Iterable<E> take(int count)` |  |
| **takeWhile** | `method` | `Iterable<E> takeWhile(bool Function(E value) test)` |  |
| **toList** | `method` | `List<E> toList({bool growable = true})` |  |
| **toSet** | `method` | `Set<E> toSet()` |  |
| **where** | `method` | `Iterable<E> where(bool Function(E element) test)` |  |
| **whereType** | `method` | `Iterable<R> whereType()` |  |
| **forEach** | `method` | `void forEach(void Function(E element) action)` |  |

---
### extension `SignalIterableExtensions`

Extensions for **Iterable<E>**


#### Members of `SignalIterableExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Iterable<E>> $` | Return a signal from a Iterable value |

---
### extension `ReadonlyListSignalExtension`

Helper extensions for [ReadonlySignal<List>](/types/readonlysignal)


#### Members of `ReadonlyListSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `List<R> cast()` |  |
| **last** | `method` | `E last` |  |
| **+** | `method` | `List<E> +(List<E> other)` |  |
| **[]** | `method` | `E [](int index)` |  |
| **asMap** | `method` | `Map<int, E> asMap()` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **getRange** | `method` | `Iterable<E> getRange(int start, int end)` |  |
| **indexOf** | `method` | `int indexOf(E element, [int start = 0])` |  |
| **indexWhere** | `method` | `int indexWhere(bool Function(E element) test, [int start = 0])` |  |
| **lastIndexOf** | `method` | `int lastIndexOf(E element, [int? start])` |  |
| **lastIndexWhere** | `method` | `int lastIndexWhere(bool Function(E element) test, [int? start])` |  |
| **reversed** | `method` | `Iterable<E> reversed` |  |
| **sorted** | `method` | `List<E> sorted([int Function(E a, E b)? compare])` | Return a new array that is sorted by the **compare** function |
| **sublist** | `method` | `List<E> sublist(int start, [int? end])` |  |

---
### extension `ListSignalExtension`

Helper extensions for [Signal<List>](/types/signal)


#### Members of `ListSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **first** | `method` | `first(E val)` |  |
| **last** | `method` | `last(E val)` |  |
| **length** | `method` | `length(int value)` |  |
| **[]=** | `method` | `void []=(int index, E value)` |  |
| **add** | `method` | `void add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> iterable)` |  |
| **clear** | `method` | `void clear()` |  |
| **fillRange** | `method` | `void fillRange(int start, int end, [E? fillValue])` |  |
| **insert** | `method` | `void insert(int index, E element)` |  |
| **insertAll** | `method` | `void insertAll(int index, Iterable<E> iterable)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAt** | `method` | `E removeAt(int index)` |  |
| **removeLast** | `method` | `E removeLast()` |  |
| **removeRange** | `method` | `void removeRange(int start, int end)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **replaceRange** | `method` | `void replaceRange(int start, int end, Iterable<E> replacements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **setAll** | `method` | `void setAll(int index, Iterable<E> iterable)` |  |
| **setRange** | `method` | `void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])` |  |
| **shuffle** | `method` | `void shuffle([Random? random])` |  |
| **sort** | `method` | `void sort([int Function(E a, E b)? compare])` |  |

---
### extension `SignalListExtensions`

Extensions for **List<E>**


#### Members of `SignalListExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<List<E>> $` | Return a signal from a List value |

---
### extension `ReadonlyMapSignalExtension`

Helper extensions for [ReadonlySignal<Map>](/types/readonlysignal)


#### Members of `ReadonlyMapSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | `method` | `V? [](Object? key)` |  |
| **cast** | `method` | `Map<RK, RV> cast()` |  |
| **containsKey** | `method` | `bool containsKey(Object? key)` |  |
| **containsValue** | `method` | `bool containsValue(Object? value)` |  |
| **entries** | `method` | `Iterable<MapEntry<K, V>> entries` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **keys** | `method` | `Iterable<K> keys` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)` |  |
| **values** | `method` | `Iterable<V> values` |  |

---
### extension `MapSignalExtension`

Helper extensions for [Signal<Map>](/types/signal)


#### Members of `MapSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]=** | `method` | `void []=(K key, V value)` |  |
| **addAll** | `method` | `void addAll(Map<K, V> other)` |  |
| **addEntries** | `method` | `void addEntries(Iterable<MapEntry<K, V>> newEntries)` |  |
| **clear** | `method` | `void clear()` |  |
| **forEach** | `method` | `void forEach(void Function(K key, V value) action)` |  |
| **putIfAbsent** | `method` | `V putIfAbsent(K key, V Function() ifAbsent)` |  |
| **remove** | `method` | `V? remove(Object? key)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(K key, V value) test)` |  |
| **update** | `method` | `V update(K key, V Function(V value) update, {V Function()? ifAbsent})` |  |
| **updateAll** | `method` | `void updateAll(V Function(K key, V value) update)` |  |

---
### extension `SignalMapExtensions`

Extensions for **Map<E>**


#### Members of `SignalMapExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Map<K, V>> $` | Return a signal from a Map value |

---
### extension `NumSignalExtension`

Helper extensions for [ReadonlySignal<num>](/types/readonlysignal), providing convenient reactive math and comparison operations without needing to manually unwrap <code>.value</code>.

```dart
import 'package:signals_core/signals_core.dart';

final a = 5.0.$;
final sum = a + 3; // 8.0 (evaluates reactively)
final isGreater = a > 4; // true
```


#### Members of `NumSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **+** | `method` | `num +(num other)` | Adds **other** to this number.

The result is an **int**, as described by [int.+],
if both this number and **other** is an integer,
otherwise the result is a **double**. |
| **-** | `method` | `num -(num other)` | Subtracts **other** from this number.

The result is an **int**, as described by **int.-**,
if both this number and **other** is an integer,
otherwise the result is a **double**. |
| ***** | `method` | `num *(num other)` | Multiplies this number by **other**.

The result is an **int**, as described by [int.*],
if both this number and **other** are integers,
otherwise the result is a **double**. |
| **%** | `method` | `num %(num other)` | Euclidean modulo of this number by **other**.

Returns the remainder of the Euclidean division.
The Euclidean division of two integers <code>a</code> and <code>b</code>
yields two integers <code>q</code> and <code>r</code> such that
<code>a == b * q + r</code> and <code>0 <= r < b.abs()</code>.

The Euclidean division is only defined for integers, but can be easily
extended to work with doubles. In that case, <code>q</code> is still an integer,
but <code>r</code> may have a non-integer value that still satisfies <code>0 <= r < |b|</code>.

The sign of the returned value <code>r</code> is always positive.

See **remainder** for the remainder of the truncating division.

The result is an **int**, as described by [int.%],
if both this number and **other** are integers,
otherwise the result is a **double**.

Example:
```dart
print(5 % 3); // 2
print(-5 % 3); // 1
print(5 % -3); // 2
print(-5 % -3); // 1
``` |
| **/** | `method` | `double /(num other)` | Divides this number by **other**. |
| **~/** | `method` | `int ~/(num other)` | Truncating division operator.

Performs truncating division of this number by **other**.
Truncating division is division where a fractional result
is converted to an integer by rounding towards zero.

If both operands are **int**s, then **other** must not be zero.
Then <code>a ~/ b</code> corresponds to <code>a.remainder(b)</code>
such that <code>a == (a ~/ b) * b + a.remainder(b)</code>.

If either operand is a **double**, then the other operand is converted
to a double before performing the division and truncation of the result.
Then <code>a ~/ b</code> is equivalent to <code>(a / b).truncate()</code>.
This means that the intermediate result of the double division
must be a finite integer (not an infinity or **double.nan**). |
| **-** | `method` | `num -()` | The negation of this value.

The negation of a number is a number of the same kind
(<code>int</code> or <code>double</code>) representing the negation of the
numbers numerical value (the result of subtracting the
number from zero), if that value *exists*.

Negating a double gives a number with the same magnitude
as the original value (<code>number.abs() == (-number).abs()</code>),
and the opposite sign (<code>-(number.sign) == (-number).sign</code>).

Negating an integer, <code>-number</code>, is equivalent to subtracting
it from zero, <code>0 - number</code>.

(Both properties generally also hold for the other type,
but with a few edge case exceptions). |
| **remainder** | `method` | `num remainder(num other)` | The remainder of the truncating division of <code>this</code> by **other**.

The result <code>r</code> of this operation satisfies:
<code>this == (this ~/ other) * other + r</code>.
As a consequence, the remainder <code>r</code> has the same sign as the dividend
<code>this</code>.

The result is an **int**, as described by **int.remainder**,
if both this number and **other** are integers,
otherwise the result is a **double**.

Example:
```dart
print(5.remainder(3)); // 2
print(-5.remainder(3)); // -2
print(5.remainder(-3)); // 2
print(-5.remainder(-3)); // -2
``` |
| **<** | `method` | `bool <(num other)` | Whether this number is numerically smaller than **other**.

Returns <code>true</code> if this number is smaller than **other**.
Returns <code>false</code> if this number is greater than or equal to **other**
or if either value is a NaN value like **double.nan**. |
| **<=** | `method` | `bool <=(num other)` | Whether this number is numerically smaller than or equal to **other**.

Returns <code>true</code> if this number is smaller than or equal to **other**.
Returns <code>false</code> if this number is greater than **other**
or if either value is a NaN value like **double.nan**. |
| **>** | `method` | `bool >(num other)` | Whether this number is numerically greater than **other**.

Returns <code>true</code> if this number is greater than **other**.
Returns <code>false</code> if this number is smaller than or equal to **other**
or if either value is a NaN value like **double.nan**. |
| **>=** | `method` | `bool >=(num other)` | Whether this number is numerically greater than or equal to **other**.

Returns <code>true</code> if this number is greater than or equal to **other**.
Returns <code>false</code> if this number is smaller than **other**
or if either value is a NaN value like **double.nan**. |
| **isNaN** | `method` | `bool isNaN` | Whether this number is a Not-a-Number value.

Is <code>true</code> if this number is the **double.nan** value
or any other of the possible **double** NaN values.
Is <code>false</code> if this number is an integer,
a finite double or an infinite double (**double.infinity**
or **double.negativeInfinity**).

All numbers satisfy exactly one of **isInfinite**, **isFinite**
and <code>isNaN</code>. |
| **isNegative** | `method` | `bool isNegative` | Whether this number is negative.

A number is negative if it's smaller than zero,
or if it is the double <code>-0.0</code>.
This precludes a NaN value like **double.nan** from being negative. |
| **isInfinite** | `method` | `bool isInfinite` | Whether this number is positive infinity or negative infinity.

Only satisfied by **double.infinity** and **double.negativeInfinity**.

All numbers satisfy exactly one of <code>isInfinite</code>, **isFinite**
and **isNaN**. |
| **isFinite** | `method` | `bool isFinite` | Whether this number is finite.

The only non-finite numbers are NaN values, positive infinity, and
negative infinity. All integers are finite.

All numbers satisfy exactly one of **isInfinite**, <code>isFinite</code>
and **isNaN**. |
| **abs** | `method` | `num abs()` | The absolute value of this number.

The absolute value is the value itself, if the value is non-negative,
and <code>-value</code> if the value is negative.

Integer overflow may cause the result of <code>-value</code> to stay negative.

```dart
print((2).abs()); // 2
print((-2.5).abs()); // 2.5
``` |
| **sign** | `method` | `num sign` | Negative one, zero or positive one depending on the sign and
numerical value of this number.

The value minus one if this number is less than zero,
plus one if this number is greater than zero,
and zero if this number is equal to zero.

Returns NaN if this number is a **double** NaN value.

Returns a number of the same type as this number.
For doubles, <code>(-0.0).sign</code> is <code>-0.0</code>.

The result satisfies:
```dart
n == n.sign * n.abs()
```
for all numbers <code>n</code> (except NaN, because NaN isn't <code>==</code> to itself). |
| **round** | `method` | `int round()` | The integer closest to this number.

Rounds away from zero when there is no closest integer:
 <code>(3.5).round() == 4</code> and <code>(-3.5).round() == -4</code>.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **floor** | `method` | `int floor()` | The greatest integer no greater than this number.

Rounds fractional values towards negative infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **ceil** | `method` | `int ceil()` | The least integer no smaller than <code>this</code>.

Rounds fractional values towards positive infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **truncate** | `method` | `int truncate()` | The integer obtained by discarding any fractional digits from <code>this</code>.

Rounds fractional values towards zero.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **roundToDouble** | `method` | `double roundToDouble()` | The double integer value closest to this value.

Rounds away from zero when there is no closest integer:
 <code>(3.5).roundToDouble() == 4</code> and <code>(-3.5).roundToDouble() == -4</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>,
and <code>-0.0</code> is therefore considered closer to negative numbers than <code>0.0</code>.
This means that for a value <code>d</code> in the range <code>-0.5 < d < 0.0</code>,
the result is <code>-0.0</code>. |
| **floorToDouble** | `method` | `double floorToDouble()` | Returns the greatest double integer value no greater than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>0.0 < d < 1.0</code> will return <code>0.0</code>. |
| **ceilToDouble** | `method` | `double ceilToDouble()` | Returns the least double integer value no smaller than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>. |
| **truncateToDouble** | `method` | `double truncateToDouble()` | Returns the double integer value obtained by discarding any fractional
digits from the double value of <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>, and
in the range <code>0.0 < d < 1.0</code> it will return 0.0. |
| **clamp** | `method` | `num clamp(num lowerLimit, num upperLimit)` | Returns this **num** clamped to be in the range **lowerLimit**-**upperLimit**.

The comparison is done using **compareTo** and therefore takes <code>-0.0</code> into
account. This also implies that **double.nan** is treated as the maximal
double value.

The arguments **lowerLimit** and **upperLimit** must form a valid range where
<code>lowerLimit.compareTo(upperLimit) <= 0</code>.

Example:
```dart
var result = 10.5.clamp(5, 10.0); // 10.0
result = 0.75.clamp(5, 10.0); // 5
result = (-10).clamp(-5, 5.0); // -5
result = (-0.0).clamp(-5, 5.0); // -0.0
``` |
| **toInt** | `method` | `int toInt()` | Truncates this **num** to an integer and returns the result as an **int**.

Equivalent to **truncate**. |
| **toDouble** | `method` | `double toDouble()` | This number as a **double**.

If an integer number is not precisely representable as a **double**,
an approximation is returned. |
| **toStringAsFixed** | `method` | `String toStringAsFixed(int fractionDigits)` | A decimal-point string-representation of this number.

Converts this number to a **double**
before computing the string representation,
as by **toDouble**.

If the absolute value of <code>this</code> is greater than or equal to <code>10^21</code>, then
this methods returns an exponential representation computed by
<code>this.toStringAsExponential()</code>. Otherwise the result
is the closest string representation with exactly **fractionDigits** digits
after the decimal point. If **fractionDigits** equals 0, then the decimal
point is omitted.

The parameter **fractionDigits** must be an integer satisfying:
<code>0 <= fractionDigits <= 20</code>.

Examples:
```dart
1.toStringAsFixed(3);  // 1.000
(4321.12345678).toStringAsFixed(3);  // 4321.123
(4321.12345678).toStringAsFixed(5);  // 4321.12346
123456789012345.toStringAsFixed(3);  // 123456789012345.000
10000000000000000.toStringAsFixed(4); // 10000000000000000.0000
5.25.toStringAsFixed(0); // 5
``` |
| **toStringAsExponential** | `method` | `String toStringAsExponential([int? fractionDigits])` | An exponential string-representation of this number.

Converts this number to a **double**
before computing the string representation.

If **fractionDigits** is given, then it must be an integer satisfying:
<code>0 <= fractionDigits <= 20</code>. In this case the string contains exactly
**fractionDigits** after the decimal point. Otherwise, without the parameter,
the returned string uses the shortest number of digits that accurately
represent this number.

If **fractionDigits** equals 0, then the decimal point is omitted.
Examples:
```dart
1.toStringAsExponential();       // 1e+0
1.toStringAsExponential(3);      // 1.000e+0
123456.toStringAsExponential();  // 1.23456e+5
123456.toStringAsExponential(3); // 1.235e+5
123.toStringAsExponential(0);    // 1e+2
``` |
| **toStringAsPrecision** | `method` | `String toStringAsPrecision(int precision)` | A string representation with **precision** significant digits.

Converts this number to a **double**
and returns a string representation of that value
with exactly **precision** significant digits.

The parameter **precision** must be an integer satisfying:
<code>1 <= precision <= 21</code>.

Examples:
```dart
1.toStringAsPrecision(2);       // 1.0
1e15.toStringAsPrecision(3);    // 1.00e+15
1234567.toStringAsPrecision(3); // 1.23e+6
1234567.toStringAsPrecision(9); // 1234567.00
12345678901234567890.toStringAsPrecision(20); // 12345678901234567168
12345678901234567890.toStringAsPrecision(14); // 1.2345678901235e+19
0.00000012345.toStringAsPrecision(15); // 1.23450000000000e-7
0.0000012345.toStringAsPrecision(15);  // 0.00000123450000000000
``` |

---
### extension `SignalNumExtensions`

Utility extension on **num** to easily lift a number into a reactive [Signal](/types/signal).


#### Members of `SignalNumExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<num> $` | Lift a primitive **num** into a reactive [Signal<num>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final counter = 10.$;
print(counter.value); // 10
``` |

---
### extension `PatternSignalExtension`

Helper extensions for [ReadonlySignal<Pattern>](/types/readonlysignal)


#### Members of `PatternSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **allMatches** | `method` | `Iterable<Match> allMatches(String string, [int start = 0])` | Matches this pattern against the string repeatedly.

If **start** is provided, matching will start at that index.

The returned iterable lazily finds non-overlapping matches
of the pattern in the **string**.
If a user only requests the first match,
this function should not compute all possible matches.

The matches are found by repeatedly finding the first match
of the pattern in the string, initially starting from **start**,
and then from the end of the previous match (but always
at least one position later than the *start* of the previous
match, in case the pattern matches an empty substring).
```dart
RegExp exp = RegExp(r'(\w+)');
var str = 'Dash is a bird';
Iterable<Match> matches = exp.allMatches(str, 8);
for (final Match m in matches) {
  String match = m[0]!;
  print(match);
}
```
The output of the example is:
```
a
bird
``` |
| **matchAsPrefix** | `method` | `Match? matchAsPrefix(String string, [int start = 0])` | Matches this pattern against the start of <code>string</code>.

Returns a match if the pattern matches a substring of **string**
starting at **start**, and <code>null</code> if the pattern doesn't match
at that point.

The **start** must be non-negative and no greater than <code>string.length</code>.
```dart
final string = 'Dash is a bird';

var regExp = RegExp(r'bird');
var match = regExp.matchAsPrefix(string, 10); // Match found.

regExp = RegExp(r'bird');
match = regExp.matchAsPrefix(string); // null
``` |

---
### extension `SignalPatternExtensions`

Extensions for **Pattern**


#### Members of `SignalPatternExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Pattern> $` | Return a signal from a Pattern value |

---
### extension `ReadonlySetSignalExtension`

Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively.

```dart
import 'package:signals_core/signals_core.dart';

final setA = {1, 2, 3}.$;
final setB = {3, 4, 5}.$;
final diff = computed(() => setA.difference(setB.value)); // {1, 2}
```


#### Members of `ReadonlySetSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `Set<R> cast()` |  |
| **containsAll** | `method` | `bool containsAll(Iterable<Object?> other)` |  |
| **difference** | `method` | `Set<E> difference(Set<Object?> other)` |  |
| **intersection** | `method` | `Set<E> intersection(Set<Object?> other)` |  |
| **lookup** | `method` | `E? lookup(Object? object)` |  |
| **union** | `method` | `Set<E> union(Set<E> other)` |  |

---
### extension `SetSignalExtension`

Helper extensions for [Signal<Set<E>>] to perform mutation operations that automatically notify downstreams.

Under the hood, these methods mutate the underlying set and call <code>set(..., force: true)</code> to trigger all listeners and computations.

```dart
import 'package:signals_core/signals_core.dart';

final tags = <String>{}.$;

effect(() {
  print('Tags: ${tags.value}');
});

tags.add('dart'); // Automatically prints: Tags: {dart}
tags.addAll(['flutter', 'signals']); // Automatically prints: Tags: {dart, flutter, signals}
```


#### Members of `SetSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `bool add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> elements)` |  |
| **clear** | `method` | `void clear()` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAll** | `method` | `void removeAll(Iterable<Object?> elements)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **retainAll** | `method` | `void retainAll(Iterable<Object?> elements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |

---
### extension `SignalSetExtensions`

Utility extension on **Set** to easily lift a set into a reactive [Signal](/types/signal).


#### Members of `SignalSetExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Set<E>> $` | Lift a primitive **Set** into a reactive [Signal<Set<E>>].

```dart
import 'package:signals_core/signals_core.dart';

final tags = {'sports', 'news'}.$;
print(tags.value); // {'sports', 'news'}
``` |

---
### extension `StringSignalExtension`

Helper extensions for [ReadonlySignal<String>](/types/readonlysignal)


#### Members of `StringSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | `method` | `String [](int index)` | The character (as a single-code-unit **String**) at the given **index**.

The returned string represents exactly one UTF-16 code unit, which may be
half of a surrogate pair. A single member of a surrogate pair is an
invalid UTF-16 string:
```dart
var clef = '\u{1D11E}';
// These represent invalid UTF-16 strings.
clef[0].codeUnits;      // [0xD834]
clef[1].codeUnits;      // [0xDD1E]
```
This method is equivalent to
<code>String.fromCharCode(this.codeUnitAt(index))</code>. |
| **codeUnitAt** | `method` | `int codeUnitAt(int index)` | Returns the 16-bit UTF-16 code unit at the given **index**. |
| **length** | `method` | `int length` | The length of the string.

Returns the number of UTF-16 code units in this string. The number
of **runes** might be fewer if the string contains characters outside
the Basic Multilingual Plane (plane 0):
```dart
'Dart'.length;          // 4
'Dart'.runes.length;    // 4

var clef = '\u{1D11E}';
clef.length;            // 2
clef.runes.length;      // 1
``` |
| **endsWith** | `method` | `bool endsWith(String other)` | Whether this string ends with **other**.

For example:
```dart
const string = 'Dart is open source';
print(string.endsWith('urce')); // true
``` |
| **startsWith** | `method` | `bool startsWith(Pattern pattern, [int index = 0])` | Whether this string starts with a match of **pattern**.

```dart
const string = 'Dart is open source';
print(string.startsWith('Dar')); // true
print(string.startsWith(RegExp(r'[A-Z][a-z]'))); // true
```
If **index** is provided, this method checks if the substring starting
at that index starts with a match of **pattern**:
```dart
const string = 'Dart';
print(string.startsWith('art', 0)); // false
print(string.startsWith('art', 1)); // true
print(string.startsWith(RegExp(r'\w{3}'), 2)); // false
```
**index** must not be negative or greater than **length**.

A **RegExp** containing '^' does not match if the **index** is greater than
zero and the regexp is not multi-line.
The pattern works on the string as a whole, and does not extract
a substring starting at **index** first:
```dart
const string = 'Dart';
print(string.startsWith(RegExp(r'^art'), 1)); // false
print(string.startsWith(RegExp(r'art'), 1)); // true
``` |
| **indexOf** | `method` | `int indexOf(Pattern pattern, [int start = 0])` | Returns the position of the first match of **pattern** in this string,
starting at **start**, inclusive:
```dart
const string = 'Dartisans';
print(string.indexOf('art')); // 1
print(string.indexOf(RegExp(r'[A-Z][a-z]'))); // 0
```
Returns -1 if no match is found:
```dart
const string = 'Dartisans';
string.indexOf(RegExp(r'dart')); // -1
```
The **start** must be non-negative and not greater than **length**. |
| **lastIndexOf** | `method` | `int lastIndexOf(Pattern pattern, [int? start])` | The starting position of the last match **pattern** in this string.

Finds a match of pattern by searching backward starting at **start**:
```dart
const string = 'Dartisans';
print(string.lastIndexOf('a')); // 6
print(string.lastIndexOf(RegExp(r'a(r|n)'))); // 6
```
Returns -1 if **pattern** could not be found in this string.
```dart
const string = 'Dartisans';
print(string.lastIndexOf(RegExp(r'DART'))); // -1
```
If **start** is omitted, search starts from the end of the string.
If supplied, **start** must be non-negative and not greater than **length**. |
| **isEmpty** | `method` | `bool isEmpty` | Whether this string is empty. |
| **isNotEmpty** | `method` | `bool isNotEmpty` | Whether this string is not empty. |
| **+** | `method` | `String +(String other)` | Creates a new string by concatenating this string with **other**.

Example:
```dart
const string = 'dart' + 'lang'; // 'dartlang'
``` |
| **substring** | `method` | `String substring(int start, [int? end])` | The substring of this string from **start**, inclusive, to **end**, exclusive.

Example:
```dart
const string = 'dartlang';
var result = string.substring(1); // 'artlang'
result = string.substring(1, 4); // 'art'
```

Both **start** and **end** must be non-negative and no greater than **length**;
**end**, if provided, must be greater than or equal to **start**. |
| **trim** | `method` | `String trim()` | The string without any leading and trailing whitespace.

If the string contains leading or trailing whitespace, a new string with no
leading and no trailing whitespace is returned:
```dart
final trimmed = '\tDart is fun\n'.trim();
print(trimmed); // 'Dart is fun'
```
Otherwise, the original string itself is returned:
```dart
const string1 = 'Dart';
final string2 = string1.trim(); // 'Dart'
print(identical(string1, string2)); // true
```
Whitespace is defined by the Unicode White_Space property (as defined in
version 6.2 or later) and the BOM character, 0xFEFF.

Here is the list of trimmed characters according to Unicode version 6.3:
```plaintext
    0009..000D    ; White_Space # Cc   <control-0009>..<control-000D>
    0020          ; White_Space # Zs   SPACE
    0085          ; White_Space # Cc   <control-0085>
    00A0          ; White_Space # Zs   NO-BREAK SPACE
    1680          ; White_Space # Zs   OGHAM SPACE MARK
    2000..200A    ; White_Space # Zs   EN QUAD..HAIR SPACE
    2028          ; White_Space # Zl   LINE SEPARATOR
    2029          ; White_Space # Zp   PARAGRAPH SEPARATOR
    202F          ; White_Space # Zs   NARROW NO-BREAK SPACE
    205F          ; White_Space # Zs   MEDIUM MATHEMATICAL SPACE
    3000          ; White_Space # Zs   IDEOGRAPHIC SPACE

    FEFF          ; BOM                ZERO WIDTH NO_BREAK SPACE
```
Some later versions of Unicode do not include U+0085 as a whitespace
character. Whether it is trimmed depends on the Unicode version
used by the system. |
| **trimLeft** | `method` | `String trimLeft()` | The string without any leading whitespace.

As **trim**, but only removes leading whitespace.
```dart
final string = ' Dart '.trimLeft();
print(string); // 'Dart '
``` |
| **trimRight** | `method` | `String trimRight()` | The string without any trailing whitespace.

As **trim**, but only removes trailing whitespace.
```dart
final string = ' Dart '.trimRight();
print(string); // ' Dart'
``` |
| ***** | `method` | `String *(int times)` | Creates a new string by concatenating this string with itself a number
of times.

The result of <code>str * n</code> is equivalent to
<code>str + str + ...</code>(n times)<code>... + str</code>.

```dart
const string = 'Dart';
final multiplied = string * 3;
print(multiplied); // 'DartDartDart'
```
Returns an empty string if **times** is zero or negative. |
| **padLeft** | `method` | `String padLeft(int width, [String padding = ' '])` | Pads this string on the left if it is shorter than **width**.

Returns a new string that prepends **padding** onto this string
one time for each position the length is less than **width**.

```dart
const string = 'D';
print(string.padLeft(4)); // '   D'
print(string.padLeft(2, 'x')); // 'xD'
print(string.padLeft(4, 'y')); // 'yyyD'
print(string.padLeft(4, '>>')); // '>>>>>>D'
```

If **width** is already smaller than or equal to <code>this.length</code>,
no padding is added. A negative <code>width</code> is treated as zero.

If **padding** has length different from 1, the result will not
have length <code>width</code>. This may be useful for cases where the
padding is a longer string representing a single character, like
<code>"&nbsp;"</code> or <code>"\u{10002}</code>".
In that case, the user should make sure that <code>this.length</code> is
the correct measure of the string's length. |
| **padRight** | `method` | `String padRight(int width, [String padding = ' '])` | Pads this string on the right if it is shorter than **width**.

Returns a new string that appends **padding** after this string
one time for each position the length is less than **width**.

```dart
const string = 'D';
print(string.padRight(4)); // 'D    '
print(string.padRight(2, 'x')); // 'Dx'
print(string.padRight(4, 'y')); // 'Dyyy'
print(string.padRight(4, '>>')); // 'D>>>>>>'
```

If **width** is already smaller than or equal to <code>this.length</code>,
no padding is added. A negative <code>width</code> is treated as zero.

If **padding** has length different from 1, the result will not
have length <code>width</code>. This may be useful for cases where the
padding is a longer string representing a single character, like
<code>"&nbsp;"</code> or <code>"\u{10002}</code>".
In that case, the user should make sure that <code>this.length</code> is
the correct measure of the string's length. |
| **contains** | `method` | `bool contains(Pattern other, [int startIndex = 0])` | Whether this string contains a match of **other**.

Example:
```dart
const string = 'Dart strings';
final containsD = string.contains('D'); // true
final containsUpperCase = string.contains(RegExp(r'[A-Z]')); // true
```
If **startIndex** is provided, this method matches only at or after that
index:
```dart
const string = 'Dart strings';
final containsD = string.contains(RegExp('D'), 0); // true
final caseSensitive = string.contains(RegExp(r'[A-Z]'), 1); // false
```
The **startIndex** must not be negative or greater than **length**. |
| **replaceFirst** | `method` | `String replaceFirst(Pattern from, String to, [int startIndex = 0])` | Creates a new string with the first occurrence of **from** replaced by **to**.

Finds the first match of **from** in this string, starting from **startIndex**,
and creates a new string where that match is replaced with the **to** string.

Example:
```dart
'0.0001'.replaceFirst(RegExp(r'0'), ''); // '.0001'
'0.0001'.replaceFirst(RegExp(r'0'), '7', 1); // '0.7001'
``` |
| **replaceFirstMapped** | `method` | `String replaceFirstMapped(Pattern from, String Function(Match match) replace, [int startIndex = 0])` | Replace the first occurrence of **from** in this string.

```dart
const string = 'Dart is fun';
print(string.replaceFirstMapped(
    'fun', (m) => 'open source')); // Dart is open source

print(string.replaceFirstMapped(
    RegExp(r'\w(\w*)'), (m) => '<${m[0]}-${m[1]}>')); // <Dart-art> is fun
```

Returns a new string, which is this string
except that the first match of **from**, starting from **startIndex**,
is replaced by the result of calling **replace** with the match object.

The **startIndex** must be non-negative and no greater than **length**. |
| **replaceAll** | `method` | `String replaceAll(Pattern from, String replace)` | Replaces all substrings that match **from** with **replace**.

Creates a new string in which the non-overlapping substrings matching
**from** (the ones iterated by <code>from.allMatches(thisString)</code>) are replaced
by the literal string **replace**.
```dart
'resume'.replaceAll(RegExp(r'e'), 'é'); // 'résumé'
```
Notice that the **replace** string is not interpreted. If the replacement
depends on the match (for example, on a **RegExp**'s capture groups), use
the **replaceAllMapped** method instead. |
| **replaceAllMapped** | `method` | `String replaceAllMapped(Pattern from, String Function(Match match) replace)` | Replace all substrings that match **from** by a computed string.

Creates a new string in which the non-overlapping substrings that match
**from** (the ones iterated by <code>from.allMatches(thisString)</code>) are replaced
by the result of calling **replace** on the corresponding **Match** object.

This can be used to replace matches with new content that depends on the
match, unlike **replaceAll** where the replacement string is always the same.

The **replace** function is called with the **Match** generated
by the pattern, and its result is used as replacement.

The function defined below converts each word in a string to simplified
'pig latin' using **replaceAllMapped**:
```dart
String pigLatin(String words) => words.replaceAllMapped(
    RegExp(r'\b(\w*?)([aeiou]\w*)', caseSensitive: false),
    (Match m) => "${m[2]}${m[1]}${m[1]!.isEmpty ? 'way' : 'ay'}");

final result = pigLatin('I have a secret now!');
print(result); // 'Iway avehay away ecretsay ownay!'
``` |
| **replaceRange** | `method` | `String replaceRange(int start, int? end, String replacement)` | Replaces the substring from **start** to **end** with **replacement**.

Creates a new string equivalent to:
```dart
this.substring(0, start) + replacement + this.substring(end)
```
Example:
```dart
const string = 'Dart is fun';
final result = string.replaceRange(8, null, 'open source');
print(result); // Dart is open source
```
The **start** and **end** indices must specify a valid range of this string.
That is <code>0 <= start <= end <= this.length</code>.
If **end** is <code>null</code>, it defaults to **length**. |
| **split** | `method` | `List<String> split(Pattern pattern)` | Splits the string at matches of **pattern** and returns a list of substrings.

Finds all the matches of <code>pattern</code> in this string,
as by using **Pattern.allMatches**,
and returns the list of the substrings between the matches,
before the first match, and after the last match.
```dart
const string = 'Hello world!';
final splitted = string.split(' ');
print(splitted); // [Hello, world!];
```
If the pattern doesn't match this string at all,
the result is always a list containing only the original string.

If the **pattern** is a **String**, then it's always the case that:
```dart
string.split(pattern).join(pattern) == string
```

If the first match is an empty match at the start of the string,
the empty substring before it is not included in the result.
If the last match is an empty match at the end of the string,
the empty substring after it is not included in the result.
If a match is empty, and it immediately follows a previous
match (it starts at the position where the previous match ended),
then the empty substring between the two matches is not
included in the result.
```dart
const string = 'abba';
final re = RegExp(r'b*');
// re.allMatches(string) will find four matches:
// * empty match before first "a".
// * match of "bb"
// * empty match after "bb", before second "a"
// * empty match after second "a".
print(string.split(re)); // [a, a]
```

A non-empty match at the start or end of the string, or after another
match, is not treated specially, and will introduce empty substrings
in the result:
```dart
const string = 'abbaa';
final splitted = string.split('a'); // ['', 'bb', '', '']
```

If this string is the empty string, the result is an empty list
if <code>pattern</code> matches the empty string, since the empty string
before and after the first-and-last empty match are not included.
(It is still a list containing the original empty string <code>[""]</code>
if the pattern doesn't match).
```dart
const string = '';
print(string.split('')); // []
print(string.split('a')); // []
```

Splitting with an empty pattern splits the string into single-code unit
strings.
```dart
const string = 'Pub';
print(string.split('')); // [P, u, b]

// Same as:
var codeUnitStrings = [
  for (final unit in string.codeUnits) String.fromCharCode(unit)
];
print(codeUnitStrings); // [P, u, b]
```

Splitting happens at UTF-16 code unit boundaries,
and not at rune (Unicode code point) boundaries:
```dart
// String made up of two code units, but one rune.
const string = '\u{1D11E}';
final splitted = string.split('');
print(splitted); // ['\ud834', '\udd1e'] - 2 unpaired surrogate values
```
To get a list of strings containing the individual runes of a string,
you should not use split.
You can instead get a string for each rune as follows:
```dart
const string = '\u{1F642}';
for (final rune in string.runes) {
  print(String.fromCharCode(rune));
}
``` |
| **splitMapJoin** | `method` | `String splitMapJoin(Pattern pattern, {String Function(Match)? onMatch, String Function(String)? onNonMatch})` | Splits the string, converts its parts, and combines them into a new
string.

The **pattern** is used to split the string
into parts and separating matches.
Each match of **Pattern.allMatches** of **pattern** on this string is
used as a match, and the substrings between the end of one match
(or the start of the string) and the start of the next match (or the
end of the string) is treated as a non-matched part.
(There is no omission of leading or trailing empty matchs, like
in **split**, all matches and parts between the are included.)

Each match is converted to a string by calling **onMatch**. If **onMatch**
is omitted, the matched substring is used.

Each non-matched part is converted to a string by a call to **onNonMatch**.
If **onNonMatch** is omitted, the non-matching substring itself is used.

Then all the converted parts are concatenated into the resulting string.
```dart
final result = 'Eats shoots leaves'.splitMapJoin(RegExp(r'shoots'),
    onMatch: (m) => '${m[0]}', // (or no onMatch at all)
    onNonMatch: (n) => '*');
print(result); // *shoots*
``` |
| **codeUnits** | `method` | `List<int> codeUnits` | An unmodifiable list of the UTF-16 code units of this string. |
| **runes** | `method` | `Runes runes` | An **Iterable** of Unicode code-points of this string.

If the string contains surrogate pairs, they are combined and returned
as one integer by this iterator. Unmatched surrogate halves are treated
like valid 16-bit code-units. |
| **toLowerCase** | `method` | `String toLowerCase()` | Converts all characters in this string to lower case.

If the string is already in all lower case, this method returns <code>this</code>.
```dart
'ALPHABET'.toLowerCase(); // 'alphabet'
'abc'.toLowerCase(); // 'abc'
```
This function uses the language independent Unicode mapping and thus only
works in some languages. |
| **toUpperCase** | `method` | `String toUpperCase()` | Converts all characters in this string to upper case.

If the string is already in all upper case, this method returns <code>this</code>.
```dart
'alphabet'.toUpperCase(); // 'ALPHABET'
'ABC'.toUpperCase(); // 'ABC'
```
This function uses the language independent Unicode mapping and thus only
works in some languages. |

---
### extension `SignalStringExtensions`

Extensions for **String**


#### Members of `SignalStringExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<String> $` | Return a signal from a String value |

---
### extension `EnumSignalExtension`

Helper extensions for [ReadonlySignal<Enum>](/types/readonlysignal)


#### Members of `EnumSignalExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **index** | `method` | `int index` | A numeric identifier for the enumerated value.

The values of a single enumeration are numbered
consecutively from zero to one less than the
number of values.
This is also the index of the value in the
enumerated type's static <code>values</code> list. |
| **name** | `method` | `String name` | The name of the enum value.

The name is a string containing the source identifier used
to declare the enum value.

For example, given a declaration like:
```dart
enum MyEnum {
  value1,
  value2
}
```
the result of <code>MyEnum.value1.name</code> is the string <code>"value1"</code>. |

---
### extension `SignalEnumExtensions`

Extensions for **Enum**


#### Members of `SignalEnumExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<T> $` | Return a signal from a Enum value |

---
### extension `SignalFunctionExtensions`

Utility extension on a getter function <code>T Function()</code> to instantly convert it into a [Computed](/types/computed) signal.


#### Members of `SignalFunctionExtensions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Computed<T> $` | Return a cached, derived [Computed<T>](/types/computed) signal from this getter function.

```dart
import 'package:signals_core/signals_core.dart';

final count = signal(0);
final doubleCount = (() => count.value * 2).$;

print(doubleCount.value); // 0
count.value = 5;
print(doubleCount.value); // 10
``` |

---
### class `EventSinkSignalMixin`

A mixin that implements the standard **EventSink** interface for a [Signal](/types/signal)
holding an [AsyncState](/types/asyncstate) value.

This mixin is designed specifically to interface with **Stream** consumers or
other asynchronous data producers. It maps **add** to <code>AsyncState.data(...)</code>,
**addError** to <code>AsyncState.error(...)</code>, and **close** to disposing the signal.

<Info>
This mixin only works with signals whose value is of type <a href="/types/asyncstate">AsyncState<T></a>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyEventSinkSignal extends Signal<AsyncState<int>> with EventSinkSignalMixin<int> {
  MyEventSinkSignal(int initialValue) : super(AsyncState.data(initialValue));
}

void main() {
  final signal = MyEventSinkSignal(0);

  effect(() {
    final state = signal.value;
    state.map(
      data: (val) => print('Data received: $val'),
      error: (err, stack) => print('Error occurred: $err'),
      loading: () => print('Loading...'),
    );
  }); // Prints: "Data received: 0"

  // Treat it as an EventSink and add data
  signal.add(10); // Prints: "Data received: 10"

  // Push an error event
  signal.addError(Exception('Failure')); // Prints: "Error occurred: Exception: Failure"

  // Close/dispose the sink
  signal.close();
  print('Is disposed: ${signal.disposed}'); // Prints: "Is disposed: true"
}
```

<Warning>
Once <strong>close</strong> is called, the signal is disposed. Trying to call <strong>add</strong> or <strong>addError</strong>
after closing will result in an exception.
</Warning>


#### Members of `EventSinkSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `void add(T event)` |  |
| **addError** | `method` | `void addError(Object error, [StackTrace? stackTrace])` |  |
| **close** | `method` | `void close()` |  |

---
### class `SinkSignalMixin`

A mixin that implements the standard **Sink** interface for a [Signal](/types/signal).

This mixin allows you to treat a writable [Signal](/types/signal) as a sink of events, where
adding an element using **add** automatically updates the signal's value and
notifies all reactive listeners. Calling **close** automatically disposes
the signal, freeing up resources and removing all active subscriptions.

This provides excellent compatibility with streams, transformers, or any
APIs that expect a standard Dart **Sink**.

### Example Usage

```dart
import 'package:signals/signals.dart';

class MySinkSignal extends Signal<int> with SinkSignalMixin<int> {
  MySinkSignal(super.internalValue);
}

void main() {
  final signal = MySinkSignal(0);

  effect(() {
    print('Signal value changed to: ${signal.value}');
  }); // Prints: "Signal value changed to: 0"

  // Treat it as a Sink and push elements to it
  signal.add(42); // Prints: "Signal value changed to: 42"
  signal.add(100); // Prints: "Signal value changed to: 100"

  // Dispose the signal when finished
  signal.close();
  print('Is disposed: ${signal.disposed}'); // Prints: "Is disposed: true"
}
```

<Warning>
Once <strong>close</strong> is called, the signal is permanently disposed and cannot be reused
or written to anymore. Any subsequent <strong>add</strong> calls will throw an exception.
</Warning>


#### Members of `SinkSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `void add(T event)` |  |
| **close** | `method` | `void close()` |  |

---
### class `StreamSignalMixin`

A mixin that implements the standard **Stream** interface for a [ReadonlySignal](/types/readonlysignal).

This mixin allows you to treat a read-only or writable signal as a standard asynchronous
**Stream**, where updates to the signal's value are pushed as stream events.
This provides out-of-the-box compatibility with the entire asynchronous Dart SDK,
such as stream transformers, <code>await for</code> loops, and Flutter's **StreamBuilder**.

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyStreamSignal extends Signal<int> with StreamSignalMixin<int> {
  MyStreamSignal(super.internalValue);
}

void main() async {
  final counter = MyStreamSignal(0);

  // Standard stream subscription
  final subscription = counter.listen((val) {
    print('Stream emitted: $val');
  }); // Prints: "Stream emitted: 0" (if listened immediately)

  counter.value = 1; // Prints: "Stream emitted: 1"
  counter.value = 2; // Prints: "Stream emitted: 2"

  await subscription.cancel();
}
```

### Flutter StreamBuilder Example

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterSignal extends Signal<int> with StreamSignalMixin<int> {
  CounterSignal(int value) : super(value);
}

final counter = CounterSignal(0);

Widget build(BuildContext context) {
  return StreamBuilder<int>(
    stream: counter,
    builder: (context, snapshot) {
      return Text('Count: ${snapshot.data}');
    },
  );
}
```

<Success>
Since <a href="/types/streamsignalmixin">StreamSignalMixin</a> creates an internal broadcast <strong>StreamController</strong>, multiple listeners
can subscribe simultaneously. All subscriptions are closed and resources are released
automatically when the signal is disposed.
</Success>


#### Members of `StreamSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | `method` | `Future<bool> any(bool Function(T element) test)` |  |
| **asBroadcastStream** | `method` | `Stream<T> asBroadcastStream({void Function(StreamSubscription<T> subscription)? onListen, void Function(StreamSubscription<T> subscription)? onCancel})` |  |
| **asyncExpand** | `method` | `Stream<E> asyncExpand(Stream<E>? Function(T event) convert)` |  |
| **asyncMap** | `method` | `Stream<E> asyncMap(FutureOr<E> Function(T event) convert)` |  |
| **cast** | `method` | `Stream<R> cast()` |  |
| **contains** | `method` | `Future<bool> contains(Object? needle)` |  |
| **distinct** | `method` | `Stream<T> distinct([bool Function(T previous, T next)? equals])` |  |
| **drain** | `method` | `Future<E> drain([E? futureValue])` |  |
| **elementAt** | `method` | `Future<T> elementAt(int index)` |  |
| **every** | `method` | `Future<bool> every(bool Function(T element) test)` |  |
| **expand** | `method` | `Stream<S> expand(Iterable<S> Function(T element) convert)` |  |
| **first** | `method` | `Future<T> first` |  |
| **firstWhere** | `method` | `Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **fold** | `method` | `Future<S> fold(S initialValue, S Function(S previous, T element) combine)` |  |
| **forEach** | `method` | `Future<void> forEach(void Function(T element) action)` |  |
| **handleError** | `method` | `Stream<T> handleError(Function onError, {bool Function(dynamic error)? test})` |  |
| **isBroadcast** | `method` | `bool isBroadcast` |  |
| **isEmpty** | `method` | `Future<bool> isEmpty` |  |
| **join** | `method` | `Future<String> join([String separator = ""])` |  |
| **last** | `method` | `Future<T> last` |  |
| **lastWhere** | `method` | `Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **length** | `method` | `Future<int> length` |  |
| **listen** | `method` | `StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})` |  |
| **map** | `method` | `Stream<S> map(S Function(T event) convert)` |  |
| **pipe** | `method` | `Future pipe(StreamConsumer<T> streamConsumer)` |  |
| **reduce** | `method` | `Future<T> reduce(T Function(T previous, T element) combine)` |  |
| **single** | `method` | `Future<T> single` |  |
| **singleWhere** | `method` | `Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **skip** | `method` | `Stream<T> skip(int count)` |  |
| **skipWhile** | `method` | `Stream<T> skipWhile(bool Function(T element) test)` |  |
| **take** | `method` | `Stream<T> take(int count)` |  |
| **takeWhile** | `method` | `Stream<T> takeWhile(bool Function(T element) test)` |  |
| **timeout** | `method` | `Stream<T> timeout(Duration timeLimit, {void Function(EventSink<T> sink)? onTimeout})` |  |
| **toList** | `method` | `Future<List<T>> toList()` |  |
| **toSet** | `method` | `Future<Set<T>> toSet()` |  |
| **transform** | `method` | `Stream<S> transform(StreamTransformer<T, S> streamTransformer)` |  |
| **where** | `method` | `Stream<T> where(bool Function(T event) test)` |  |

---
### mixin `ChangeStackSignalMixin`

A mixin that adds undo, redo, and state history replay capabilities to a [Signal](/types/signal).

[ChangeStackSignalMixin](/types/changestacksignalmixin) keeps track of past states of a signal's value in a double-ended
queue, allowing you to easily go back to previous values using **undo** and go forward to subsequent
values using **redo**. You can inspect if undo or redo are available via **canUndo** and **canRedo**.

You can also set a **limit** on the maximum size of the history stack, preventing memory leak
issues in long-running scenarios.

<Info>
If you only need access to the initial and immediate previous values of a signal (without a full
history stack or undo/redo mechanisms), use the lightweight <a href="/types/trackedsignalmixin">TrackedSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class HistorySignal extends Signal<int> with ChangeStackSignalMixin<int> {
  HistorySignal(super.internalValue);
}

void main() {
  final counter = HistorySignal(0);
  counter.limit = 5; // Cap history stack to 5 items

  counter.value = 1;
  counter.value = 2;
  counter.value = 3;

  print('Current: ${counter.value}'); // Prints: "Current: 3"
  print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"

  // Undo last change
  counter.undo();
  print('Undone: ${counter.value}'); // Prints: "Undone: 2"

  // Undo once more
  counter.undo();
  print('Undone: ${counter.value}'); // Prints: "Undone: 1"

  // Redo the previous undo
  counter.redo();
  print('Redone: ${counter.value}'); // Prints: "Redone: 2"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned when changed.
If you mutate an object in-place directly without replacing the value using <code>set</code> or the <code>.value</code>
setter, the history queue will store references to the same mutated object, and undo/redo
will appear to do nothing.
</Warning>


#### Members of `ChangeStackSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | `field` | `int? limit` | Max values to keep in history |
| **history** | `method` | `Iterable<SignalChange<T>> history` | List of changes in the history |
| **redos** | `method` | `Iterable<SignalChange<T>> redos` | List of changes in the redo stack |
| **canRedo** | `method` | `bool canRedo` | Can redo the previous change |
| **canUndo** | `method` | `bool canUndo` | Can undo the previous change |
| **set** | `method` | `bool set(T val, {bool force = false})` |  |
| **redo** | `method` | `void redo()` | Redo Previous Undo |
| **undo** | `method` | `void undo()` | Undo Last Change |
| **clear** | `method` | `void clear()` | Clear the history for redo and undo |
| **clearUndo** | `method` | `void clearUndo()` | Clear undo stack |
| **clearRedo** | `method` | `void clearRedo()` | Clear redo stack |

---
### class `IterableSignalMixin`

A mixin that adds reactive <code>Iterable</code> methods and properties to a [Signal](/types/signal)
holding an **Iterable** value.

This mixin delegates all standard **Iterable** operations (such as <code>length</code>,
<code>first</code>, <code>last</code>, <code>map</code>, <code>where</code>, and <code>any</code>) directly to the underlying
collection, while ensuring that any read operations register a reactive
dependency on the signal.

<Info>
This mixin only works with signals that have a value type extending <strong>Iterable<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyIterableSignal extends Signal<Iterable<int>>
    with IterableSignalMixin<int, Iterable<int>> {
  MyIterableSignal(super.internalValue);
}

void main() {
  final numbers = MyIterableSignal([1, 2, 3]);

  // Set up a reactive effect that prints the list size and first element
  effect(() {
    print('Size: ${numbers.length}, First: ${numbers.first}');
  }); // Prints: "Size: 3, First: 1"

  // Update the signal value (triggers the effect)
  numbers.value = [10, 20, 30, 40]; // Prints: "Size: 4, First: 10"
}
```

<Warning>
Direct mutation of elements inside the iterable will NOT notify listeners
unless you reassign the value or use a specialized signal class like <code>ListSignal</code>,
<code>SetSignal</code>, or <code>MapSignal</code> which automatically trigger updates when modified.
</Warning>


#### Members of `IterableSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | `method` | `bool any(bool Function(E element) test)` |  |
| **cast** | `method` | `Iterable<R> cast()` |  |
| **contains** | `method` | `bool contains(Object? value)` |  |
| **elementAt** | `method` | `E elementAt(int index)` |  |
| **every** | `method` | `bool every(bool Function(E element) test)` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **first** | `method` | `E first` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **forEach** | `method` | `void forEach(void Function(E element) action)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **iterator** | `method` | `Iterator<E> iterator` |  |
| **join** | `method` | `String join([String separator = ""])` |  |
| **last** | `method` | `E last` |  |
| **lastWhere** | `method` | `E lastWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Iterable<R> map(R Function(E e) toElement)` |  |
| **reduce** | `method` | `E reduce(E Function(E value, E element) combine)` |  |
| **single** | `method` | `E single` |  |
| **singleWhere** | `method` | `E singleWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **skip** | `method` | `Iterable<E> skip(int count)` |  |
| **skipWhile** | `method` | `Iterable<E> skipWhile(bool Function(E value) test)` |  |
| **take** | `method` | `Iterable<E> take(int count)` |  |
| **takeWhile** | `method` | `Iterable<E> takeWhile(bool Function(E value) test)` |  |
| **toList** | `method` | `List<E> toList({bool growable = true})` |  |
| **toSet** | `method` | `Set<E> toSet()` |  |
| **where** | `method` | `Iterable<E> where(bool Function(E element) test)` |  |
| **whereType** | `method` | `Iterable<R> whereType()` |  |

---
### class `ListSignalMixin`

A mixin that adds reactive <code>List</code> methods and operators to a [Signal](/types/signal)
holding a **List** value.

This mixin delegates all standard **List** operations (such as mutations like <code>add</code>,
<code>remove</code>, <code>insert</code>, <code>sort</code>, and <code>clear</code>, and accessor operators like <code>[]</code> and <code>[]=</code>)
to the underlying list, while ensuring that any reads register a dependency
and any mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>List<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyListSignal extends Signal<List<int>>
    with IterableSignalMixin<int, List<int>>, ListSignalMixin<int, List<int>> {
  MyListSignal(super.internalValue);
}

void main() {
  final numbers = MyListSignal([1, 2, 3]);

  effect(() {
    print('Elements: $numbers, Length: ${numbers.length}');
  }); // Prints: "Elements: [1, 2, 3], Length: 3"

  // Adding an element (automatically calls set() and triggers updates)
  numbers.add(4); // Prints: "Elements: [1, 2, 3, 4], Length: 4"

  // Modifying an element by index (triggers updates)
  numbers[0] = 10; // Prints: "Elements: [10, 2, 3, 4], Length: 4"
}
```

<Success>
Since mutations on <code>ListSignalMixin</code> notify listeners automatically, you do not
need to assign <code>numbers.value = ...</code> to force updates. Methods like <code>add</code>, <code>addAll</code>,
and operator <code>[]=</code> take care of notification.
</Success>


#### Members of `ListSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `List<R> cast()` |  |
| **first** | `method` | `first(E val)` |  |
| **last** | `method` | `E last` |  |
| **last** | `method` | `last(E val)` |  |
| **length** | `method` | `length(int value)` |  |
| **+** | `method` | `List<E> +(List<E> other)` |  |
| **[]** | `method` | `E [](int index)` |  |
| **[]=** | `method` | `void []=(int index, E value)` |  |
| **add** | `method` | `void add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> iterable)` |  |
| **asMap** | `method` | `Map<int, E> asMap()` |  |
| **clear** | `method` | `void clear()` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **fillRange** | `method` | `void fillRange(int start, int end, [E? fillValue])` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **getRange** | `method` | `Iterable<E> getRange(int start, int end)` |  |
| **indexOf** | `method` | `int indexOf(E element, [int start = 0])` |  |
| **indexWhere** | `method` | `int indexWhere(bool Function(E element) test, [int start = 0])` |  |
| **insert** | `method` | `void insert(int index, E element)` |  |
| **insertAll** | `method` | `void insertAll(int index, Iterable<E> iterable)` |  |
| **lastIndexOf** | `method` | `int lastIndexOf(E element, [int? start])` |  |
| **lastIndexWhere** | `method` | `int lastIndexWhere(bool Function(E element) test, [int? start])` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAt** | `method` | `E removeAt(int index)` |  |
| **removeLast** | `method` | `E removeLast()` |  |
| **removeRange** | `method` | `void removeRange(int start, int end)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **replaceRange** | `method` | `void replaceRange(int start, int end, Iterable<E> replacements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **reversed** | `method` | `Iterable<E> reversed` |  |
| **setAll** | `method` | `void setAll(int index, Iterable<E> iterable)` |  |
| **setRange** | `method` | `void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])` |  |
| **shuffle** | `method` | `void shuffle([Random? random])` |  |
| **sort** | `method` | `void sort([int Function(E a, E b)? compare])` |  |
| **sorted** | `method` | `List<E> sorted([int Function(E a, E b)? compare])` | Return a new array that is sorted by the **compare** function |
| **sublist** | `method` | `List<E> sublist(int start, [int? end])` |  |

---
### class `SetSignalMixin`

A mixin that adds reactive <code>Set</code> methods and operations to a [Signal](/types/signal)
holding a **Set** value.

This mixin delegates all standard **Set** operations (such as mutations like <code>add</code>,
<code>remove</code>, <code>addAll</code>, <code>removeAll</code>, <code>retainAll</code>, and <code>clear</code>) to the underlying set,
while ensuring that any reads register a dependency and any mutations
automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>Set<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MySetSignal extends Signal<Set<int>>
    with IterableSignalMixin<int, Set<int>>, SetSignalMixin<int, Set<int>> {
  MySetSignal(super.internalValue);
}

void main() {
  final numbers = MySetSignal({1, 2, 3});

  effect(() {
    print('Elements: $numbers, Length: ${numbers.length}');
  }); // Prints: "Elements: {1, 2, 3}, Length: 3"

  // Adding an element (automatically calls set() and triggers updates)
  numbers.add(4); // Prints: "Elements: {1, 2, 3, 4}, Length: 4"

  // Removing an element (triggers updates)
  numbers.remove(1); // Prints: "Elements: {2, 3, 4}, Length: 3"
}
```

<Success>
Since mutations on <code>SetSignalMixin</code> notify listeners automatically, you do not
need to assign <code>numbers.value = ...</code> to force updates. Methods like <code>add</code>, <code>addAll</code>,
and <code>remove</code> take care of notification.
</Success>


#### Members of `SetSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `bool add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> elements)` |  |
| **cast** | `method` | `Set<R> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **containsAll** | `method` | `bool containsAll(Iterable<Object?> other)` |  |
| **difference** | `method` | `Set<E> difference(Set<Object?> other)` |  |
| **intersection** | `method` | `Set<E> intersection(Set<Object?> other)` |  |
| **lookup** | `method` | `E? lookup(Object? object)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAll** | `method` | `void removeAll(Iterable<Object?> elements)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **retainAll** | `method` | `void retainAll(Iterable<Object?> elements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **union** | `method` | `Set<E> union(Set<E> other)` |  |

---
### class `MapSignalMixin`

A mixin that adds reactive <code>Map</code> methods and operators directly to a [Signal](/types/signal).

This mixin delegates all standard **Map** operations (such as mutations like <code>[]=</code>, <code>clear</code>,
<code>remove</code>, and lookups like <code>containsKey</code>, <code>isEmpty</code>, <code>keys</code>, <code>values</code>) to the underlying
map value.

Every mutating operation automatically updates the signal and notifies its observers
(by forcing a change notification using <code>force: true</code>).

### Simple Example
```dart
class MyMapSignal<K, V> extends Signal<Map<K, V>>
    with MapSignalMixin<K, V, Map<K, V>> {
  MyMapSignal(super.value);
}

final cart = MyMapSignal<String, int>({'apple': 1});

// Register an effect reacting to cart changes
effect(() {
  print('Cart length: ${cart.length}');
});

// Treating it as a standard Map triggers updates automatically!
cart['banana'] = 3;  // Prints: Cart length: 2
cart.remove('apple'); // Prints: Cart length: 1
```


#### Members of `MapSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | `method` | `V? [](Object? key)` |  |
| **[]=** | `method` | `void []=(K key, V value)` |  |
| **addAll** | `method` | `void addAll(Map<K, V> other)` |  |
| **addEntries** | `method` | `void addEntries(Iterable<MapEntry<K, V>> newEntries)` |  |
| **cast** | `method` | `Map<RK, RV> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **containsKey** | `method` | `bool containsKey(Object? key)` |  |
| **containsValue** | `method` | `bool containsValue(Object? value)` |  |
| **entries** | `method` | `Iterable<MapEntry<K, V>> entries` |  |
| **forEach** | `method` | `void forEach(void Function(K key, V value) action)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **keys** | `method` | `Iterable<K> keys` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)` |  |
| **putIfAbsent** | `method` | `V putIfAbsent(K key, V Function() ifAbsent)` |  |
| **remove** | `method` | `V? remove(Object? key)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(K key, V value) test)` |  |
| **update** | `method` | `V update(K key, V Function(V value) update, {V Function()? ifAbsent})` |  |
| **updateAll** | `method` | `void updateAll(V Function(K key, V value) update)` |  |
| **values** | `method` | `Iterable<V> values` |  |
| **toMap** | `method` | `Map<K, V> toMap()` | Snapshot of **MapEntries** |

---
### class `QueueSignalMixin`

A mixin that adds reactive <code>Queue</code> methods and operations to a [Signal](/types/signal)
holding a **Queue** value.

This mixin delegates all standard **Queue** operations (such as mutations like <code>add</code>,
<code>addAll</code>, <code>addFirst</code>, <code>addLast</code>, <code>removeFirst</code>, <code>removeLast</code>, and <code>clear</code>) to the
underlying queue, while ensuring that any reads register a dependency and any
mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>Queue<T></strong>.
</Info>

### Example Usage

```dart
import 'dart:collection';
import 'package:signals/signals.dart';

class MyQueueSignal extends Signal<Queue<int>>
    with QueueSignalMixin<int, Queue<int>> {
  MyQueueSignal(super.internalValue);
}

void main() {
  final q = Queue<int>()..add(1);
  final signal = MyQueueSignal(q);

  effect(() {
    print('Queue elements: $signal, Length: ${signal.length}');
  }); // Prints: "Queue elements: {1}, Length: 1"

  // Adding to the front of the queue (triggers updates)
  signal.addFirst(0); // Prints: "Queue elements: {0, 1}, Length: 2"

  // Adding to the back of the queue (triggers updates)
  signal.addLast(2); // Prints: "Queue elements: {0, 1, 2}, Length: 3"

  // Removing from the front of the queue (triggers updates)
  final first = signal.removeFirst(); // Prints: "Queue elements: {1, 2}, Length: 2"
}
```

<Success>
Since mutations on <code>QueueSignalMixin</code> notify listeners automatically, you do not
need to assign <code>signal.value = ...</code> to force updates. Methods like <code>addFirst</code>,
<code>addLast</code>, <code>removeFirst</code>, and <code>removeLast</code> take care of notification.
</Success>


#### Members of `QueueSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `void add(T value)` |  |
| **addAll** | `method` | `void addAll(Iterable<T> iterable)` |  |
| **addFirst** | `method` | `void addFirst(T value)` |  |
| **addLast** | `method` | `void addLast(T value)` |  |
| **any** | `method` | `bool any(bool Function(T element) test)` |  |
| **cast** | `method` | `Queue<R> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **contains** | `method` | `bool contains(Object? element)` |  |
| **elementAt** | `method` | `T elementAt(int index)` |  |
| **every** | `method` | `bool every(bool Function(T element) test)` |  |
| **expand** | `method` | `Iterable<U> expand(Iterable<U> Function(T element) toElements)` |  |
| **first** | `method` | `T first` |  |
| **firstWhere** | `method` | `T firstWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **fold** | `method` | `U fold(U initialValue, U Function(U previousValue, T element) combine)` |  |
| **followedBy** | `method` | `Iterable<T> followedBy(Iterable<T> other)` |  |
| **forEach** | `method` | `void forEach(void Function(T element) action)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **iterator** | `method` | `Iterator<T> iterator` |  |
| **join** | `method` | `String join([String separator = ""])` |  |
| **last** | `method` | `T last` |  |
| **lastWhere** | `method` | `T lastWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Iterable<U> map(U Function(T e) toElement)` |  |
| **reduce** | `method` | `T reduce(T Function(T value, T element) combine)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeFirst** | `method` | `T removeFirst()` |  |
| **removeLast** | `method` | `T removeLast()` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(T element) test)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(T element) test)` |  |
| **single** | `method` | `T single` |  |
| **singleWhere** | `method` | `T singleWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **skip** | `method` | `Iterable<T> skip(int count)` |  |
| **skipWhile** | `method` | `Iterable<T> skipWhile(bool Function(T value) test)` |  |
| **take** | `method` | `Iterable<T> take(int count)` |  |
| **takeWhile** | `method` | `Iterable<T> takeWhile(bool Function(T value) test)` |  |
| **toList** | `method` | `List<T> toList({bool growable = true})` |  |
| **toSet** | `method` | `Set<T> toSet()` |  |
| **where** | `method` | `Iterable<T> where(bool Function(T element) test)` |  |
| **whereType** | `method` | `Iterable<U> whereType()` |  |

---
### mixin `TrackedSignalMixin`

A mixin that adds tracking for the initial and previous values to a [Signal](/types/signal).

[TrackedSignalMixin](/types/trackedsignalmixin) stores the <code>initialValue</code> (the value the signal had when it was
created or initialized) and the <code>previousValue</code> (the value of the signal right before
the most recent update).

<Info>
If you are looking for full undo/redo capabilities, use <a href="/types/changestacksignalmixin">ChangeStackSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyTrackedSignal extends Signal<int> with TrackedSignalMixin<int> {
  MyTrackedSignal(super.internalValue);
}

void main() {
  final signal = MyTrackedSignal(0);

  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: null"

  signal.value = 1;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 0"

  signal.value = 2;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 1"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned on mutation.
If the value is mutated directly in-place without re-assigning, <code>initialValue</code> and
<code>previousValue</code> will end up pointing to the same modified instance as the current value.
</Warning>


#### Members of `TrackedSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | `method` | `T initialValue` | The initial value the signal was created with |
| **previousValue** | `method` | `T? previousValue` | Get the previous value (if exists) |

---
### class `PersistedSignal`

A <code>Signal</code> whose value is persistently stored in a key-value database.

<code>PersistedSignal</code> allows application state (such as user preferences, theme options,
authentication tokens, and drafts) to automatically survive application restarts
without writing tedious boilerplate for manual loading and saving.

### Concrete Subclasses
For common primitive types, use the provided concrete classes:
- [PersistedBoolSignal](/types/persistedboolsignal) / [PersistedNullableBoolSignal](/types/persistednullableboolsignal)
- [PersistedIntSignal](/types/persistedintsignal) / [PersistedNullableIntSignal](/types/persistednullableintsignal)
- [PersistedDoubleSignal](/types/persisteddoublesignal) / [PersistedNullableDoubleSignal](/types/persistednullabledoublesignal)
- [PersistedNumSignal](/types/persistednumsignal) / [PersistedNullableNumSignal](/types/persistednullablenumsignal)
- [PersistedStringSignal](/types/persistedstringsignal) / [PersistedNullableStringSignal](/types/persistednullablestringsignal)
- [PersistedEnumSignal](/types/persistedenumsignal) / [PersistedNullableEnumSignal](/types/persistednullableenumsignal)

### Simple Usage Example
```dart
// 1. Create or obtain a key-value store adapter (like standard in-memory)
final localStore = SignalsInMemoryKeyValueStore();

// 2. Create the persisted signal with a unique key
final darkModeSignal = PersistedBoolSignal(
  false, // Fallback initial value
  key: 'settings.dark_mode',
  store: localStore,
);

// 3. The value is automatically loaded asynchronously on instantiation.
// Mutating the value synchronously schedules an async save under the hood:
darkModeSignal.value = true; // Automatically persisted to store
```

### Custom Serialization / Complex Objects
To persist complex objects (e.g. custom classes), subclass [PersistedSignal](/types/persistedsignal)
and override the **decode** and **encode** methods, or mixin [PersistedSignalMixin](/types/persistedsignalmixin)
on a custom [Signal](/types/signal) class.

```dart
class User {
  final String name;
  final int age;
  User(this.name, this.age);

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
  factory User.fromJson(Map<String, dynamic> json) => User(json['name'], json['age']);
}

class PersistedUserSignal extends PersistedSignal<User> {
  PersistedUserSignal(
    super.internalValue, {
    required super.key,
    required super.store,
  });

  @override
  User decode(String value) => User.fromJson(jsonDecode(value));

  @override
  String encode(User value) => jsonEncode(value.toJson());
}
```


#### Members of `PersistedSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedSignal** | `constructor` | `PersistedSignal(super.internalValue, {required this.key, required this.store, PersistedSignalOptions<T>? options, @Deprecated('Use options: PersistedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: PersistedSignalOptions(name: ...) instead') String? debugLabel, bool autoInit = true})` | Creates a new <code>PersistedSignal</code>. |
| **key** | `field` | `String key` |  |
| **store** | `field` | `SignalsKeyValueStore store` |  |

---
### mixin `PersistedSignalMixin`

A mixin that adds local persistence capabilities to a standard [Signal](/types/signal).

By mixing in <code>PersistedSignalMixin<T></code> on a <code>Signal<T></code> subclass, the signal
will automatically retrieve its stored state on boot and save its state whenever
<code>.value</code> is mutated.

Classes mixing in <code>PersistedSignalMixin<T></code> must implement:
- **key**: A unique identifier string for the key-value database.
- **store**: An implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

### Serialization Customization
By default, the mixin uses standard JSON parsing (<code>jsonDecode</code> / <code>jsonEncode</code>).
If your data type <code>T</code> is not natively supported by JSON, override:
- **decode** to convert the raw string value back into type <code>T</code>.
- **encode** to serialize type <code>T</code> into a string.


#### Members of `PersistedSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **key** | `method` | `String key` | The key to use for storing the value. |
| **store** | `method` | `SignalsKeyValueStore store` | The store to use for storing the value. |
| **loaded** | `field` | `bool loaded` | Whether the signal has been loaded from the store. |
| **init** | `method` | `Future<void> init()` | Initializes the signal by loading the value from the store. |
| **value** | `method` | `T value` |  |
| **value** | `method` | `value(T value)` |  |
| **load** | `method` | `Future<T> load()` | Loads the value from the store. |
| **save** | `method` | `Future<void> save(T value)` | Saves the value to the store. |
| **decode** | `method` | `T decode(String value)` | Decodes the value from a string. |
| **encode** | `method` | `String encode(T value)` | Encodes the value to a string. |

---
### class `PersistedSignalOptions`

Configuration options for a [PersistedSignal](/types/persistedsignal).


#### Members of `PersistedSignalOptions`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedSignalOptions** | `constructor` | `PersistedSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [PersistedSignalOptions](/types/persistedsignaloptions) instance. |
| **copyWith** | `method` | `PersistedSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |

---
### class `PersistedBoolSignal`

A <code>PersistedSignal</code> that stores a boolean value.


#### Members of `PersistedBoolSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedBoolSignal** | `constructor` | `PersistedBoolSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>BoolSignal</code>. |
| **decode** | `method` | `bool decode(String value)` |  |
| **encode** | `method` | `String encode(bool value)` |  |

---
### class `PersistedNullableBoolSignal`

A <code>PersistedSignal</code> that stores a nullable string value.


#### Members of `PersistedNullableBoolSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableBoolSignal** | `constructor` | `PersistedNullableBoolSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NullableBoolSignal</code>. |
| **decode** | `method` | `bool? decode(String value)` |  |
| **encode** | `method` | `String encode(bool? value)` |  |

---
### class `SignalsKeyValueStore`

An abstract class defining the persistence adapter contract for [PersistedSignal](/types/persistedsignal).

Implement this interface to bind <code>PersistedSignal</code> to your storage engine of
choice, such as local files, SQLite, SharedPreferences, Hive, or indexedDB.

### Example: Custom Shared Preferences Store (Flutter)
```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

class SharedPreferencesStore implements SignalsKeyValueStore {
  final SharedPreferences prefs;
  SharedPreferencesStore(this.prefs);

  @override
  Future<String?> getItem(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    await prefs.remove(key);
  }
}
```


#### Members of `SignalsKeyValueStore`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **setItem** | `method` | `Future<void> setItem(String key, String value)` | Sets an item in the store. |
| **getItem** | `method` | `Future<String?> getItem(String key)` | Gets an item from the store. |
| **removeItem** | `method` | `Future<void> removeItem(String key)` | Removes an item from the store. |
| **defaultStore** | `field` | `static SignalsKeyValueStore defaultStore` | The default store to be used if no store is provided. |

---
### class `SignalsInMemoryKeyValueStore`

An in-memory, volatile implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

This serves as a fallback engine and does not persist across restarts/reload.


#### Members of `SignalsInMemoryKeyValueStore`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **store** | `field` | `store` | The in-memory store. |
| **getItem** | `method` | `Future<String?> getItem(String key)` |  |
| **removeItem** | `method` | `Future<void> removeItem(String key)` |  |
| **setItem** | `method` | `Future<void> setItem(String key, String value)` |  |

---
### class `PersistedEnumSignal`

A <code>PersistedSignal</code> that stores an enum value.


#### Members of `PersistedEnumSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedEnumSignal** | `constructor` | `PersistedEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})` | Creates a new <code>EnumSignal</code>. |
| **values** | `field` | `List<T> values` |  |
| **decode** | `method` | `T decode(String value)` |  |
| **encode** | `method` | `String encode(T value)` |  |

---
### class `PersistedNullableEnumSignal`

A <code>PersistedSignal</code> that stores a nullable enum value.


#### Members of `PersistedNullableEnumSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableEnumSignal** | `constructor` | `PersistedNullableEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})` | Creates a new <code>NullableEnumSignal</code>. |
| **values** | `field` | `List<T> values` |  |
| **decode** | `method` | `T? decode(String value)` |  |
| **encode** | `method` | `String encode(T? value)` |  |

---
### class `PersistedNumSignal`

A <code>PersistedSignal</code> that stores a numeric value.


#### Members of `PersistedNumSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNumSignal** | `constructor` | `PersistedNumSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NumSignal</code>. |
| **decode** | `method` | `num decode(String value)` |  |
| **encode** | `method` | `String encode(num value)` |  |

---
### class `PersistedNullableNumSignal`

A <code>PersistedSignal</code> that stores a nullable numeric value.


#### Members of `PersistedNullableNumSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableNumSignal** | `constructor` | `PersistedNullableNumSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NullableNumSignal</code>. |
| **decode** | `method` | `num? decode(String value)` |  |
| **encode** | `method` | `String encode(num? value)` |  |

---
### class `PersistedIntSignal`

A <code>PersistedSignal</code> that stores an integer value.


#### Members of `PersistedIntSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedIntSignal** | `constructor` | `PersistedIntSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>IntSignal</code>. |
| **decode** | `method` | `int decode(String value)` |  |
| **encode** | `method` | `String encode(int value)` |  |

---
### class `PersistedNullableIntSignal`

A <code>PersistedSignal</code> that stores a nullable integer value.


#### Members of `PersistedNullableIntSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableIntSignal** | `constructor` | `PersistedNullableIntSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NullableIntSignal</code>. |
| **decode** | `method` | `int? decode(String value)` |  |
| **encode** | `method` | `String encode(int? value)` |  |

---
### class `PersistedStringSignal`

A <code>PersistedSignal</code> that stores a string value.


#### Members of `PersistedStringSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedStringSignal** | `constructor` | `PersistedStringSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>StringSignal</code>. |
| **decode** | `method` | `String decode(String value)` |  |
| **encode** | `method` | `String encode(String value)` |  |

---
### class `PersistedNullableStringSignal`

A <code>PersistedSignal</code> that stores a nullable string value.

> [!warning] An empty value is considered null


#### Members of `PersistedNullableStringSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableStringSignal** | `constructor` | `PersistedNullableStringSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NullableStringSignal</code>. |
| **decode** | `method` | `String? decode(String value)` |  |
| **encode** | `method` | `String encode(String? value)` |  |

---
### class `PersistedDoubleSignal`

A <code>PersistedSignal</code> that stores an double value.


#### Members of `PersistedDoubleSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedDoubleSignal** | `constructor` | `PersistedDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>DoubleSignal</code>. |
| **decode** | `method` | `double decode(String value)` |  |
| **encode** | `method` | `String encode(double value)` |  |

---
### class `PersistedNullableDoubleSignal`

A <code>PersistedSignal</code> that stores a nullable double value.


#### Members of `PersistedNullableDoubleSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableDoubleSignal** | `constructor` | `PersistedNullableDoubleSignal(super.val, String key, {SignalsKeyValueStore? store})` | Creates a new <code>NullableDoubleSignal</code>. |
| **decode** | `method` | `double? decode(String value)` |  |
| **encode** | `method` | `String encode(double? value)` |  |

---
