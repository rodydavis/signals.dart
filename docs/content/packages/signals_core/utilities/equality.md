---
title: SignalEquality
description: Defines the equality check algorithm used by signals to determine if a new value.
---

Defines the equality check algorithm used by signals to determine if a new value
actually differs from the current value.

By default, signals use standard Dart operator equality (<code>==</code>). However, you can configure
a signal to use different strategies, such as deep equality check for collections or custom comparator checks.

Strategies:
- **standard**: Default value equality (<code>a == b</code>).
- **identity**: Identity-based comparison (<code>identical(a, b)</code>).
- **deep**: Deep collection comparison for Lists, Maps, and Sets.
- **custom**: User-defined boolean comparison function.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  // Create a list signal using deep equality check
  final items = signal(
    [1, 2, 3],
    options: SignalOptions(
      equality: SignalEquality.deep(),
    ),
  );

  effect(() {
    print('Items changed: ${items.value}');
  });

  // Reassigning an identical value structure does NOT trigger a rebuild!
  items.value = [1, 2, 3];

  // Triggers rebuild
  items.value = [1, 2, 3, 4];
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalequality"></a><a name="signalequality"></a><code>SignalEquality()</code>

@nodoc

##### <a name="signalequality-custom"></a><a name="custom"></a><code>SignalEquality.custom(bool Function(T a, T b) fn)</code>

Custom equality check

Uses a user-provided boolean function **fn** to check for equality.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equals"></a><code>bool equals(Object? a, Object? b)</code>

Check if two values are equal

##### <a name="standard"></a><code>static SignalEquality<T> standard()</code>

Standard equality check (a == b)

Matches two objects if their standard <code>==</code> operator returns true.
This is the default strategy used by all signals.

##### <a name="identity"></a><code>static SignalEquality<T> identity()</code>

Identity equality check (identical(a, b))

Matches two objects only if they are the exact same instance in memory.

##### <a name="deep"></a><code>static SignalEquality<T> deep()</code>

Deep equality check

Matches collections (Lists, Maps, Sets) recursively by comparing their items.

</details>



---

## SignalIdentityEquality

Identity equality check (identical(a, b))

Matches two objects only if they point to the exact same instance in memory.

### Example Usage

```dart
final listA = [1, 2];
final listB = [1, 2];
final equality = SignalEquality.identity<List<int>>();
print(equality.equals(listA, listB)); // false
print(equality.equals(listA, listA)); // true
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalidentityequality"></a><a name="signalidentityequality"></a><code>SignalIdentityEquality()</code>

Creates a new [SignalIdentityEquality](/types/signalidentityequality) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equals"></a><code>bool equals(Object? a, Object? b)</code>

</details>



---

## SignalDeepEquality

Deep equality check for collections

Recursively compares Lists, Maps, and Sets to see if their nested elements are equal.

### Example Usage

```dart
final equality = SignalEquality.deep();
print(equality.equals([1, [2, 3]], [1, [2, 3]])); // true
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaldeepequality"></a><a name="signaldeepequality"></a><code>SignalDeepEquality()</code>

Creates a new [SignalDeepEquality](/types/signaldeepequality) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equals"></a><code>bool equals(Object? a, Object? b)</code>

</details>



---

## SignalCustomEquality

Custom equality check using a custom function

Uses a custom comparison function to determine if two values of type **T** are equal.

### Example Usage

```dart
final equality = SignalEquality.custom((User a, User b) => a.id == b.id);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalcustomequality"></a><a name="signalcustomequality"></a><code>SignalCustomEquality(this._fn)</code>

Creates a new [SignalCustomEquality](/types/signalcustomequality) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equals"></a><code>bool equals(Object? a, Object? b)</code>

</details>



---

## SignalStandardEquality

Standard equality check (a == b)

Matches two objects using the standard Dart operator <code>==</code>.

### Example Usage

```dart
final equality = SignalEquality.standard<int>();
print(equality.equals(5, 5)); // true
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalstandardequality"></a><a name="signalstandardequality"></a><code>SignalStandardEquality()</code>

Creates a new [SignalStandardEquality](/types/signalstandardequality) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equals"></a><code>bool equals(Object? a, Object? b)</code>

</details>
