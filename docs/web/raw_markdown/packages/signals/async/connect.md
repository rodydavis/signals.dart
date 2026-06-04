---
title: Connect
description: A highly powerful connector utility that allows you to dynamically stream and pipe multiple asynchronous streams directly into a single reactive Si...
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="connect"></a><a name="connect"></a>`Connect(this.signal)`

Connects a **Stream** to a [Signal](/types/signal).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="signal"></a>`Signal<T> signal`

Internal signal to connect to.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="from"></a>`Connect<T, S> from(Stream<S> source, {bool? cancelOnError, Function? onError, Function? onDone, void Function(T)? onValue})`

Connects a **Stream** to a [Signal](/types/signal).

```dart
final counter = signal(0);
final c = connect(counter);

final s1 = Stream.value(1);
final s2 = Stream.value(2);

c.from(s1).from(s2);

c.dispose();
```

##### <a name="<<"></a>`Connect<T, S> <<(Stream<S> source)`

Synonym for <code>from(Stream<T> source)</code>

##### <a name="dispose"></a>`void dispose()`

Cancels all subscriptions.

</details>



---

## connect

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
