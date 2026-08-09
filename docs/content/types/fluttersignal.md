---
title: "Type: FlutterSignal"
description: "API reference and details for FlutterSignal from signals.dart."
---

# FlutterSignal

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Class: FlutterSignal

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

### Members of FlutterSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FlutterSignal** | <code>constructor</code> | <code>dart FlutterSignal(super.internalValue, {super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})</code> | Simple writeable signal. |
| **FlutterSignal.lazy** | <code>constructor</code> | <code>dart FlutterSignal.lazy({super.options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') super.autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') super.debugLabel, this.runCallbackOnListen = false})</code> | Lazy signal that can be created with type T that |
| **runCallbackOnListen** | <code>field</code> | <code>dart bool runCallbackOnListen</code> |  |

## References

The **FlutterSignal** type is referenced and used in the following pages:

* [Persisted Signals](/guides/persisted-signals) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FlutterSignal](/packages/signals_flutter/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FlutterSignal](/packages/signals/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [Lazy Signal](/packages/signals/extensions/lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [useSignal](/packages/signals_hooks/hooks/use-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

