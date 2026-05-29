---
title: signals-flutter AI Skill
description: Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications. (v7.1.0)
---

# signals-flutter AI Developer Skill

> Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications. (v7.1.0)

---

### 📥 Installation

To instantly install this AI developer skill into your local workspace under `.agents/skills/`, run:

```bash
npx skills add rodydavis/signals.dart
```

---

## 📄 SKILL.md Preview

# signals-flutter API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-flutter` (version `7.1.0`).

---

## 🚀 Reactive Primitives Cheat-Sheet

Here is a curated reference of all reactivity constructs available in this package:

### Watch builder (prefix: `watchb`)
- **Category**: Flutter
- **Description**: Explicit in-place Flutter Watch widget rebuilding only the returned closure closure.

**Standard Usage Example**:
```dart
Watch.builder(
  builder: (context) => Text('Count: ${counter.value}')
)

```

---
### Watch (prefix: `watch`)
- **Category**: Flutter
- **Description**: Rebuilds only the wrapped closure when tracked signals change, avoiding full-widget GPU paints.

**Standard Usage Example**:
```dart
@override
Widget build(BuildContext context) {
  return Watch((context) {
    return Text('Count: ${counter.value}');
  });
}

```

---
### SignalBuilder (prefix: `sigb`)
- **Category**: Flutter
- **Description**: Subscribes to a single signal, rebuilding only this local builder block when it changes.

**Standard Usage Example**:
```dart
SignalBuilder(
  builder: (context, value) {
    return Text('Value: $value');
  },
)

```

---
### SignalEffect (prefix: `sigeff`)
- **Category**: Flutter
- **Description**: Executes standard Flutter side effects (Snackbars, dialogs) inside widget lifecycles safely.

**Standard Usage Example**:
```dart
SignalEffect(
  callback: (context) {
    if (error.value != null) {
      showDialog(...);
    }
  },
  child: MyContent(),
)

```

---

## 📦 Parsed Library API & Signature Reference

The following APIs are exported and available inside this package. Use them according to these signature patterns:

### class `FlutterSignal`

A mutable, reactive state cell that exposes both standard Signals and Flutter
**ValueNotifier** interfaces.

<code>FlutterSignal</code> extends the core <code>Signal</code> class and mixes in <code>ValueNotifierSignalMixin</code>,
making it completely interoperable with Flutter's build pipelines and widgets that expect
a **ValueNotifier** or **ValueListenable**.

### Example Usage

```dart
final count = signal(0);

// Interoperates with native ValueListenable listeners:
count.addListener(() {
  print('ValueNotifier update: ${count.value}');
});

count.value++; // Mutates the signal and triggers both Signals and ValueNotifier listeners.
```


#### Members of `FlutterSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FlutterSignal** | `constructor` | `FlutterSignal(super.internalValue, {super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})` | Simple writeable signal.

```dart
final count = signal(0);
print(count.value); // 0
count.value++;
print(count.value); // 1
``` |
| **FlutterSignal.lazy** | `constructor` | `FlutterSignal.lazy({super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})` | Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = FlutterSignal.lazy<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
``` |
| **runCallbackOnListen** | `field` | `bool runCallbackOnListen` |  |

---
### function `signal`

Creates a mutable, reactive [FlutterSignal](/types/fluttersignal) initialized with the given **value**.

When the value changes, all registered builders, effects, and **ValueNotifier** listeners
are automatically scheduled to update/rebuild.

### Flutter Widget Example

```dart
final count = signal(0);

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignalBuilder(
          builder: (context) => Text('Count: ${count.value}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Signature**:
```dart
FlutterSignal<T> signal(T value, {core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```


---
### function `lazySignal`

Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type **T** whose value can be assigned later.

<Warning>
  Reading a lazy signal's value before it has been initialized will throw a runtime error.
</Warning>

### Example

```dart
final database = lazySignal<DatabaseConnection>();

// Initialize later (e.g. in initState or async initialization):
database.value = await connectToDatabase();

// Now it is safe to read:
print('Connected to: ${database.value.host}');
```

**Signature**:
```dart
FlutterSignal<T> lazySignal({core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```


---
### class `FlutterReadonlySignal`

Simple writeable single



---
### function `readonly`

Create a new plain readonly signal

**Signature**:
```dart
FlutterReadonlySignal<T> readonly(T value, {core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```


---
### class `FlutterComputed`

A read-only reactive signal whose value is automatically computed and cached
based on other signals it depends on.

<code>FlutterComputed</code> extends the core <code>Computed</code> signal and implements Flutter's
**ValueListenable**, making it seamlessly compatible with native Flutter widgets
(like <code>ValueListenableBuilder</code>) and other ecosystem packages.

### Example Usage

```dart
final count = signal(2);
final doubled = computed(() => count.value * 2);

print(doubled.value); // 4
count.value = 5;
print(doubled.value); // 10
```

### Custom Signals
To create a custom signal that behaves like a computed value and implements **ValueListenable**,
you can extend <code>FlutterComputed</code> directly or mix in <code>ValueListenableSignalMixin</code>.


#### Members of `FlutterComputed`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FlutterComputed** | `constructor` | `FlutterComputed(super.internalValue, {super.options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})` | Create a new signal that is computed based on the values of other signals.

The returned computed signal is read-only, and its value is automatically
updated when any signals accessed from within the callback function change. |
| **runCallbackOnListen** | `field` | `bool runCallbackOnListen` |  |

---
### function `computed`

Creates a new [FlutterComputed](/types/fluttercomputed) signal that recalculates its value dynamically
based on the signals accessed inside the **compute** callback.

The returned computed signal is read-only and cached. It will only re-evaluate
when one of its tracked dependencies changes.

### Flutter Example

```dart
final firstName = signal('John');
final lastName = signal('Doe');

// Automatically combines both signals and caches the result:
final fullName = computed(() => '${firstName.value} ${lastName.value}');

// Usage inside a widget build:
@override
Widget build(BuildContext context) {
  return SignalBuilder(
    builder: (context) => Text('Hello, ${fullName.value}!'),
  );
}
```

**Signature**:
```dart
FlutterComputed<T> computed(T Function() compute, {core.ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```


---
### extension `FlutterReadonlySignalUtils`

Signal extensions for watching value changes on BuildContext.


#### Members of `FlutterReadonlySignalUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **watch** | `method` | `T watch(BuildContext context, {String? debugLabel})` | Rebuild the **Element** that the current signal is inside of. |
| **unwatch** | `method` | `void unwatch(BuildContext context)` | Stop subscriptions to updates on a signal for watchers. |

---
### extension `SignalValueListenableUtils`

Extension on **ValueListenable** to seamlessly bridge standard Flutter values to reactive signals.


#### Members of `SignalValueListenableUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `ReadonlySignal<T> toSignal({String? debugLabel, bool autoDispose = false})` | ## ReadonlySignal from ValueListenable

Converted **ValueListenable** objects become readable signals that automatically listen
to the underlying source. When the source updates, the signal updates.

The signal automatically manages the subscription, disposing of the listener when the
signal itself is disposed.

### Example: Converting a ValueNotifier
```dart
final ValueListenable<int> listenable = ValueNotifier(10);
final signal = listenable.toSignal();

print(signal.value); // 10
```

### Example: ValueListenable from ReadonlySignal
To convert back to a standard **ValueListenable** for native Flutter compatibility:
```dart
final signal = Signal(10);
final listenable = signal.toValueListenable();
``` |

---
### function `valueListenableToSignal`

A global helper function to convert a Flutter **ValueListenable** to a [ReadonlySignal](/types/readonlysignal).

This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final scrollPosition = ValueNotifier(0.0);
final scrollSignal = valueListenableToSignal(scrollPosition);
```

**Signature**:
```dart
ReadonlySignal<T> valueListenableToSignal(ValueListenable<T> valueListenable, {String? debugLabel, bool autoDispose = false})
```


---
### extension `SignalValueNotifierUtils`

Extension on **ValueNotifier** to seamlessly bridge standard Flutter mutable values to reactive signals.


#### Members of `SignalValueNotifierUtils`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `Signal<T> toSignal({String? debugLabel, bool autoDispose = false})` | ## Bi-directional Signal and ValueNotifier Interoperability

Converted **ValueNotifier** objects become mutable [Signal](/types/signal) instances. Setting the value
on the signal or the notifier automatically propagates the update to the other.

The subscription is fully memory-safe and automatically unsubscribed when the signal
is disposed.

### Example: Converting a ValueNotifier to a Signal
```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();

signal.value = 20;
print(notifier.value); // 20

notifier.value = 30;
print(signal.value); // 30
```

### Example: Converting a Signal to a ValueNotifier
To bridge back to a standard **ValueNotifier** for Flutter compatibility:
```dart
final signal = Signal(10);
final notifier = signal.toValueNotifier();
``` |

---
### function `valueNotifierToSignal`

A global helper function to convert a Flutter **ValueNotifier** to a mutable [Signal](/types/signal).

Updates to either the notifier or the returned signal will automatically update the other.
This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final textControllerValue = ValueNotifier('');
final textSignal = valueNotifierToSignal(textControllerValue);
```

**Signature**:
```dart
Signal<T> valueNotifierToSignal(ValueNotifier<T> valueNotifier, {String? debugLabel, bool autoDispose = false})
```


---
### class `SignalWidget`

A reactive **StatelessWidget** that implicitly tracks and rebuilds on signal changes.

<code>SignalWidget</code> establishes a dynamic reactive context directly at the Flutter element layer.
Any signal accessed via <code>.value</code> inside the **build** method is **implicitly tracked** and
subscribed to. When any of these signals mutate, only this widget is rebuilt.

This offers a clean, Javascript-style reactivity experience without needing manual
builder widgets (like <code>SignalBuilder</code>) or deprecated context watch extensions.

### Implicit Reactivity Example (Stateless)
```dart
final username = signal('Rody');
final status = signal('Online');

class UserProfileView extends SignalWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // 'username' and 'status' are implicitly tracked on access:
    return Column(
      children: [
        Text('Name: ${username.value}'),
        Text('Status: ${status.value}'),
      ],
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.


#### Members of `SignalWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalWidget** | `constructor` | `SignalWidget({super.key})` | Constructor for [SignalWidget](/types/signalwidget). |
| **createElement** | `method` | `StatelessElement createElement()` |  |

---
### class `SignalElement`

Element for [SignalWidget](/types/signalwidget) that manages implicit signal subscription and handles dynamic branching.


#### Members of `SignalElement`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalElement** | `constructor` | `SignalElement(super.widget)` | Constructor for [SignalElement](/types/signalelement). |
| **watchSignal** | `method` | `void watchSignal(core.ReadonlySignal value)` | Subscribes to changes of the provided **value** and schedules a rebuild. |
| **build** | `method` | `Widget build()` |  |
| **unmount** | `method` | `void unmount()` |  |

---
### class `SignalStatefulWidget`

A reactive **StatefulWidget** that implicitly tracks and rebuilds on signal changes.

Subclasses of <code>SignalStatefulWidget</code> establish a dynamic reactive context directly at the
Flutter element layer. Any signal value accessed synchronously inside State's **build** method
is **implicitly tracked** and subscribed to. When a signal changes, only that element is rebuilt.

This offers a clean, Javascript-style reactivity experience while retaining all stateful lifecycles.
It is the modern, highly recommended replacement for the legacy, deprecated <code>SignalsMixin</code>.

### Implicit Reactivity Example (Stateful)
```dart
class CounterControl extends SignalStatefulWidget {
  const CounterControl({super.key});

  @override
  State<CounterControl> createState() => _CounterControlState();
}

class _CounterControlState extends State<CounterControl> {
  // Create state signals directly inside the State object:
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    // Automatically tracked on access and safely unsubscribed on unmount:
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

> [!IMPORTANT]
> Only signals accessed *synchronously* during the execution of the <code>build</code> method are tracked.
> Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.


#### Members of `SignalStatefulWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStatefulWidget** | `constructor` | `SignalStatefulWidget({super.key})` | Constructor for [SignalStatefulWidget](/types/signalstatefulwidget). |
| **createElement** | `method` | `StatefulElement createElement()` |  |

---
### class `SignalStatefulElement`

Element for [SignalStatefulWidget](/types/signalstatefulwidget) that manages implicit signal subscription and handles dynamic branching.


#### Members of `SignalStatefulElement`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStatefulElement** | `constructor` | `SignalStatefulElement(super.widget)` | Constructor for [SignalStatefulElement](/types/signalstatefulelement). |
| **watchSignal** | `method` | `void watchSignal(core.ReadonlySignal value)` | Subscribes to changes of the provided **value** and schedules a rebuild. |
| **build** | `method` | `Widget build()` |  |
| **unmount** | `method` | `void unmount()` |  |

---
### class `SignalBuilder`

A premium, surgical builder widget that rebuilds locally on signal changes.

<code>SignalBuilder</code> tracks any signals read dynamically within its <code>builder</code> callback and
automatically subscribes to them. When any of these signals update, only the <code>SignalBuilder</code>
is rebuilt, preventing costly rebuilds of the surrounding widget subtree.

This widget provides predictable, immediate, and memory-safe subscription management,
automatically tearing down all active signal subscriptions when the builder is unmounted.

### Surgical Counter Example
```dart
final count = signal(0);

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This static text never rebuilds!'),
            const SizedBox(height: 20),
            // Only this specific Text widget rebuilds when 'count' changes:
            SignalBuilder(
              builder: (context) => Text(
                'Count: ${count.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

> [!TIP]
> Keep <code>SignalBuilder</code> widgets as small and leaf-level as possible in your tree to maximize
> rendering performance.


#### Members of `SignalBuilder`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalBuilder** | `constructor` | `SignalBuilder({super.key, required this.builder, this.dependencies = const []})` | Creates a [SignalBuilder](/types/signalbuilder) widget.

The **builder** is called to construct the widget tree and tracks read signals.
The optional **dependencies** allows explicitly specifying a list of signals to watch
regardless of whether they are read during the build phase. |
| **builder** | `field` | `Widget Function(BuildContext context) builder` | The widget to rebuild when any signals change. |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch. |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### class `SignalAnimatedBuilder`

A reactive builder widget designed for performance optimizations using child caching.

<code>SignalAnimatedBuilder</code> is the modern, drop-in replacement for Flutter's native **AnimatedBuilder**
or the deprecated <code>WatchBuilder</code>.

When you have a complex or computationally heavy widget subtree that does *not* depend on
any signal values, you should pass it as the **child** parameter. This subtree is cached
and is *never* rebuilt when the signals mutate, delivering a massive rendering boost.

### Performance Optimization Example
```dart
final count = signal(0);

class OptimizedCounter extends StatelessWidget {
  const OptimizedCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignalAnimatedBuilder(
        // 1. Define the heavy subtree once. It will be cached:
        child: const HeavyComplexSubtreeWidget(),

        // 2. The builder receives the cached child:
        builder: (context, cachedChild) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dynamic Count: ${count.value}'),
              const SizedBox(height: 20),
              // 3. Render the cached child directly:
              cachedChild!,
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

> [!TIP]
> Always use <code>SignalAnimatedBuilder</code> when rendering dynamic signal values alongside static,
> heavy subtrees. This minimizes CPU cycles and avoids rebuilding static layouts on frame updates.


#### Members of `SignalAnimatedBuilder`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalAnimatedBuilder** | `constructor` | `SignalAnimatedBuilder({super.key, required this.builder, this.child, this.debugLabel, this.dependencies = const []})` | Creates a [SignalAnimatedBuilder](/types/signalanimatedbuilder) widget.

The **builder** constructs the widget tree around the cached **child**.
The **dependencies** is an optional list of signals to watch explicitly. |
| **builder** | `field` | `Widget Function(BuildContext context, Widget? child) builder` | The widget to rebuild when any signals change. |
| **child** | `field` | `Widget? child` | Optional pre-built child subtree that does not rebuild. |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools. |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch. |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### class `SignalEffect`

A widget that enables executing scoped reactive side-effects inline within the widget tree.

<code>SignalEffect</code> (and its direct type alias **SignalListener**) allows you to run side-effects
(such as showing snackbars, opening dialogs, navigating, or logging metrics) in response
to signal updates, without triggering rebuilds of the child widget tree.

The [effect](/types/effect) callback runs immediately on mount and dynamically tracks any signals accessed
within its scope. The underlying subscription is automatically disposed when this widget
is removed from the tree. You can optionally return a cleanup function (e.g. <code>void Function()</code>)
to run before the next execution or when the widget is disposed.

### Dialog and Snackbar Trigger Example
```dart
final count = signal(0);

class SnackBarTrigger extends StatelessWidget {
  const SnackBarTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return SignalEffect(
      effect: (context) {
        // Triggers whenever 'count' updates:
        if (count.value >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Limit reached: ${count.value}!')),
          );
        }
        // Optional: return cleanup callback
        return () => print('Cleaning up effect');
      },
      child: ElevatedButton(
        onPressed: () => count.value++,
        child: const Text('Increment and Watch'),
      ),
    );
  }
}
```

> [!IMPORTANT]
> Do not perform synchronous state changes or trigger widget rebuilds directly inside
> the effect callback to prevent infinite reactive loops.


#### Members of `SignalEffect`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalEffect** | `constructor` | `SignalEffect({dynamic Function(BuildContext context)? effect, @Deprecated('Use effect instead') void Function(BuildContext context)? callback, required this.child, this.debugLabel, super.key})` | Creates a [SignalEffect](/types/signaleffect) widget.

The [effect](/types/effect) is executed inside a reactive effect.
The **child** is rendered normally. |
| **effect** | `method` | `dynamic Function(BuildContext context) effect` | Gets the effect callback to run inside the reactive effect. |
| **child** | `field` | `Widget child` | The child widget to render. |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label for the effect. |
| **createState** | `method` | `State<SignalEffect> createState()` |  |

---
### class `Watch`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

A deprecated widget for watching signal changes in the widget tree.

<Warning>
  <strong>DEPRECATED</strong>: Use <a href="/types/signalbuilder">SignalBuilder</a> instead for superior, self-contained reactivity
  and consistent API design.
</Warning>

### Migration to [SignalBuilder](/types/signalbuilder)
```dart
// Deprecated legacy pattern:
Watch((context) => Text('$counter'))

// Modern, streamlined pattern:
SignalBuilder(builder: (context) => Text('${counter.value}'))
```


#### Members of `Watch`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Watch** | `constructor` | `Watch(this.builder, {super.key, this.debugLabel, this.dependencies = const []})` | Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
Watch((context) => Text('$counter'))
``` |
| **Watch.builder** | `constructor` | `Watch.builder({super.key, required this.builder, this.debugLabel, this.dependencies = const []})` | Drop in replacement for the Flutter builder widget.

```dart
final counter = signal(0);
...
- Builder(
+ Watch.builder(
  builder: (context) {
    return Text('$counter');
  }
)
``` |
| **builder** | `field` | `T Function(BuildContext context) builder` | The widget to rebuild when any signals change |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### class `WatchBuilder`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

## WatchBuilder

To watch a signal for changes in Flutter, use the <code>WatchBuilder</code> widget. This will only rebuild this widget method and not the entire widget tree.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  return WatchBuilder(
    child: const Icon(Icons.add),
    builder: (context, child) => Row(children: [Text('$signal'), child!]),
  );
}
```


#### Members of `WatchBuilder`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **WatchBuilder** | `constructor` | `WatchBuilder({super.key, required this.builder, this.debugLabel, this.dependencies = const [], this.child})` | Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
WatchBuilder(
  builder: (context, child) => Text('$counter')
)
``` |
| **builder** | `field` | `T Function(BuildContext context, Widget? child) builder` | The widget to rebuild when any signals change |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools |
| **child** | `field` | `Widget? child` | Cached widget to pass in |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### extension `StatelessWidgetConvertWidgetExtension`

Extension to convert standard Flutter widgets to reactive Signal widgets.


#### Members of `StatelessWidgetConvertWidgetExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignalWidget** | `method` | `SignalWidget toSignalWidget()` | Converts this **StatelessWidget** to a [SignalWidget](/types/signalwidget). |

---
### extension `StatefulWidgetConvertWidgetExtension`

Extension to convert standard Flutter widgets to reactive Signal stateful widgets.


#### Members of `StatefulWidgetConvertWidgetExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignalStatefulWidget** | `method` | `SignalStatefulWidget toSignalStatefulWidget()` | Converts this **StatefulWidget** to a [SignalStatefulWidget](/types/signalstatefulwidget). |

---
### extension `StatelessElementConvertExtension`

Extension to convert standard Flutter elements to their reactive counterparts.


#### Members of `StatelessElementConvertExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **watchSignal** | `method` | `void watchSignal(dynamic signal)` | Intercepts build to watch a signal if the element is a [SignalElement](/types/signalelement). |

---
### extension `StatefulElementConvertExtension`

Extension to convert standard Flutter elements to their reactive counterparts.


#### Members of `StatefulElementConvertExtension`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **watchSignal** | `method` | `void watchSignal(dynamic signal)` | Intercepts build to watch a signal if the element is a [SignalStatefulElement](/types/signalstatefulelement). |

---
### class `ConvertedSignalWidget`

A wrapper [SignalWidget](/types/signalwidget) that wraps a **StatelessWidget**.


#### Members of `ConvertedSignalWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **widget** | `field` | `StatelessWidget widget` | The wrapped **StatelessWidget**. |
| **ConvertedSignalWidget** | `constructor` | `ConvertedSignalWidget(this.widget, {super.key})` | Creates a [ConvertedSignalWidget](/types/convertedsignalwidget). |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### class `ConvertedSignalStatefulWidget`

A wrapper [SignalStatefulWidget](/types/signalstatefulwidget) that wraps a **StatefulWidget**.


#### Members of `ConvertedSignalStatefulWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **widget** | `field` | `StatefulWidget widget` | The wrapped **StatefulWidget**. |
| **ConvertedSignalStatefulWidget** | `constructor` | `ConvertedSignalStatefulWidget(this.widget, {super.key})` | Creates a [ConvertedSignalStatefulWidget](/types/convertedsignalstatefulwidget). |
| **createElement** | `method` | `StatefulElement createElement()` |  |
| **createState** | `method` | `State<StatefulWidget> createState()` |  |

---
### class `ConvertedSignalStatefulElement`

Element for [ConvertedSignalStatefulWidget](/types/convertedsignalstatefulwidget) that overrides the widget getter
to return the wrapped **StatefulWidget**, preventing dynamic cast errors in **State.widget**.


#### Members of `ConvertedSignalStatefulElement`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ConvertedSignalStatefulElement** | `constructor` | `ConvertedSignalStatefulElement(ConvertedSignalStatefulWidget widget)` | Constructor for [ConvertedSignalStatefulElement](/types/convertedsignalstatefulelement). |

---
### class `TickerSignal`

Ticker signal used to drive animations and can create animation controllers

```dart
void main() {
  final ticker = TickerSignal(); // could be a global
  final controller = ticker.toAnimationController(); // can be local or global
  final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
  final alpha = IntTween(begin: 0, end: 255).animate(curve);
  ...
  final alphaSignal = alpha.toSignal(); // can be converted to a signal
}
```


#### Members of `TickerSignal`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **TickerSignal** | `constructor` | `TickerSignal({Duration? initialDuration, super.options, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel})` | Ticker signal used to drive animations and can create animation controllers

```dart
void main() {
  final ticker = TickerSignal(); // could be a global
  final controller = ticker.toAnimationController(); // can be local or global
  final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
  final alpha = IntTween(begin: 0, end: 255).animate(curve);
  ...
  final alphaSignal = alpha.toSignal(); // can be converted to a signal
}
``` |
| **createTicker** | `method` | `Ticker createTicker(TickerCallback onTick)` |  |
| **dispose** | `method` | `void dispose()` |  |
| **toAnimationController** | `method` | `AnimationController toAnimationController({double? value, Duration? duration, Duration? reverseDuration, String? debugLabel, double lowerBound = 0.0, double upperBound = 1.0, AnimationBehavior animationBehavior = AnimationBehavior.normal})` | Create a new **AnimationController** |

---
### function `tickerSignal`

Ticker signal used to drive animations and can create animation controllers

```dart
void main() {
  final ticker = tickerSignal(); // could be a global
  final controller = ticker.toAnimationController(); // can be local or global
  final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut); // can be used outside of widget tree
  final alpha = IntTween(begin: 0, end: 255).animate(curve);
  ...
  final alphaSignal = alpha.toSignal(); // can be converted to a signal
}
```

**Signature**:
```dart
TickerSignal tickerSignal({Duration? initialDuration, SignalOptions<Duration>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```


---
### mixin `SignalsMixin`
> [!WARNING]
> This API is deprecated. Avoid using it in new code.

A State mixin that automatically handles subscription and cleanup of signals
and effects created locally within a **StatefulWidget**.

<Warning>
<strong>DEPRECATED</strong>: This mixin is deprecated. While fully supported for backward compatibility,
it adds extra stateful widget lifecycle overhead and manual binding.

For superior, self-contained reactivity without mixin overhead, migrate to modern, high-performance APIs:
- Use <a href="/types/signalwidget">SignalWidget</a> for stateless reactive widgets.
- Use <a href="/types/signalstatefulwidget">SignalStatefulWidget</a> for stateful reactive widgets.
- Use <a href="/types/signalbuilder">SignalBuilder</a> for surgical, localized rebuilding.
</Warning>

### Legacy Usage Example
```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> with SignalsMixin {
  late final count = createSignal(0);
  late final doubled = createComputed(() => count.value * 2);

  @override
  void initState() {
    super.initState();
    createEffect(() {
      print('Count: ${count.value}, Doubled: ${doubled.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: ${count.value}'),
        Text('Doubled: ${doubled.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Modern Migration Example
```dart
// Modern alternative using SignalStatefulWidget:
class CounterWidget extends SignalStatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final count = signal(0);
  late final doubled = computed(() => count.value * 2);

  @override
  void initState() {
    super.initState();
    // For non-widget effects, use the standard `effect` function:
    effect(() {
      print('Count: ${count.value}, Doubled: ${doubled.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Implicitly tracks both signals and rebuilds on change:
    return Column(
      children: [
        Text('Count: ${count.value}'),
        Text('Doubled: ${doubled.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```


#### Members of `SignalsMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **disposeSignal** | `method` | `void disposeSignal(int id)` | Dispose and remove signal |
| **createComputedFrom** | `method` | `FutureSignal<S> createComputedFrom(List<ReadonlySignal<A>> signals, Future<S> Function(List<A> args) fn, {S? initialValue, String? debugLabel, bool lazy = true})` | Async Computed is syntax sugar around [FutureSignal](/types/futuresignal).

_Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._

computedFrom takes a list of **signals** and a **callback** function to
compute the value of the signal every time one of the **signals** changes.

```dart
final movieId = signal('id');
late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
```

Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await. |
| **createComputedAsync** | `method` | `FutureSignal<S> createComputedAsync(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})` | Async Computed is syntax sugar around [FutureSignal](/types/futuresignal).

_Inspired by [computedAsync](https://ngxtension.netlify.app/utilities/signals/computed-async/) from Angular NgExtension._

computedAsync takes a **callback** function to compute the value
of the signal. This callback is converted into a [Computed](/types/computed) signal.

```dart
final movieId = signal('id');
late final movie = computedAsync(() => fetchMovie(movieId()));
```

**It is important that signals are called before any async gaps with await.**

Any signal that is read inside the callback will be tracked as a dependency and the computed signal will be re-evaluated when any of the dependencies change. |
| **createFutureSignal** | `method` | `FutureSignal<S> createFutureSignal(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})` | Create a signal from a future |
| **createStreamSignal** | `method` | `StreamSignal<S> createStreamSignal(Stream<S> Function() callback, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, bool? cancelOnError, bool lazy = true})` | Create a signals from a stream |
| **createAsyncSignal** | `method` | `AsyncSignal<S> createAsyncSignal(AsyncState<S> value, {String? debugLabel})` | Create a signal holding an async value |
| **createSignal** | `method` | `FlutterSignal<V> createSignal(V val, {String? debugLabel})` | Create a <code>signal<T></code> and watch for changes |
| **createListSignal** | `method` | `ListSignal<V> createListSignal(List<V> list, {String? debugLabel})` | Create a [ListSignal](/types/listsignal) <code><T></code> and watch for changes |
| **createSetSignal** | `method` | `SetSignal<V> createSetSignal(Set<V> set, {String? debugLabel})` | Create a [SetSignal](/types/setsignal) <code><T></code> and watch for changes |
| **createQueueSignal** | `method` | `QueueSignal<V> createQueueSignal(Queue<V> queue, {String? debugLabel})` | Create a [QueueSignal](/types/queuesignal) <code><T></code> and watch for changes |
| **createMapSignal** | `method` | `MapSignal<K, V> createMapSignal(Map<K, V> value, {String? debugLabel})` | Create a [MapSignal](/types/mapsignal) <code><K, V></code> and watch for changes |
| **createComputed** | `method` | `FlutterComputed<V> createComputed(V Function() cb, {String? debugLabel})` | Create a <code>computed<T></code> and watch for changes |
| **bindSignal** | `method` | `S bindSignal(S val)` | Bind an existing <code>signal<T></code> and watch for changes |
| **unbindSignal** | `method` | `S unbindSignal(S val)` | Unbind an existing <code>signal<T></code> changes |
| **watchSignal** | `method` | `V watchSignal(S val)` | Watch signal value |
| **unwatchSignal** | `method` | `V unwatchSignal(S val)` | Unwatch an existing <code>signal<T></code> value changes |
| **listenSignal** | `method` | `void listenSignal(ReadonlySignal<dynamic> target, void Function() callback, {String? debugLabel})` | Watch signal value |
| **unlistenSignal** | `method` | `void unlistenSignal(ReadonlySignal<dynamic> target, void Function() callback)` | Stop listening to a signal value |
| **createEffect** | `method` | `EffectCleanup createEffect(dynamic Function() cb, {String? debugLabel, dynamic Function()? onDispose})` | Create a effect.

Do not call inside the build method.

Calling this method in build() will create a new
effect every render. |
| **clearSignalsAndEffects** | `method` | `void clearSignalsAndEffects()` | Reset all stored signals and effects |
| **dispose** | `method` | `void dispose()` |  |

---
### class `ValueListenableSignalMixin`

**ValueListenable** implementation for [ReadonlySignal](/types/readonlysignal)


#### Members of `ValueListenableSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **runCallbackOnListen** | `method` | `bool runCallbackOnListen` | If true, the callback will be run when the listener is added |
| **addListener** | `method` | `void addListener(VoidCallback listener)` |  |
| **removeListener** | `method` | `void removeListener(VoidCallback listener)` |  |

---
### class `ValueNotifierSignalMixin`

**ValueNotifier** implementation for [Signal](/types/signal)


#### Members of `ValueNotifierSignalMixin`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **runCallbackOnListen** | `method` | `bool runCallbackOnListen` | If true, the callback will be run when the listener is added |
| **addListener** | `method` | `void addListener(VoidCallback listener)` |  |
| **removeListener** | `method` | `void removeListener(VoidCallback listener)` |  |
| **hasListeners** | `method` | `bool hasListeners` |  |
| **notifyListeners** | `method` | `void notifyListeners()` |  |

---
### class `SignalProvider`

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


#### Members of `SignalProvider`
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

---
### class `MultiSignalProvider`

A dependency-injection / state propagation widget that allows passing
multiple reactive signals down the Flutter widget tree.

This avoids the deeply nested trees that result from nesting multiple
single [SignalProvider](/types/signalprovider) widgets.


#### Members of `MultiSignalProvider`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MultiSignalProvider** | `constructor` | `MultiSignalProvider({super.key, required this.providers, required this.child})` | Exposes multiple [SignalProvider](/types/signalprovider) widgets inside a flat list. |
| **providers** | `field` | `List<SignalProvider> providers` | The list of single [SignalProvider](/types/signalprovider) widgets to nest. |
| **child** | `field` | `Widget child` | The widget subtree that will have access to the provided signals. |
| **build** | `method` | `Widget build(BuildContext context)` |  |

---
### class `SignalCustomPainter`

A premium custom painter that automatically repaints when any observed signal changes,
bypassing Flutter's widget build and layout phases completely.

<code>SignalCustomPainter</code> registers subscriptions to the provided list of **signals**. When any
of these signals fire, a GPU repaint is scheduled directly via <code>markNeedsPaint()</code>, bypassing
the widget-tree build cycle and layout passes for unmatched graphics performance.

### Interactive Star Field Canvas Example
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final cursorOffset = signal(const Offset(0, 0));

class StarField extends StatelessWidget {
  const StarField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        cursorOffset.value = details.localPosition;
      },
      child: Container(
        color: const Color(0xFF0B0D19),
        child: SignalCustomPaint(
          painter: StarPainter(cursorOffset),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class StarPainter extends SignalCustomPainter {
  StarPainter(this.offsetSignal) : super(signals: [offsetSignal]);

  final ReadonlySignal<Offset> offsetSignal;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw 100 stars deterministically distributed across the canvas size
    for (int i = 0; i < 100; i++) {
      final double x = ((i * 197) % 1000) / 1000 * size.width;
      final double y = ((i * 541) % 1000) / 1000 * size.height;
      final double starSize = ((i * 7) % 4) + 1.5;

      final starPos = Offset(x, y);
      final distance = (starPos - offsetSignal.value).distance;

      if (distance < 120.0) {
        // Spotlight/Twinkle effect: make stars near the cursor brighter & larger!
        final factor = 1.0 - (distance / 120.0);
        paint.color = Colors.amber.withOpacity(0.3 + 0.7 * factor);
        final glowSize = starSize + (factor * 4.0);
        canvas.drawCircle(starPos, glowSize, paint);

        // Draw premium constellation lines connecting nearby stars to the cursor
        final linePaint = Paint()
          ..color = Colors.amber.withOpacity(0.25 * factor)
          ..strokeWidth = 1.0;
        canvas.drawLine(offsetSignal.value, starPos, linePaint);
      } else {
        // Normal distant star
        paint.color = Colors.white.withOpacity(0.4);
        canvas.drawCircle(starPos, starSize, paint);
      }
    }

    // Draw the interactive controller glow source
    final cursorPaint = Paint()
      ..color = Colors.amber.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
    canvas.drawCircle(offsetSignal.value, 6.0, cursorPaint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
```


#### Members of `SignalCustomPainter`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **signals** | `field` | `List<core.ReadonlySignal<dynamic>> signals` | The list of signals to observe for changes. |
| **SignalCustomPainter** | `constructor` | `SignalCustomPainter({required this.signals})` | Creates a new [SignalCustomPainter](/types/signalcustompainter). |
| **paint** | `method` | `void paint(Canvas canvas, Size size)` | Paint on the canvas. |
| **shouldRepaint** | `method` | `bool shouldRepaint(covariant SignalCustomPainter oldDelegate)` | Return true if the painter should be updated when the widget configuration changes. |

---
### class `SignalCustomPaint`

A high-performance canvas painting widget that subscribes to signals and renders
directly on the GPU, completely bypassing the widget build and layout phases.

Use <code>SignalCustomPaint</code> in performance-critical rendering scenarios like real-time charts,
complex visual animations, particle systems, or game loops.


#### Members of `SignalCustomPaint`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **painter** | `field` | `SignalCustomPainter painter` | The painter to draw on the canvas. |
| **SignalCustomPaint** | `constructor` | `SignalCustomPaint({super.key, required this.painter, super.child})` | Creates a new [SignalCustomPaint](/types/signalcustompaint). |
| **createRenderObject** | `method` | `RenderSignalCustomPaint createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalCustomPaint renderObject)` |  |

---
### class `RenderSignalCustomPaint`

The **RenderObject** for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter).


#### Members of `RenderSignalCustomPaint`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalCustomPaint** | `constructor` | `RenderSignalCustomPaint({required SignalCustomPainter painter})` | Creates a new [RenderSignalCustomPaint](/types/rendersignalcustompaint). |
| **painter** | `method` | `SignalCustomPainter painter` | Gets the custom painter delegate. |
| **painter** | `method` | `painter(SignalCustomPainter val)` | Sets a new custom painter delegate and triggers a repaint if necessary. |
| **paint** | `method` | `void paint(PaintingContext context, Offset offset)` |  |

---
### class `RenderSignalProxyBox`

A low-level **RenderProxyBox** that subscribes to multiple reactive signals
and automatically schedules repaints without layout/rebuild when signals fire.


#### Members of `RenderSignalProxyBox`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalProxyBox** | `constructor` | `RenderSignalProxyBox({required List<core.ReadonlySignal<dynamic>> signals})` | Creates a new [RenderSignalProxyBox](/types/rendersignalproxybox) with the specified list of observed **signals**. |
| **signals** | `method` | `List<core.ReadonlySignal<dynamic>> signals` | Gets the current list of signals being observed. |
| **signals** | `method` | `signals(List<core.ReadonlySignal<dynamic>> val)` | Sets a new list of observed signals and resubscribes to them. |
| **detach** | `method` | `void detach()` |  |

---
### class `SignalProxyWidget`

A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs.


#### Members of `SignalProxyWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **signals** | `field` | `List<core.ReadonlySignal<dynamic>> signals` | The list of signals to observe. |
| **SignalProxyWidget** | `constructor` | `SignalProxyWidget({super.key, required this.signals, super.child})` | Creates a new [SignalProxyWidget](/types/signalproxywidget). |
| **createRenderObject** | `method` | `RenderSignalProxyBox createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalProxyBox renderObject)` |  |

---
### class `SignalPainterWidget`

A high-performance, leaf render-object widget driven by a double progress signal.

<code>SignalPainterWidget</code> bypasses the entire widget build and layout phases, subscribing
directly to a **progress** signal and rendering on the canvas. When **progress** updates,
only the GPU paint phase is run.

### Example
```dart
final progress = signal(0.0);

@override
Widget build(BuildContext context) {
  return SignalPainterWidget(
    progress: progress,
    painter: (canvas, size, value) {
      final paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        value * 50.0,
        paint,
      );
    },
  );
}
```


#### Members of `SignalPainterWidget`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **progress** | `field` | `core.ReadonlySignal<double> progress` | The progress signal whose value will be passed to **painter**. |
| **painter** | `field` | `void Function(Canvas canvas, Size size, double value) painter` | The custom painting callback function. |
| **SignalPainterWidget** | `constructor` | `SignalPainterWidget({super.key, required this.progress, required this.painter})` | Creates a new [SignalPainterWidget](/types/signalpainterwidget). |
| **createRenderObject** | `method` | `RenderSignalBox createRenderObject(BuildContext context)` |  |
| **updateRenderObject** | `method` | `void updateRenderObject(BuildContext context, RenderSignalBox renderObject)` |  |

---
### class `RenderSignalBox`

The low-level **RenderBox** used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint.


#### Members of `RenderSignalBox`
| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **RenderSignalBox** | `constructor` | `RenderSignalBox({required core.ReadonlySignal<double> progress, required void Function(Canvas canvas, Size size, double value) painter})` | Creates a new [RenderSignalBox](/types/rendersignalbox) drawing using **_painter** and driven by **_progress** signal. |
| **progress** | `method` | `progress(core.ReadonlySignal<double> val)` | Sets a new progress signal and resubscribes to updates. |
| **painter** | `method` | `painter(void Function(Canvas canvas, Size size, double value) val)` | Sets a new custom painter delegate. |
| **performLayout** | `method` | `void performLayout()` |  |
| **paint** | `method` | `void paint(PaintingContext context, Offset offset)` |  |
| **detach** | `method` | `void detach()` |  |

---
