---
title: Action
description: Wraps a callback function into a reusable, batched, and untracked action.
---

Wraps a callback function into a reusable, batched, and untracked action.

An **action** is a higher-order function that takes a callback and returns a new function
with the exact same signature. When the returned function is executed, it runs the original
callback inside both a [batch](/types/batch) and an [untracked](/types/untracked) block.

### Why use <code>action</code> instead of <code>batch</code>?

1. **Reusability**: <code>batch(fn)</code> executes the callback immediately. In contrast, <code>action(fn)</code>
   returns a *reusable function* that you can store, pass around, and invoke multiple times
   to perform batch transactions on demand.
2. **Untracked Execution**: The callback runs inside <code>untracked</code>. If you invoke the action
   from within an <code>effect</code> or a <code>computed</code> signal, the outer reactive context **will not**
   establish subscriptions to any signals read inside the action.

---

### Example: Comparing Normal Updates vs. Action Batching

#### Without Actions (Standard Sequential Updates)

Every signal write immediately notifies active subscribers. This causes transient states
and redundant, intermediate executions:

```dart
import 'package:preact_signals/preact_signals.dart';

final a = signal('a');
final b = signal('b');

void main() {
  // Set up a subscriber effect
  effect(() => print('${a.value} ${b.value}'));
  // Prints immediately: "a b"

  a.value = 'aa'; // Prints: "aa b"
  b.value = 'bb'; // Prints: "aa bb"
}
```
Total prints: **3** (initial execution + 2 updates).

#### With Actions (Coalesced Transaction)

By wrapping the state-mutating function in [action](/types/action), all updates are postponed and flushed
in a single notification block once the function completes:

```dart
import 'package:preact_signals/preact_signals.dart';

final a = signal('a');
final b = signal('b');

// Create a reusable action
final updateFields = action((String nextA, String nextB) {
  a.value = nextA;
  b.value = nextB;
});

void main() {
  effect(() => print('${a.value} ${b.value}'));
  // Prints immediately: "a b"

  updateFields('aa', 'bb');
  // The effect is deferred during execution and triggers exactly once at the end.
  // Prints: "aa bb"
}
```
Total prints: **2** (initial execution + 1 coalesced update).

---

### Type-Safety & Extensions

While <code>action</code> accepts any generic <code>Function</code>, Dart's static analysis benefits greatly from
type-safe variants or extensions.

- **Type-safe functions**: Use <code>action0</code> through <code>action10</code> (e.g. <code>action2(...)</code> for 2 arguments) to preserve type arguments.
- **Extensions**: Call <code>.action</code> directly on any Dart function (e.g., <code>myFunction.action</code>).


---

## Type-Safe Variants & Extensions

To ensure complete type safety and optimize static analysis in Dart, the package exposes distinct variants and extension methods corresponding to the number of arguments (from 0 up to 10):

| Variant / Extension | Description |
| --- | --- |
| `action0` | Wraps a 0-argument callback function in a type-safe action. <br/> `signature` |
| `action1` | Wraps a 1-argument callback function in a type-safe action. <br/> `signature` |
| `action2` | Wraps a 2-argument callback function in a type-safe action. <br/> `signature` |
| `action3` | Wraps a 3-argument callback function in a type-safe action. <br/> `signature` |
| `action4` | Wraps a 4-argument callback function in a type-safe action. <br/> `signature` |
| `action5` | Wraps a 5-argument callback function in a type-safe action. <br/> `signature` |
| `action6` | Wraps a 6-argument callback function in a type-safe action. <br/> `signature` |
| `action7` | Wraps a 7-argument callback function in a type-safe action. <br/> `signature` |
| `action8` | Wraps an 8-argument callback function in a type-safe action. <br/> `signature` |
| `action9` | Wraps a 9-argument callback function in a type-safe action. <br/> `signature` |
| `action10` | Wraps a 10-argument callback function in a type-safe action. <br/> `signature` |
| `ActionExt0` | Extension on a 0-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt1` | Extension on a 1-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt2` | Extension on a 2-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt3` | Extension on a 3-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt4` | Extension on a 4-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt5` | Extension on a 5-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt6` | Extension on a 6-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt7` | Extension on a 7-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt8` | Extension on an 8-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt9` | Extension on a 9-argument function to wrap it in a type-safe action. <br/> `signature` |
| `ActionExt10` | Extension on a 10-argument function to wrap it in a type-safe action. <br/> `signature` |

<details>
<summary>Show Full API Signatures & Examples</summary>

### action0

Wraps a 0-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final increment = action0(() {
  count.value++;
  clicks.value++;
});
```

---

### action1

Wraps a 1-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setName = action1((String newName) {
  name.value = newName;
  updatedAt.value = DateTime.now();
});
```

---

### action2

Wraps a 2-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final updateProfile = action2((String newName, int newAge) {
  name.value = newName;
  age.value = newAge;
});
```

---

### action3

Wraps a 3-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setCoordinates = action3((double lat, double lng, String label) {
  latitude.value = lat;
  longitude.value = lng;
  locationName.value = label;
});
```

---

### action4

Wraps a 4-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final updateUserData = action4((String name, int age, double score, bool active) {
  userName.value = name;
  userAge.value = age;
  userScore.value = score;
  userActive.value = active;
});
```

---

### action5

Wraps a 5-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setConfig = action5((int w, int h, String title, bool dark, double opacity) {
  width.value = w;
  height.value = h;
  appTitle.value = title;
  themeDark.value = dark;
  bgOpacity.value = opacity;
});
```

---

### action6

Wraps a 6-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

### action7

Wraps a 7-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

### action8

Wraps an 8-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

### action9

Wraps a 9-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

### action10

Wraps a 10-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

### ActionExt0

Extension on a 0-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 0-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final clicks = signal(0);

void incrementCount() {
  count.value++;
  clicks.value++;
}

// Create a batched, untracked action from the function
final increment = incrementCount.action;

void main() {
  effect(() => print('Count: ${count.value}, Clicks: ${clicks.value}'));
  // Prints: "Count: 0, Clicks: 0"

  increment();
  // Updates both count and clicks inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Count: 1, Clicks: 1"
}
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function() action`

Wraps the 0-argument function in a type-safe action.

</details>


---

### ActionExt1

Extension on a 1-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 1-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final name = signal('Jane');
final clicks = signal(0);

void updateName(String newName) {
  name.value = newName;
  clicks.value++;
}

// Create a batched, untracked action from the function
final setName = updateName.action;

void main() {
  effect(() => print('Name: ${name.value}, Clicks: ${clicks.value}'));
  // Prints: "Name: Jane, Clicks: 0"

  setName('John');
  // Updates both name and clicks inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Name: John, Clicks: 1"
}
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A) action`

Wraps the 1-argument function in a type-safe action.

</details>


---

### ActionExt2

Extension on a 2-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 2-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final name = signal('Jane');
final age = signal(25);

void updateProfile(String newName, int newAge) {
  name.value = newName;
  age.value = newAge;
}

// Create a batched, untracked action from the function
final setProfile = updateProfile.action;

void main() {
  effect(() => print('Name: ${name.value}, Age: ${age.value}'));
  // Prints: "Name: Jane, Age: 25"

  setProfile('John', 30);
  // Updates both name and age inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Name: John, Age: 30"
}
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B) action`

Wraps the 2-argument function in a type-safe action.

</details>


---

### ActionExt3

Extension on a 3-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 3-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final latitude = signal(0.0);
final longitude = signal(0.0);
final locationName = signal('Unknown');

void setCoordinates(double lat, double lng, String label) {
  latitude.value = lat;
  longitude.value = lng;
  locationName.value = label;
}

// Create a batched, untracked action from the function
final setCoords = setCoordinates.action;

void main() {
  effect(() => print('${locationName.value}: (${latitude.value}, ${longitude.value})'));
  // Prints: "Unknown: (0.0, 0.0)"

  setCoords(37.7749, -122.4194, 'San Francisco');
  // Updates latitude, longitude, and locationName inside a batch.
  // Triggers the effect exactly once.
  // Prints: "San Francisco: (37.7749, -122.4194)"
}
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C) action`

Wraps the 3-argument function in a type-safe action.

</details>


---

### ActionExt4

Extension on a 4-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D) action`

Wraps the 4-argument function in a type-safe action.

</details>


---

### ActionExt5

Extension on a 5-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E) action`

Wraps the 5-argument function in a type-safe action.

</details>


---

### ActionExt6

Extension on a 6-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E, F) action`

Wraps the 6-argument function in a type-safe action.

</details>


---

### ActionExt7

Extension on a 7-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E, F, G) action`

Wraps the 7-argument function in a type-safe action.

</details>


---

### ActionExt8

Extension on an 8-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E, F, G, H) action`

Wraps the 8-argument function in a type-safe action.

</details>


---

### ActionExt9

Extension on a 9-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E, F, G, H, I) action`

Wraps the 9-argument function in a type-safe action.

</details>


---

### ActionExt10

Extension on a 10-argument function to wrap it in a type-safe action.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="action"></a>`R Function(A, B, C, D, E, F, G, H, I, J) action`

Wraps the 10-argument function in a type-safe action.

</details>


---

</details>
