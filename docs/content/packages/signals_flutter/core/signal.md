---
title: Signal
description: Represents a mutable reactive state container that sits at the foundation of the reactivity system.
---

Represents a mutable reactive state container that sits at the foundation of the reactivity system.

Signals hold a single, mutable **value** that can be read or modified. When a signal's value
is updated, any active computations (like [Computed](/types/computed)) or effects (like [effect](/types/effect)) that
read the signal's value inside their execution context are automatically notified and scheduled to re-run.

Under the hood, this establishes a reactive dependency graph where reading a signal registers the reader as a
"target", and updating a signal triggers direct, glitch-free propagation to all registered targets.

<Info>
  Accessing <code>.value</code> inside a reactive context (like <code>effect</code> or <code>computed</code>) registers a dependency. Reading a value
  outside a reactive context behaves like a standard getter without creating a subscription.
</Info>

### Example Usage

#### 1. Basic Reactive Flow
```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final count = Signal(0);

  // The effect automatically subscribes to count.value
  effect(() {
    print('Count is: ${count.value}');
  });

  count.value = 5; // Triggers print: Count is: 5
}
```

#### 2. Controlling Subscriptions via <code>.peek()</code>
If you need to read a signal's value without subscribing to updates, use the <code>.peek()</code> method:
```dart
final count = Signal(0);
final threshold = Signal(10);

effect(() {
  // Subscribes to count, but NOT to threshold
  if (count.value >= threshold.peek()) {
    print('Threshold reached!');
  }
});
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signal"></a><a name="signal"></a><code>Signal(this._internalValue, {String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code>

Creates a new [Signal](/types/signal) instance with the given initial value.

You can optionally provide:
- A **name** for debugging/observer tracing.
- **watched**/**unwatched** hooks triggered when the signal gains its first subscriber or loses its last subscriber.
- **equality** checking callback to customize how value modifications are compared.

```dart
final count = Signal(0, name: 'counter_signal');
```

##### <a name="signal-lazy"></a><a name="lazy"></a><code>Signal.lazy({String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code>

Creates a new lazy [Signal](/types/signal) instance that is computed on-demand upon first read.

<Warning>
  Reading a lazy signal before a value has been explicitly set or assigned via <code>.value = ...</code> or <code>.set(...)</code>
  will throw a runtime initialization exception.
</Warning>

```dart
final lazyUser = Signal<User>.lazy(name: 'lazy_user');

// Throws error:
// print(lazyUser.value);

lazyUser.value = User(id: 1, name: 'John'); // Initialized successfully
print(lazyUser.value); // Safe to read now
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="globalid"></a><code>int globalId</code>

##### <a name="name"></a><code>String? name</code>

##### <a name="watched"></a><code>void Function()? watched</code>

##### <a name="unwatched"></a><code>void Function()? unwatched</code>

##### <a name="version"></a><code>int version</code>

Version numbers should always be >= 0, because the special value -1 is used
by Nodes to signify potentially unused but recyclable nodes.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equalitycheck"></a><code>SignalEquality<T> equalityCheck</code>

Get the active equality check

##### <a name="isinitialized"></a><code>bool isInitialized</code>

Check if the value is set and not a lazy signal

##### <a name="internalvalue"></a><code>T internalValue</code>

##### <a name="internalrefresh"></a><code>bool internalRefresh()</code>

##### <a name="subscribetonode"></a><code>void subscribeToNode(Node node)</code>

##### <a name="unsubscribefromnode"></a><code>void unsubscribeFromNode(Node node)</code>

##### <a name="subscribe"></a><code>void Function() subscribe(void Function(T value) fn)</code>

##### <a name="value"></a><code>T value</code>

Gets the current value of the signal.

If read inside an active reactive context (e.g., an [effect](/types/effect) or [computed](/types/computed) signal),
the calling context automatically subscribes to updates of this signal.

##### <a name="value"></a><code>value(T val)</code>

Sets the current value of the signal.

If the new value is not equal to the existing value (based on **equalityCheck**), the
signal's version is incremented and all active downstream subscribers (computeds/effects)
are synchronously notified to re-evaluate.

##### <a name="set"></a><code>bool set(T val, {bool force = false})</code>

Updates the signal's value by method call.

Under normal conditions, this only notifies subscribers if the new value is different
from the current value.

Set **force** to <code>true</code> to bypass standard equality checks and notify downstream subscribers
unconditionally. This is useful when working with mutable collections or class instances where
properties change in-place but the object reference remains identical.

```dart
final numbers = Signal([1, 2, 3]);
numbers.value.add(4); // In-place modification
numbers.set(numbers.value, force: true); // Force notify downstream subscribers
```

</details>



---

## ReadonlySignalOptions

Configuration options for a [ReadonlySignal](/types/readonlysignal).

Allows intercepting the signal's active subscription state changes
via **watched** and **unwatched** callback event listeners. This is extremely useful
for initiating or canceling active background fetching, web sockets, or timer loops.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final stockTicker = signal(
  0.0,
  options: ReadonlySignalOptions(
    name: 'stock-ticker',
    watched: () => print('Stock Ticker is actively being listened to!'),
    unwatched: () => print('No more listeners, sleeping the ticker.'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="readonlysignaloptions"></a><a name="readonlysignaloptions"></a><code>ReadonlySignalOptions({super.name, this.watched, this.unwatched})</code>

Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="watched"></a><code>void Function()? watched</code>

Callback called when the signal goes from 0 to >=1 listeners.

##### <a name="unwatched"></a><code>void Function()? unwatched</code>

Callback called when the signal goes from >=1 to 0 listeners.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ReadonlySignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

Creates a copy of this options with custom overrides.

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SetSignalExtension

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a><code>bool add(E value)</code>

##### <a name="addall"></a><code>void addAll(Iterable<E> elements)</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="remove"></a><code>bool remove(Object? value)</code>

##### <a name="removeall"></a><code>void removeAll(Iterable<Object?> elements)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(E element) test)</code>

##### <a name="retainall"></a><code>void retainAll(Iterable<Object?> elements)</code>

##### <a name="retainwhere"></a><code>void retainWhere(bool Function(E element) test)</code>

</details>



---

## ComputedOptions

Configuration options for a [Computed](/types/computed) signal.

Enables configuring debugging names and subscription state event listeners
for computed derivations.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final doubleCount = computed(
  () => count.value * 2,
  options: ComputedOptions(
    name: 'double-count',
    watched: () => print('Computed doubleCount is active'),
    unwatched: () => print('Computed doubleCount is inactive'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="computedoptions"></a><a name="computedoptions"></a><code>ComputedOptions({super.name, super.watched, super.unwatched})</code>

Creates a new [ComputedOptions](/types/computedoptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ComputedOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SignalOptions

Configuration options for a [Signal](/types/signal).

Extends [ReadonlySignalOptions](/types/readonlysignaloptions) to also support custom **equality** checkers,
which control whether incoming values trigger update events.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final items = signal(
  [1, 2, 3],
  options: SignalOptions(
    name: 'item-list',
    equality: SignalEquality.deep(),
    watched: () => print('Items watch active'),
    unwatched: () => print('Items watch inactive'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaloptions"></a><a name="signaloptions"></a><code>SignalOptions({super.name, super.watched, super.unwatched, SignalEquality<T>? equality})</code>

Creates a new [SignalOptions](/types/signaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equalitycheck"></a><code>SignalEquality<T> equalityCheck</code>

Get the active equality check

##### <a name="copywith"></a><code>SignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## EffectOptions

Configuration options for reactive [Effect](/types/effect)s.

Permits naming the effect for debugging, performance profiling,
and tracing within the signals developer tools.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

final logger = effect(
  () => print('Count changed to: ${count.value}'),
  options: const EffectOptions(name: 'counter-logger'),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="effectoptions"></a><a name="effectoptions"></a><code>EffectOptions({super.name})</code>

Creates a new [EffectOptions](/types/effectoptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>EffectOptions copyWith({String? name})</code>

Creates a copy of this options with custom overrides.

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## BoolSignalExtension

Helper extensions for [ReadonlySignal<bool>](/types/readonlysignal), enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations.

```dart
import 'package:signals_core/signals_core.dart';

final a = true.$;
final b = false.$;
final andResult = a & b.value; // false
final orResult = a | b.value; // true
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="&"></a><code>bool &(bool other)</code>

The logical conjunction ("and") of this and **other**.

Returns <code>true</code> if both this and **other** are <code>true</code>, and <code>false</code> otherwise.

##### <a name="|"></a><code>bool |(bool other)</code>

The logical disjunction ("inclusive or") of this and **other**.

Returns <code>true</code> if either this or **other** is <code>true</code>, and <code>false</code> otherwise.

##### <a name="^"></a><code>bool ^(bool other)</code>

The logical exclusive disjunction ("exclusive or") of this and **other**.

Returns whether this and **other** are neither both <code>true</code> nor both <code>false</code>.

</details>



---

## NumSignalExtension

Helper extensions for [ReadonlySignal<num>](/types/readonlysignal), providing convenient reactive math and comparison operations without needing to manually unwrap <code>.value</code>.

```dart
import 'package:signals_core/signals_core.dart';

final a = 5.0.$;
final sum = a + 3; // 8.0 (evaluates reactively)
final isGreater = a > 4; // true
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="+"></a><code>num +(num other)</code>

Adds **other** to this number.

The result is an **int**, as described by [int.+],
if both this number and **other** is an integer,
otherwise the result is a **double**.

##### <a name="-"></a><code>num -(num other)</code>

Subtracts **other** from this number.

The result is an **int**, as described by **int.-**,
if both this number and **other** is an integer,
otherwise the result is a **double**.

##### <a name="*"></a><code>num *(num other)</code>

Multiplies this number by **other**.

The result is an **int**, as described by [int.*],
if both this number and **other** are integers,
otherwise the result is a **double**.

##### <a name="%"></a><code>num %(num other)</code>

Euclidean modulo of this number by **other**.

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
```

##### <a name="/"></a><code>double /(num other)</code>

Divides this number by **other**.

##### <a name="~/"></a><code>int ~/(num other)</code>

Truncating division operator.

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
must be a finite integer (not an infinity or **double.nan**).

##### <a name="-"></a><code>num -()</code>

The negation of this value.

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
but with a few edge case exceptions).

##### <a name="remainder"></a><code>num remainder(num other)</code>

The remainder of the truncating division of <code>this</code> by **other**.

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
```

##### <a name="<"></a><code>bool <(num other)</code>

Whether this number is numerically smaller than **other**.

Returns <code>true</code> if this number is smaller than **other**.
Returns <code>false</code> if this number is greater than or equal to **other**
or if either value is a NaN value like **double.nan**.

##### <a name="<="></a><code>bool <=(num other)</code>

Whether this number is numerically smaller than or equal to **other**.

Returns <code>true</code> if this number is smaller than or equal to **other**.
Returns <code>false</code> if this number is greater than **other**
or if either value is a NaN value like **double.nan**.

##### <a name=">"></a><code>bool >(num other)</code>

Whether this number is numerically greater than **other**.

Returns <code>true</code> if this number is greater than **other**.
Returns <code>false</code> if this number is smaller than or equal to **other**
or if either value is a NaN value like **double.nan**.

##### <a name=">="></a><code>bool >=(num other)</code>

Whether this number is numerically greater than or equal to **other**.

Returns <code>true</code> if this number is greater than or equal to **other**.
Returns <code>false</code> if this number is smaller than **other**
or if either value is a NaN value like **double.nan**.

##### <a name="isnan"></a><code>bool isNaN</code>

Whether this number is a Not-a-Number value.

Is <code>true</code> if this number is the **double.nan** value
or any other of the possible **double** NaN values.
Is <code>false</code> if this number is an integer,
a finite double or an infinite double (**double.infinity**
or **double.negativeInfinity**).

All numbers satisfy exactly one of **isInfinite**, **isFinite**
and <code>isNaN</code>.

##### <a name="isnegative"></a><code>bool isNegative</code>

Whether this number is negative.

A number is negative if it's smaller than zero,
or if it is the double <code>-0.0</code>.
This precludes a NaN value like **double.nan** from being negative.

##### <a name="isinfinite"></a><code>bool isInfinite</code>

Whether this number is positive infinity or negative infinity.

Only satisfied by **double.infinity** and **double.negativeInfinity**.

All numbers satisfy exactly one of <code>isInfinite</code>, **isFinite**
and **isNaN**.

##### <a name="isfinite"></a><code>bool isFinite</code>

Whether this number is finite.

The only non-finite numbers are NaN values, positive infinity, and
negative infinity. All integers are finite.

All numbers satisfy exactly one of **isInfinite**, <code>isFinite</code>
and **isNaN**.

##### <a name="abs"></a><code>num abs()</code>

The absolute value of this number.

The absolute value is the value itself, if the value is non-negative,
and <code>-value</code> if the value is negative.

Integer overflow may cause the result of <code>-value</code> to stay negative.

```dart
print((2).abs()); // 2
print((-2.5).abs()); // 2.5
```

##### <a name="sign"></a><code>num sign</code>

Negative one, zero or positive one depending on the sign and
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
for all numbers <code>n</code> (except NaN, because NaN isn't <code>==</code> to itself).

##### <a name="round"></a><code>int round()</code>

The integer closest to this number.

Rounds away from zero when there is no closest integer:
 <code>(3.5).round() == 4</code> and <code>(-3.5).round() == -4</code>.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer.

##### <a name="floor"></a><code>int floor()</code>

The greatest integer no greater than this number.

Rounds fractional values towards negative infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer.

##### <a name="ceil"></a><code>int ceil()</code>

The least integer no smaller than <code>this</code>.

Rounds fractional values towards positive infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer.

##### <a name="truncate"></a><code>int truncate()</code>

The integer obtained by discarding any fractional digits from <code>this</code>.

Rounds fractional values towards zero.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer.

##### <a name="roundtodouble"></a><code>double roundToDouble()</code>

The double integer value closest to this value.

Rounds away from zero when there is no closest integer:
 <code>(3.5).roundToDouble() == 4</code> and <code>(-3.5).roundToDouble() == -4</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>,
and <code>-0.0</code> is therefore considered closer to negative numbers than <code>0.0</code>.
This means that for a value <code>d</code> in the range <code>-0.5 < d < 0.0</code>,
the result is <code>-0.0</code>.

##### <a name="floortodouble"></a><code>double floorToDouble()</code>

Returns the greatest double integer value no greater than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>0.0 < d < 1.0</code> will return <code>0.0</code>.

##### <a name="ceiltodouble"></a><code>double ceilToDouble()</code>

Returns the least double integer value no smaller than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>.

##### <a name="truncatetodouble"></a><code>double truncateToDouble()</code>

Returns the double integer value obtained by discarding any fractional
digits from the double value of <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>, and
in the range <code>0.0 < d < 1.0</code> it will return 0.0.

##### <a name="clamp"></a><code>num clamp(num lowerLimit, num upperLimit)</code>

Returns this **num** clamped to be in the range **lowerLimit**-**upperLimit**.

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
```

##### <a name="toint"></a><code>int toInt()</code>

Truncates this **num** to an integer and returns the result as an **int**.

Equivalent to **truncate**.

##### <a name="todouble"></a><code>double toDouble()</code>

This number as a **double**.

If an integer number is not precisely representable as a **double**,
an approximation is returned.

##### <a name="tostringasfixed"></a><code>String toStringAsFixed(int fractionDigits)</code>

A decimal-point string-representation of this number.

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
```

##### <a name="tostringasexponential"></a><code>String toStringAsExponential([int? fractionDigits])</code>

An exponential string-representation of this number.

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
```

##### <a name="tostringasprecision"></a><code>String toStringAsPrecision(int precision)</code>

A string representation with **precision** significant digits.

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
```

</details>



---

## DoubleSignalExtension

Helper extensions for [ReadonlySignal<double>](/types/readonlysignal), enabling direct reactive arithmetic and rounding operations on double signals.

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 2.5.$;
final rounded = doubleSignal.round(); // 3
final negated = -doubleSignal; // -2.5
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="remainder"></a><code>double remainder(num other)</code>

Returns the remainder of this value divided by **other**.

##### <a name="+"></a><code>double +(num other)</code>

Returns the sum of this value and **other**.

##### <a name="-"></a><code>double -(num other)</code>

Returns the difference of this value and **other**.

##### <a name="*"></a><code>double *(num other)</code>

Returns the product of this value and **other**.

##### <a name="%"></a><code>double %(num other)</code>

Returns the modulo of this value and **other**.

##### <a name="/"></a><code>double /(num other)</code>

Returns the division of this value and **other**.

##### <a name="~/"></a><code>int ~/(num other)</code>

Returns the truncating division of this value and **other**.

##### <a name="-"></a><code>double -()</code>

Returns the negation of this value.

##### <a name="abs"></a><code>double abs()</code>

Returns the absolute value of this value.

##### <a name="sign"></a><code>double sign</code>

The sign of the double's numerical value.

Returns -1.0 if the value is less than zero,
+1.0 if the value is greater than zero,
and the value itself if it is -0.0, 0.0 or NaN.

##### <a name="round"></a><code>int round()</code>

Returns the integer closest to this number.

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
```

##### <a name="floor"></a><code>int floor()</code>

Returns the greatest integer no greater than this number.

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
```

##### <a name="ceil"></a><code>int ceil()</code>

Returns the least integer that is not smaller than this number.

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
```

##### <a name="truncate"></a><code>int truncate()</code>

Returns the integer obtained by discarding any fractional
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
```

##### <a name="roundtodouble"></a><code>double roundToDouble()</code>

Returns the integer double value closest to <code>this</code>.

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
```

##### <a name="floortodouble"></a><code>double floorToDouble()</code>

Returns the greatest integer double value no greater than <code>this</code>.

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
```

##### <a name="ceiltodouble"></a><code>double ceilToDouble()</code>

Returns the least integer double value no smaller than <code>this</code>.

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
```

##### <a name="truncatetodouble"></a><code>double truncateToDouble()</code>

Returns the integer double value obtained by discarding any fractional
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
```

</details>



---

## ReadonlySetSignalExtension

Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively.

```dart
import 'package:signals_core/signals_core.dart';

final setA = {1, 2, 3}.$;
final setB = {3, 4, 5}.$;
final diff = computed(() => setA.difference(setB.value)); // {1, 2}
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="cast"></a><code>Set<R> cast()</code>

##### <a name="containsall"></a><code>bool containsAll(Iterable<Object?> other)</code>

##### <a name="difference"></a><code>Set<E> difference(Set<Object?> other)</code>

##### <a name="intersection"></a><code>Set<E> intersection(Set<Object?> other)</code>

##### <a name="lookup"></a><code>E? lookup(Object? object)</code>

##### <a name="union"></a><code>Set<E> union(Set<E> other)</code>

</details>



---

## SignalStreamUtils

Extension on **Stream** to provide convenient utilities to convert streams into reactive signals.

```dart
import 'package:signals_core/signals_core.dart';

final myStream = Stream.periodic(Duration(seconds: 1), (x) => x).take(5);
final mySignal = myStream.toStreamSignal();
```


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostreamsignal"></a><code>StreamSignal<T> toStreamSignal({bool? cancelOnError, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, AsyncSignalOptions<T>? options})</code>

Convert a stream to a signal

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
stream.toSyncSignal instead.

##### <a name="tosyncsignal"></a><code>ReadonlySignal<T> toSyncSignal(T initialData)</code>

Convert a **Stream** to a synchronous [ReadonlySignal](/types/readonlysignal) and provide an initial value.

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
```

</details>



---

## signal

Convenient global constructor for creating a mutable reactive state signal.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final name = signal('Jane');
```


---

## lazySignal

Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = lazySignal<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
```


---

## SignalOptionsBase

Base configuration options for reactive components and signals.

Contains common options across all signals, computed values, and effects,
such as the debug **name**.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaloptionsbase"></a><a name="signaloptionsbase"></a><code>SignalOptionsBase({this.name})</code>

Creates a new [SignalOptionsBase](/types/signaloptionsbase) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="name"></a><code>String? name</code>

The name for debugging, tracing, and DevTools inspection.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## ReadonlySignalUtils

Utility extensions on [ReadonlySignal](/types/readonlysignal) to bridge reactive programming with asynchronous streams and select sub-states.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostream"></a><code>Stream<T> toStream()</code>

Convert a signal to a **Stream** to be consumed as
a read only stream.

##### <a name="select"></a><code>Computed<R> select(R Function(ReadonlySignal<T>) selector, [ComputedOptions<R>? options])</code>

Select a sub-state value from this signal and return a computed signal that only notifies when that specific sub-state changes.

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
```

</details>



---

## WriteableSignalUtils

Utility extensions on [Signal](/types/signal) providing functional programming wrappers like React-style hooks destructuring.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="hooks"></a><code>(T Function(), void Function(T)) hooks</code>

Easy destructure to get and set the value

```dart
final counter = signal(0);
...
final (getCount, setCount) = counter.hooks;
```

</details>



---

## SignalFunctionExtensions

Utility extension on a getter function <code>T Function()</code> to instantly convert it into a [Computed](/types/computed) signal.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Computed<T> $</code>

Return a cached, derived [Computed<T>](/types/computed) signal from this getter function.

```dart
import 'package:signals_core/signals_core.dart';

final count = signal(0);
final doubleCount = (() => count.value * 2).$;

print(doubleCount.value); // 0
count.value = 5;
print(doubleCount.value); // 10
```

</details>



---

## EffectCycleDetectionError

Cycle detection usually means you have updated
a signal inside an effect and are reading by value.


---

## SignalMutationFunctionUtils

Extension on a mutation function <code>Future<T> Function(A)</code> to convert it into
a [MutationSignal](/types/mutationsignal).


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tomutationsignal"></a><code>MutationSignal<A, T> toMutationSignal({SignalOptions<MutationState<T>>? options})</code>

Convert this mutation function into a [MutationSignal](/types/mutationsignal).

```dart
import 'package:signals_core/signals_core.dart';

Future<void> save(Todo todo) => api.add(todo);
final addTodo = save.toMutationSignal();

addTodo.mutate(myTodo);
```

</details>



---

## SignalDoubleExtensions

Utility extension on **double** to easily lift a double into a reactive [Signal](/types/signal).


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<double> $</code>

Lift a primitive **double** into a reactive [Signal<double>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 3.14.$;
print(doubleSignal.value); // 3.14
```

</details>



---

## SignalBoolExtensions

Utility extension on **bool** to easily lift a boolean into a reactive [Signal](/types/signal).


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<bool> $</code>

Lift a primitive **bool** into a reactive [Signal<bool>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final isEnabled = true.$;
print(isEnabled.value); // true
```

</details>



---

## SignalIterableUtils

Utility extension methods on **Iterable** to convert them to [IterableSignal](/types/iterablesignal)s.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>IterableSignal<T> toSignal({IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})</code>

Convert an existing **Iterable** to an [IterableSignal](/types/iterablesignal).

This returns an [IterableSignal](/types/iterablesignal) initialized with the current collection.

```dart
import 'package:signals/signals.dart';

final numbers = [1, 2, 3];
final signal = numbers.toSignal();
```

</details>



---

## SignalNumExtensions

Utility extension on **num** to easily lift a number into a reactive [Signal](/types/signal).


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<num> $</code>

Lift a primitive **num** into a reactive [Signal<num>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final counter = 10.$;
print(counter.value); // 10
```

</details>



---

## SignalSetExtensions

Utility extension on **Set** to easily lift a set into a reactive [Signal](/types/signal).


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<Set<E>> $</code>

Lift a primitive **Set** into a reactive [Signal<Set<E>>].

```dart
import 'package:signals_core/signals_core.dart';

final tags = {'sports', 'news'}.$;
print(tags.value); // {'sports', 'news'}
```

</details>



---

## SignalListUtils

Utility extension methods on **List** to convert them to [ListSignal](/types/listsignal)s.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>ListSignal<T> toSignal({ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})</code>

Convert this existing **List** to a reactive [ListSignal](/types/listsignal).

```dart
import 'package:signals/signals.dart';

final myList = [1, 2, 3];
final signal = myList.toSignal();
```

</details>



---

## SignalMapUtils

Utility extension methods on **Map** to convert them to [MapSignal](/types/mapsignal)s.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>MapSignal<K, V> toSignal({MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})</code>

Convert this existing **Map** to a reactive [MapSignal](/types/mapsignal).

```dart
import 'package:signals/signals.dart';

final myMap = {'key': 'value'};
final signal = myMap.toSignal();
```

</details>



---

## SignalSetUtils

Utility extension methods on **Set** to convert them to [SetSignal](/types/setsignal)s.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>SetSignal<T> toSignal({SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})</code>

Convert this existing **Set** to a reactive [SetSignal](/types/setsignal).

```dart
import 'package:signals/signals.dart';

final mySet = {1, 2, 3};
final signal = mySet.toSignal();
```

</details>



---

## SignalsWriteAfterDisposeError

Error to throw if a signal is written to after it is disposed


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalswriteafterdisposeerror"></a><a name="signalswriteafterdisposeerror"></a><code>SignalsWriteAfterDisposeError(ReadonlySignal instance)</code>

Error to throw if a signal is written to after it is disposed

</details>



---

## SignalFutureUtils

Extension on future to provide helpful methods for signals


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tofuturesignal"></a><code>FutureSignal<T> toFutureSignal({Duration? timeout, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], AsyncSignalOptions<T>? options})</code>

Convert an existing future to [FutureSignal](/types/futuresignal)

```dart
import 'package:signals/signals.dart';

final future = Future(() => 1);
final signal = future.toSignal();
```

</details>



---

## ReadonlySignalMixin

Readonly signal mixin for adding addition helper methods


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isinitialized"></a><code>bool isInitialized</code>

Check if a signal value is set (does not subscribe)

##### <a name="debuglabel"></a><code>String? debugLabel</code>

Debug label for Debug Mode
Debug label for Debug Mode

##### <a name="value"></a><code>T value</code>

##### <a name="peek"></a><code>T peek()</code>

</details>



---

## SignalsReadAfterDisposeError

Error to throw if a signal is read after it is disposed


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalsreadafterdisposeerror"></a><a name="signalsreadafterdisposeerror"></a><code>SignalsReadAfterDisposeError(ReadonlySignal instance)</code>

Error to throw if a signal is read after it is disposed

</details>



---

## ComparableSignalExtension

Helper extensions for [ReadonlySignal<Comparable<T>>]


### Methods

<details>
<summary> View Methods </summary>

##### <a name="compareto"></a><code>int compareTo(T other)</code>

Compares this object to another object.

Returns a value like a **Comparator** when comparing <code>this</code> to **other**.
That is, it returns a negative integer if <code>this</code> is ordered before **other**,
a positive integer if <code>this</code> is ordered after **other**,
and zero if <code>this</code> and **other** are ordered together.

The **other** argument must be a value that is comparable to this object.

</details>



---

## MutationError

The mutation failed with an error and stack trace.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="mutationerror"></a><a name="mutationerror"></a><code>MutationError(this.error, this.stackTrace)</code>

The mutation failed with an error and stack trace.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="error"></a><code>Object error</code>

##### <a name="stacktrace"></a><code>StackTrace stackTrace</code>

The stack trace captured when the mutation failed. Always non-null on a
[MutationError](/types/mutationerror) (defaulted to <code>StackTrace.current</code> by the factory).

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isidle"></a><code>bool isIdle</code>

##### <a name="ispending"></a><code>bool isPending</code>

##### <a name="hasvalue"></a><code>bool hasValue</code>

##### <a name="haserror"></a><code>bool hasError</code>

##### <a name="value"></a><code>T? value</code>

##### <a name="requirevalue"></a><code>T requireValue</code>

##### <a name="=="></a><code>bool ==(covariant MutationState<T> other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## LazySignalInitializationError

Lazy signal must value value set before it is read


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="lazysignalinitializationerror"></a><a name="lazysignalinitializationerror"></a><code>LazySignalInitializationError(ReadonlySignal instance)</code>

Lazy signal must value value set before it is read

</details>



---

## SignalEffectException

Error for when a effect fails to run the callback


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaleffectexception"></a><a name="signaleffectexception"></a><code>SignalEffectException(this.error, [this.stackTrace])</code>

Error for when a effect fails to run the callback

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="error"></a><code>Object? error</code>

Error during callback

##### <a name="stacktrace"></a><code>StackTrace? stackTrace</code>

StackTrace for where the error started

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostring"></a><code>String toString()</code>

</details>



---

## ReadonlyIterableSignalExtension

Helper extensions for [ReadonlySignal<Iterable>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="any"></a><code>bool any(bool Function(E element) test)</code>

##### <a name="cast"></a><code>Iterable<R> cast()</code>

##### <a name="contains"></a><code>bool contains(Object? value)</code>

##### <a name="elementat"></a><code>E elementAt(int index)</code>

##### <a name="every"></a><code>bool every(bool Function(E element) test)</code>

##### <a name="expand"></a><code>Iterable<R> expand(Iterable<R> Function(E element) toElements)</code>

##### <a name="first"></a><code>E first</code>

##### <a name="firstwhere"></a><code>E firstWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="fold"></a><code>R fold(R initialValue, R Function(R previousValue, E element) combine)</code>

##### <a name="followedby"></a><code>Iterable<E> followedBy(Iterable<E> other)</code>

##### <a name="isempty"></a><code>bool isEmpty</code>

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

##### <a name="iterator"></a><code>Iterator<E> iterator</code>

##### <a name="join"></a><code>String join([String separator = ""])</code>

##### <a name="last"></a><code>E last</code>

##### <a name="lastwhere"></a><code>E lastWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="length"></a><code>int length</code>

##### <a name="map"></a><code>Iterable<R> map(R Function(E e) toElement)</code>

##### <a name="reduce"></a><code>E reduce(E Function(E value, E element) combine)</code>

##### <a name="single"></a><code>E single</code>

##### <a name="singlewhere"></a><code>E singleWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="skip"></a><code>Iterable<E> skip(int count)</code>

##### <a name="skipwhile"></a><code>Iterable<E> skipWhile(bool Function(E value) test)</code>

##### <a name="take"></a><code>Iterable<E> take(int count)</code>

##### <a name="takewhile"></a><code>Iterable<E> takeWhile(bool Function(E value) test)</code>

##### <a name="tolist"></a><code>List<E> toList({bool growable = true})</code>

##### <a name="toset"></a><code>Set<E> toSet()</code>

##### <a name="where"></a><code>Iterable<E> where(bool Function(E element) test)</code>

##### <a name="wheretype"></a><code>Iterable<R> whereType()</code>

##### <a name="foreach"></a><code>void forEach(void Function(E element) action)</code>

</details>



---

## ChangeSignalOptions

Configuration options for a [ChangeStackSignal](/types/changestacksignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="changesignaloptions"></a><a name="changesignaloptions"></a><code>ChangeSignalOptions({this.limit, super.name, super.autoDispose, super.watched, super.unwatched})</code>

Creates a new [ChangeSignalOptions](/types/changesignaloptions) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="limit"></a><code>int? limit</code>

The limit of changes to keep in the undo/redo stack.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ChangeSignalOptions<T> copyWith({int? limit, String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## PatternSignalExtension

Helper extensions for [ReadonlySignal<Pattern>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="allmatches"></a><code>Iterable<Match> allMatches(String string, [int start = 0])</code>

Matches this pattern against the string repeatedly.

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
```

##### <a name="matchasprefix"></a><code>Match? matchAsPrefix(String string, [int start = 0])</code>

Matches this pattern against the start of <code>string</code>.

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
```

</details>



---

## StringSignalExtension

Helper extensions for [ReadonlySignal<String>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="[]"></a><code>String [](int index)</code>

The character (as a single-code-unit **String**) at the given **index**.

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
<code>String.fromCharCode(this.codeUnitAt(index))</code>.

##### <a name="codeunitat"></a><code>int codeUnitAt(int index)</code>

Returns the 16-bit UTF-16 code unit at the given **index**.

##### <a name="length"></a><code>int length</code>

The length of the string.

Returns the number of UTF-16 code units in this string. The number
of **runes** might be fewer if the string contains characters outside
the Basic Multilingual Plane (plane 0):
```dart
'Dart'.length;          // 4
'Dart'.runes.length;    // 4

var clef = '\u{1D11E}';
clef.length;            // 2
clef.runes.length;      // 1
```

##### <a name="endswith"></a><code>bool endsWith(String other)</code>

Whether this string ends with **other**.

For example:
```dart
const string = 'Dart is open source';
print(string.endsWith('urce')); // true
```

##### <a name="startswith"></a><code>bool startsWith(Pattern pattern, [int index = 0])</code>

Whether this string starts with a match of **pattern**.

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
```

##### <a name="indexof"></a><code>int indexOf(Pattern pattern, [int start = 0])</code>

Returns the position of the first match of **pattern** in this string,
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
The **start** must be non-negative and not greater than **length**.

##### <a name="lastindexof"></a><code>int lastIndexOf(Pattern pattern, [int? start])</code>

The starting position of the last match **pattern** in this string.

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
If supplied, **start** must be non-negative and not greater than **length**.

##### <a name="isempty"></a><code>bool isEmpty</code>

Whether this string is empty.

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

Whether this string is not empty.

##### <a name="+"></a><code>String +(String other)</code>

Creates a new string by concatenating this string with **other**.

Example:
```dart
const string = 'dart' + 'lang'; // 'dartlang'
```

##### <a name="substring"></a><code>String substring(int start, [int? end])</code>

The substring of this string from **start**, inclusive, to **end**, exclusive.

Example:
```dart
const string = 'dartlang';
var result = string.substring(1); // 'artlang'
result = string.substring(1, 4); // 'art'
```

Both **start** and **end** must be non-negative and no greater than **length**;
**end**, if provided, must be greater than or equal to **start**.

##### <a name="trim"></a><code>String trim()</code>

The string without any leading and trailing whitespace.

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
used by the system.

##### <a name="trimleft"></a><code>String trimLeft()</code>

The string without any leading whitespace.

As **trim**, but only removes leading whitespace.
```dart
final string = ' Dart '.trimLeft();
print(string); // 'Dart '
```

##### <a name="trimright"></a><code>String trimRight()</code>

The string without any trailing whitespace.

As **trim**, but only removes trailing whitespace.
```dart
final string = ' Dart '.trimRight();
print(string); // ' Dart'
```

##### <a name="*"></a><code>String *(int times)</code>

Creates a new string by concatenating this string with itself a number
of times.

The result of <code>str * n</code> is equivalent to
<code>str + str + ...</code>(n times)<code>... + str</code>.

```dart
const string = 'Dart';
final multiplied = string * 3;
print(multiplied); // 'DartDartDart'
```
Returns an empty string if **times** is zero or negative.

##### <a name="padleft"></a><code>String padLeft(int width, [String padding = ' '])</code>

Pads this string on the left if it is shorter than **width**.

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
the correct measure of the string's length.

##### <a name="padright"></a><code>String padRight(int width, [String padding = ' '])</code>

Pads this string on the right if it is shorter than **width**.

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
the correct measure of the string's length.

##### <a name="contains"></a><code>bool contains(Pattern other, [int startIndex = 0])</code>

Whether this string contains a match of **other**.

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
The **startIndex** must not be negative or greater than **length**.

##### <a name="replacefirst"></a><code>String replaceFirst(Pattern from, String to, [int startIndex = 0])</code>

Creates a new string with the first occurrence of **from** replaced by **to**.

Finds the first match of **from** in this string, starting from **startIndex**,
and creates a new string where that match is replaced with the **to** string.

Example:
```dart
'0.0001'.replaceFirst(RegExp(r'0'), ''); // '.0001'
'0.0001'.replaceFirst(RegExp(r'0'), '7', 1); // '0.7001'
```

##### <a name="replacefirstmapped"></a><code>String replaceFirstMapped(Pattern from, String Function(Match match) replace, [int startIndex = 0])</code>

Replace the first occurrence of **from** in this string.

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

The **startIndex** must be non-negative and no greater than **length**.

##### <a name="replaceall"></a><code>String replaceAll(Pattern from, String replace)</code>

Replaces all substrings that match **from** with **replace**.

Creates a new string in which the non-overlapping substrings matching
**from** (the ones iterated by <code>from.allMatches(thisString)</code>) are replaced
by the literal string **replace**.
```dart
'resume'.replaceAll(RegExp(r'e'), 'é'); // 'résumé'
```
Notice that the **replace** string is not interpreted. If the replacement
depends on the match (for example, on a **RegExp**'s capture groups), use
the **replaceAllMapped** method instead.

##### <a name="replaceallmapped"></a><code>String replaceAllMapped(Pattern from, String Function(Match match) replace)</code>

Replace all substrings that match **from** by a computed string.

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
```

##### <a name="replacerange"></a><code>String replaceRange(int start, int? end, String replacement)</code>

Replaces the substring from **start** to **end** with **replacement**.

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
If **end** is <code>null</code>, it defaults to **length**.

##### <a name="split"></a><code>List<String> split(Pattern pattern)</code>

Splits the string at matches of **pattern** and returns a list of substrings.

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
```

##### <a name="splitmapjoin"></a><code>String splitMapJoin(Pattern pattern, {String Function(Match)? onMatch, String Function(String)? onNonMatch})</code>

Splits the string, converts its parts, and combines them into a new
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
```

##### <a name="codeunits"></a><code>List<int> codeUnits</code>

An unmodifiable list of the UTF-16 code units of this string.

##### <a name="runes"></a><code>Runes runes</code>

An **Iterable** of Unicode code-points of this string.

If the string contains surrogate pairs, they are combined and returned
as one integer by this iterator. Unmatched surrogate halves are treated
like valid 16-bit code-units.

##### <a name="tolowercase"></a><code>String toLowerCase()</code>

Converts all characters in this string to lower case.

If the string is already in all lower case, this method returns <code>this</code>.
```dart
'ALPHABET'.toLowerCase(); // 'alphabet'
'abc'.toLowerCase(); // 'abc'
```
This function uses the language independent Unicode mapping and thus only
works in some languages.

##### <a name="touppercase"></a><code>String toUpperCase()</code>

Converts all characters in this string to upper case.

If the string is already in all upper case, this method returns <code>this</code>.
```dart
'alphabet'.toUpperCase(); // 'ALPHABET'
'ABC'.toUpperCase(); // 'ABC'
```
This function uses the language independent Unicode mapping and thus only
works in some languages.

</details>



---

## IterableSignalOptions

Configuration options for a [IterableSignal](/types/iterablesignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="iterablesignaloptions"></a><a name="iterablesignaloptions"></a><code>IterableSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code>

Creates a new [IterableSignalOptions](/types/iterablesignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>IterableSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Iterable<E>>? equality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## EnumSignalExtension

Helper extensions for [ReadonlySignal<Enum>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="index"></a><code>int index</code>

A numeric identifier for the enumerated value.

The values of a single enumeration are numbered
consecutively from zero to one less than the
number of values.
This is also the index of the value in the
enumerated type's static <code>values</code> list.

##### <a name="name"></a><code>String name</code>

The name of the enum value.

The name is a string containing the source identifier used
to declare the enum value.

For example, given a declaration like:
```dart
enum MyEnum {
  value1,
  value2
}
```
the result of <code>MyEnum.value1.name</code> is the string <code>"value1"</code>.

</details>



---

## ReadonlyListSignalExtension

Helper extensions for [ReadonlySignal<List>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="cast"></a><code>List<R> cast()</code>

##### <a name="last"></a><code>E last</code>

##### <a name="+"></a><code>List<E> +(List<E> other)</code>

##### <a name="[]"></a><code>E [](int index)</code>

##### <a name="asmap"></a><code>Map<int, E> asMap()</code>

##### <a name="expand"></a><code>Iterable<R> expand(Iterable<R> Function(E element) toElements)</code>

##### <a name="firstwhere"></a><code>E firstWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="fold"></a><code>R fold(R initialValue, R Function(R previousValue, E element) combine)</code>

##### <a name="followedby"></a><code>Iterable<E> followedBy(Iterable<E> other)</code>

##### <a name="getrange"></a><code>Iterable<E> getRange(int start, int end)</code>

##### <a name="indexof"></a><code>int indexOf(E element, [int start = 0])</code>

##### <a name="indexwhere"></a><code>int indexWhere(bool Function(E element) test, [int start = 0])</code>

##### <a name="lastindexof"></a><code>int lastIndexOf(E element, [int? start])</code>

##### <a name="lastindexwhere"></a><code>int lastIndexWhere(bool Function(E element) test, [int? start])</code>

##### <a name="reversed"></a><code>Iterable<E> reversed</code>

##### <a name="sorted"></a><code>List<E> sorted([int Function(E a, E b)? compare])</code>

Return a new array that is sorted by the **compare** function

##### <a name="sublist"></a><code>List<E> sublist(int start, [int? end])</code>

</details>



---

## IntSignalExtension

Helper extensions for [ReadonlySignal<int>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="&"></a><code>int &(int other)</code>

Bit-wise and operator.

Treating both <code>this</code> and **other** as sufficiently large two's component
integers, the result is a number with only the bits set that are set in
both <code>this</code> and **other**

If both operands are negative, the result is negative, otherwise
the result is non-negative.
```dart
print((2 & 1).toRadixString(2)); // 0010 & 0001 -> 0000
print((3 & 1).toRadixString(2)); // 0011 & 0001 -> 0001
print((10 & 2).toRadixString(2)); // 1010 & 0010 -> 0010
```

##### <a name="|"></a><code>int |(int other)</code>

Bit-wise or operator.

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
```

##### <a name="^"></a><code>int ^(int other)</code>

Bit-wise exclusive-or operator.

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
```

##### <a name="~"></a><code>int ~()</code>

The bit-wise negate operator.

Treating <code>this</code> as a sufficiently large two's component integer,
the result is a number with the opposite bits set.

This maps any integer <code>x</code> to <code>-x - 1</code>.

##### <a name="<<"></a><code>int <<(int shiftAmount)</code>

Shift the bits of this integer to the left by **shiftAmount**.

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
```

##### <a name=">>"></a><code>int >>(int shiftAmount)</code>

Shift the bits of this integer to the right by **shiftAmount**.

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
```

##### <a name=">>>"></a><code>int >>>(int shiftAmount)</code>

Bitwise unsigned right shift by **shiftAmount** bits.

The least significant **shiftAmount** bits are dropped,
the remaining bits (if any) are shifted down,
and zero-bits are shifted in as the new most significant bits.

The **shiftAmount** must be non-negative.

Example:
```dart
print((3 >>> 1).toRadixString(2)); // 0011 -> 0001
print((9 >>> 2).toRadixString(2)); // 1001 -> 0010
print(((-9) >>> 2).toRadixString(2)); // 111...1011 -> 001...1110 (> 0)
```

##### <a name="modpow"></a><code>int modPow(int exponent, int modulus)</code>

Returns this integer to the power of **exponent** modulo **modulus**.

The **exponent** must be non-negative and **modulus** must be
positive.

##### <a name="modinverse"></a><code>int modInverse(int modulus)</code>

Returns the modular multiplicative inverse of this integer
modulo **modulus**.

The **modulus** must be positive.

It is an error if no modular inverse exists.

##### <a name="gcd"></a><code>int gcd(int other)</code>

Returns the greatest common divisor of this integer and **other**.

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
```

##### <a name="iseven"></a><code>bool isEven</code>

Returns true if and only if this integer is even.

##### <a name="isodd"></a><code>bool isOdd</code>

Returns true if and only if this integer is odd.

##### <a name="bitlength"></a><code>int bitLength</code>

Returns the minimum number of bits required to store this integer.

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
```

##### <a name="tounsigned"></a><code>int toUnsigned(int width)</code>

Returns the least significant **width** bits of this integer as a
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
```

##### <a name="tosigned"></a><code>int toSigned(int width)</code>

Returns the least significant **width** bits of this integer, extending the
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
```

##### <a name="-"></a><code>int -()</code>

Return the negative value of this integer.

The result of negating an integer always has the opposite sign, except
for zero, which is its own negation.

##### <a name="abs"></a><code>int abs()</code>

Returns the absolute value of this integer.

For any integer <code>value</code>,
the result is the same as <code>value < 0 ? -value : value</code>.

Integer overflow may cause the result of <code>-value</code> to stay negative.

##### <a name="sign"></a><code>int sign</code>

Returns the sign of this integer.

Returns 0 for zero, -1 for values less than zero and
+1 for values greater than zero.

##### <a name="round"></a><code>int round()</code>

Returns <code>this</code>.

##### <a name="floor"></a><code>int floor()</code>

Returns <code>this</code>.

##### <a name="ceil"></a><code>int ceil()</code>

Returns <code>this</code>.

##### <a name="truncate"></a><code>int truncate()</code>

Returns <code>this</code>.

##### <a name="roundtodouble"></a><code>double roundToDouble()</code>

Returns <code>this.toDouble()</code>.

##### <a name="floortodouble"></a><code>double floorToDouble()</code>

Returns <code>this.toDouble()</code>.

##### <a name="ceiltodouble"></a><code>double ceilToDouble()</code>

Returns <code>this.toDouble()</code>.

##### <a name="truncatetodouble"></a><code>double truncateToDouble()</code>

Returns <code>this.toDouble()</code>.

##### <a name="toradixstring"></a><code>String toRadixString(int radix)</code>

Converts this **int** to a string representation in the given **radix**.

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
```

</details>



---

## ReadonlyMapSignalExtension

Helper extensions for [ReadonlySignal<Map>](/types/readonlysignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="[]"></a><code>V? [](Object? key)</code>

##### <a name="cast"></a><code>Map<RK, RV> cast()</code>

##### <a name="containskey"></a><code>bool containsKey(Object? key)</code>

##### <a name="containsvalue"></a><code>bool containsValue(Object? value)</code>

##### <a name="entries"></a><code>Iterable<MapEntry<K, V>> entries</code>

##### <a name="isempty"></a><code>bool isEmpty</code>

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

##### <a name="keys"></a><code>Iterable<K> keys</code>

##### <a name="length"></a><code>int length</code>

##### <a name="map"></a><code>Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)</code>

##### <a name="values"></a><code>Iterable<V> values</code>

</details>



---

## ListSignalOptions

Configuration options for a [ListSignal](/types/listsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="listsignaloptions"></a><a name="listsignaloptions"></a><code>ListSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code>

Creates a new [ListSignalOptions](/types/listsignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ListSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<List<E>>? equality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## MapSignalOptions

Configuration options for a [MapSignal](/types/mapsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="mapsignaloptions"></a><a name="mapsignaloptions"></a><code>MapSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code>

Creates a new [MapSignalOptions](/types/mapsignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>MapSignalOptions<K, V> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Map<K, V>>? equality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SetSignalOptions

Configuration options for a [SetSignal](/types/setsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="setsignaloptions"></a><a name="setsignaloptions"></a><code>SetSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code>

Creates a new [SetSignalOptions](/types/setsignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>SetSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Set<E>>? equality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SignalsAutoDisposeMixin

Mixin to enable autodispose on a signal


### Properties

<details>
<summary> View Properties </summary>

##### <a name="autodispose"></a><code>bool autoDispose</code>

Throws and error if read after dispose and can be
disposed on last unsubscribe.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="disposed"></a><code>bool disposed</code>

Check if the effect is disposed

##### <a name="ondispose"></a><code>void Function() onDispose(void Function() cleanup)</code>

Add a cleanup function to be called when the signal is disposed

```dart
final counter = signal(0);
final effectCount = signal(0);

final cleanup = counter.onDispose(() {
 print('Counter has been disposed');
});

// Remove the cleanup function
cleanup();
```

##### <a name="disposed"></a><code>disposed(bool value)</code>

Force a signal to be disposed

##### <a name="dispose"></a><code>void dispose()</code>

Dispose the signal

</details>



---

## LinkedSignalOptions

Options for creating a [LinkedSignal](/types/linkedsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="linkedsignaloptions"></a><a name="linkedsignaloptions"></a><code>LinkedSignalOptions({this.computation, this.sourceEquality, super.name, super.autoDispose})</code>

Creates [LinkedSignalOptions](/types/linkedsignaloptions).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="computation"></a><code>T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation</code>

Custom computation logic that runs when the source changes.

##### <a name="sourceequality"></a><code>bool Function(S a, S b)? sourceEquality</code>

Optional equality check for the source values.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>LinkedSignalOptions<T, S> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation, bool Function(S a, S b)? sourceEquality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## ListSignalExtension

Helper extensions for [Signal<List>](/types/signal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="first"></a><code>first(E val)</code>

##### <a name="last"></a><code>last(E val)</code>

##### <a name="length"></a><code>length(int value)</code>

##### <a name="[]="></a><code>void []=(int index, E value)</code>

##### <a name="add"></a><code>void add(E value)</code>

##### <a name="addall"></a><code>void addAll(Iterable<E> iterable)</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="fillrange"></a><code>void fillRange(int start, int end, [E? fillValue])</code>

##### <a name="insert"></a><code>void insert(int index, E element)</code>

##### <a name="insertall"></a><code>void insertAll(int index, Iterable<E> iterable)</code>

##### <a name="remove"></a><code>bool remove(Object? value)</code>

##### <a name="removeat"></a><code>E removeAt(int index)</code>

##### <a name="removelast"></a><code>E removeLast()</code>

##### <a name="removerange"></a><code>void removeRange(int start, int end)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(E element) test)</code>

##### <a name="replacerange"></a><code>void replaceRange(int start, int end, Iterable<E> replacements)</code>

##### <a name="retainwhere"></a><code>void retainWhere(bool Function(E element) test)</code>

##### <a name="setall"></a><code>void setAll(int index, Iterable<E> iterable)</code>

##### <a name="setrange"></a><code>void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])</code>

##### <a name="shuffle"></a><code>void shuffle([Random? random])</code>

##### <a name="sort"></a><code>void sort([int Function(E a, E b)? compare])</code>

</details>



---

## MapSignalExtension

Helper extensions for [Signal<Map>](/types/signal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="[]="></a><code>void []=(K key, V value)</code>

##### <a name="addall"></a><code>void addAll(Map<K, V> other)</code>

##### <a name="addentries"></a><code>void addEntries(Iterable<MapEntry<K, V>> newEntries)</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="foreach"></a><code>void forEach(void Function(K key, V value) action)</code>

##### <a name="putifabsent"></a><code>V putIfAbsent(K key, V Function() ifAbsent)</code>

##### <a name="remove"></a><code>V? remove(Object? key)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(K key, V value) test)</code>

##### <a name="update"></a><code>V update(K key, V Function(V value) update, {V Function()? ifAbsent})</code>

##### <a name="updateall"></a><code>void updateAll(V Function(K key, V value) update)</code>

</details>



---

## SignalObjectUtils

Connivent methods for signal values


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<T> $</code>

Convert an existing Object to [Signal](/types/signal)

</details>



---

## SignalComparableExtensions

Extensions for **Comparable<T>**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<Comparable<T>> $</code>

Return a signal from a Comparable value

</details>



---

## SignalIterableExtensions

Extensions for **Iterable<E>**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<Iterable<E>> $</code>

Return a signal from a Iterable value

</details>



---

## SignalListExtensions

Extensions for **List<E>**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<List<E>> $</code>

Return a signal from a List value

</details>



---

## SignalPatternExtensions

Extensions for **Pattern**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<Pattern> $</code>

Return a signal from a Pattern value

</details>



---

## SignalMapExtensions

Extensions for **Map<E>**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<Map<K, V>> $</code>

Return a signal from a Map value

</details>



---

## SignalStringExtensions

Extensions for **String**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<String> $</code>

Return a signal from a String value

</details>



---

## SignalEnumExtensions

Extensions for **Enum**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<T> $</code>

Return a signal from a Enum value

</details>



---

## SignalIntExtensions

Extensions for **int**


### Methods

<details>
<summary> View Methods </summary>

##### <a name="$"></a><code>Signal<int> $</code>

Return a signal from a int value

</details>



---

## SignalsError

Signal usage error


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalserror"></a><a name="signalserror"></a><code>SignalsError(this.message)</code>

Signal usage error

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="message"></a><code>String message</code>

Signals error pretty print message

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostring"></a><code>String toString()</code>

</details>
