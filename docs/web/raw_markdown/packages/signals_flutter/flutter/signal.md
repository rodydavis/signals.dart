---
title: FlutterSignal
description: A mutable, reactive state cell that exposes both standard Signals and Flutter.
---

A mutable, reactive state cell that exposes both standard Signals and Flutter
**ValueNotifier** interfaces.

`FlutterSignal` extends the core `Signal` class and mixes in `ValueNotifierSignalMixin`,
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


### Constructors

##### <a name="fluttersignal"></a><a name="fluttersignal"></a>`FlutterSignal(super.internalValue, {super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})`

Simple writeable signal.

```dart
final count = signal(0);
print(count.value); // 0
count.value++;
print(count.value); // 1
```

##### <a name="fluttersignal-lazy"></a><a name="lazy"></a>`FlutterSignal.lazy({super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})`

Lazy signal that can be created with type T that
the value will be assigned later.

```dart
final db = FlutterSignal.lazy<DatabaseConnection>();
...
db.value = DatabaseConnect(...);
```


### Properties

##### <a name="runcallbackonlisten"></a>`bool runCallbackOnListen`
