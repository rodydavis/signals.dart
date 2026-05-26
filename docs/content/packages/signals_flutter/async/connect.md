---
title: Connect
description: The idea for connect comes from Anguar Signals with RxJS:.
---

The idea for `connect` comes from Anguar Signals with RxJS:

<iframe width="560" height="315" src="https://www.youtube.com/embed/R7-KdADEq0A?si=kK8XasbBedE3sPrR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Start with a signal and then use the `connect` method to create a connector.
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


### Constructors

##### <a name="connect"></a><a name="connect"></a>`Connect(this.signal)`

Connects a **Stream** to a [Signal](/packages/signals/core/signal).


### Properties

##### <a name="signal"></a>`Signal<T> signal`

Internal signal to connect to.


### Methods

##### <a name="from"></a>`Connect<T, S> from(Stream<S> source, {bool? cancelOnError, Function? onError, Function? onDone, void Function(T)? onValue})`

Connects a **Stream** to a [Signal](/packages/signals/core/signal).

```dart
final counter = signal(0);
final c = connect(counter);

final s1 = Stream.value(1);
final s2 = Stream.value(2);

c.from(s1).from(s2);

c.dispose();
```

##### <a name="<<"></a>`Connect<T, S> <<(Stream<S> source)`

Synonym for `from(Stream<T> source)`

##### <a name="dispose"></a>`void dispose()`

Cancels all subscriptions.



---

## connect

The idea for `connect` comes from Anguar Signals with RxJS:

<iframe width="560" height="315" src="https://www.youtube.com/embed/R7-KdADEq0A?si=kK8XasbBedE3sPrR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Start with a signal and then use the `connect` method to create a connector.
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
