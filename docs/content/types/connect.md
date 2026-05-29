---
title: "Type: Connect"
description: "API reference and details for Connect from signals.dart."
---

# Connect

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: Connect

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

### Members of Connect

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Connect** | <code>constructor</code> | <code>dart Connect(this.signal)</code> | Connects a **Stream** to a [Signal](/types/signal). |
| **signal** | <code>field</code> | <code>dart Signal<T> signal</code> | Internal signal to connect to. |
| **from** | <code>method</code> | <code>dart Connect<T, S> from(Stream<S> source, {bool? cancelOnError, Function? onError, Function? onDone, void Function(T)? onValue})</code> | Connects a **Stream** to a [Signal](/types/signal). |
| **<<** | <code>method</code> | <code>dart Connect<T, S> <<(Stream<S> source)</code> | Synonym for <code>from(Stream<T> source)</code> |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> | Cancels all subscriptions. |

## Function: connect

```dart
Connect<T, S> connect(Signal<T> signal, [Stream<S>? stream])
```

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

## References

The **Connect** type is referenced and used in the following pages:

* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Connect](/packages/signals_flutter/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [signals_flutter](/packages/signals_flutter)
* [Connect](/packages/signals_core/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [signals_core](/packages/signals_core)
* [SignalsDevToolsExtension](/packages/signals_devtools_extension/flutter/devtools) <span style="opacity: 0.6; font-size: 0.85em;">(signals_devtools_extension/flutter)</span>
* [Connect](/packages/signals/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [signals](/packages/signals)
* [signals_hooks](/packages/signals_hooks)
* [useConnect](/packages/signals_hooks/hooks/use-connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

