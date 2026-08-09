# class `SignalProvider`

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

---

## Members of `SignalProvider`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalProvider** | `constructor` | `SignalProvider({super.key, required T Function() create, this.child, this.dispose})` | Creates a [SignalProvider](/types/signalprovider) that manages the lifecycle of a created signal.

The **create** callback is invoked once to instantiate the signal.
When this provider is unmounted, it automatically calls <code>dispose()</code> on the signal. |
| **SignalProvider.value** | `constructor` | `SignalProvider.value({super.key, required T value, this.child})` | Exposes an existing signal **value** to the widget tree.

Unlike the default constructor, the signal is NOT created by this provider,
and its lifecycle (including disposal) must be managed elsewhere. |
| **SignalProvider._** | `constructor` | `SignalProvider._({super.key, required T Function()? create, required T? value, required this.child, required this.dispose})` | Private constructor for internal cloning and subclass usage. |
| **child** | `field` | `Widget? child` | The widget subtree that will have access to the signal. |
| **dispose** | `field` | `void Function(T)? dispose` | An optional custom dispose callback. |
| **SignalProvider.multi** | `constructor` | `SignalProvider.multi({Key? key, required List<SignalProvider> providers, required Widget child})` | Creates a [SignalProvider](/types/signalprovider) that wraps multiple other [SignalProvider](/types/signalprovider)s.

This is a convenience constructor to avoid deeply nested trees when
providing multiple signals. |
| **copyWith** | `method` | `SignalProvider<T> copyWith(Widget child)` | Returns a clone of this [SignalProvider](/types/signalprovider) with a new **child** widget.
Used internally by [MultiSignalProvider](/types/multisignalprovider). |
| **createState** | `method` | `State<SignalProvider<T>> createState()` |  |
| **providerOf** | `method` | `static SignalProvider<T>? providerOf(BuildContext context, {bool listen = true})` | Retrieves the [SignalProvider](/types/signalprovider) widget itself from the ancestor path.

Note: Prefer using <code>SignalProvider.of<T>(context)</code> to retrieve the reactive
signal directly. |
| **of** | `method` | `static T? of(BuildContext context, {bool listen = true})` | Retrieves the reactive signal instance of type **T** directly from the nearest [SignalProvider](/types/signalprovider).

- If **listen** is true (default), the calling widget will automatically subscribe
  to the signal and rebuild whenever the signal's value changes.
- If **listen** is false, the signal is returned without establishing a subscription.
  Use <code>listen: false</code> when mutating the signal inside action callbacks. |
