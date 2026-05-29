---
title: "Type: SignalProvider"
description: "API reference and details for SignalProvider from signals.dart."
---

# SignalProvider

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: SignalProvider

A premium dependency-injection / state propagation widget that allows passing
reactive signals down the Flutter widget tree using **InheritedNotifier**.

<code>SignalProvider</code> makes a signal accessible to all child widgets in the subtree.
Any child widget that reads the signal using <code>SignalProvider.of<T>(context)</code> will
automatically rebuild when the signal's value changes, while parent widgets remain unaffected.

For version 7, <code>SignalProvider</code> is a stateful widget that manages the lifecycle of the created
signal, ensuring it is persisted across parent rebuilds and automatically calling <code>dispose()</code>
when the provider is unmounted to prevent memory leaks.

### Example Usage

#### 1. Standard Constructor (Manages Lifecycle)
```dart
SignalProvider<CounterSignal>(
  create: () => CounterSignal(0),
  child: const CounterDisplay(),
)
```

#### 2. Value Constructor (Exposes Existing Instance)
If the signal is created elsewhere (e.g. in a StatefulWidget's State or globally) and you want
to expose it without managing its lifecycle or calling dispose, use [SignalProvider.value](/types/signalprovider#value):
```dart
SignalProvider<CounterSignal>.value(
  value: myCounterSignal,
  child: const CounterDisplay(),
)
```

#### 3. Multi-Providing Multiple Signals
Wrap multiple providers in a flat list to avoid deeply nested trees using [SignalProvider.multi](/types/signalprovider#multi):
```dart
SignalProvider.multi(
  providers: [
    SignalProvider<Counter>(create: () => Counter()),
    SignalProvider<User>(create: () => User()),
  ],
  child: const MyApp(),
)
```

### Members of SignalProvider

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalProvider** | <code>constructor</code> | <code>dart SignalProvider({super.key, required T Function() create, this.child, this.dispose})</code> | Creates a [SignalProvider](/types/signalprovider) that manages the lifecycle of a created signal. |
| **SignalProvider.value** | <code>constructor</code> | <code>dart SignalProvider.value({super.key, required T value, this.child})</code> | Exposes an existing signal **value** to the widget tree. |
| **SignalProvider._** | <code>constructor</code> | <code>dart SignalProvider._({super.key, required T Function()? create, required T? value, required this.child, required this.dispose})</code> | Private constructor for internal cloning and subclass usage. |
| **child** | <code>field</code> | <code>dart Widget? child</code> | The widget subtree that will have access to the signal. |
| **dispose** | <code>field</code> | <code>dart void Function(T)? dispose</code> | An optional custom dispose callback. |
| **SignalProvider.multi** | <code>constructor</code> | <code>dart SignalProvider.multi({Key? key, required List<SignalProvider> providers, required Widget child})</code> | Creates a [SignalProvider](/types/signalprovider) that wraps multiple other [SignalProvider](/types/signalprovider)s. |
| **copyWith** | <code>method</code> | <code>dart SignalProvider<T> copyWith(Widget child)</code> | Returns a clone of this [SignalProvider](/types/signalprovider) with a new **child** widget. |
| **createState** | <code>method</code> | <code>dart State<SignalProvider<T>> createState()</code> |  |
| **providerOf** | <code>method</code> | <code>dart static SignalProvider<T>? providerOf(BuildContext context, {bool listen = true})</code> | Retrieves the [SignalProvider](/types/signalprovider) widget itself from the ancestor path. |
| **of** | <code>method</code> | <code>dart static T? of(BuildContext context, {bool listen = true})</code> | Retrieves the reactive signal instance of type **T** directly from the nearest [SignalProvider](/types/signalprovider). |

## References

The **SignalProvider** type is referenced and used in the following pages:

* [Dependency Injection](/guides/dependency-injection) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [signals_flutter](/packages/signals_flutter)
* [MultiSignalProvider](/packages/signals_flutter/widgets/multi-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalProvider](/packages/signals_flutter/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [signals](/packages/signals)
* [MultiSignalProvider](/packages/signals/widgets/multi-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalProvider](/packages/signals/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [useSignalProvider](/packages/signals_hooks/hooks/use-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

