---
title: RxDart
description: Using Signals with RxDart
---

How to connect Signals with RxDart:

```dart
import 'dart:html';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:signals/signals.dart';

void main() {
  const konamiKeyCodes = <int>[
    KeyCode.UP,
    KeyCode.UP,
    KeyCode.DOWN,
    KeyCode.DOWN,
    KeyCode.LEFT,
    KeyCode.RIGHT,
    KeyCode.LEFT,
    KeyCode.RIGHT,
    KeyCode.B,
    KeyCode.A,
  ];

  final konami = signal(false);
  final konamiText = computed(() {
    if (konami.value) {
      return 'KONAMI!';
    } else {
      return 'Press the Konami Code! (↑ ↑ ↓ ↓ ← → ← → B A)';
    }
  });

  effect(() {
    final result = querySelector('#result')!;
    result.innerHtml = konamiText.value;
  });

  final konamiStream = document.onKeyUp
      .map((event) => event.keyCode)
      .bufferCount(10, 1)
      .where((lastTenKeyCodes) => const IterableEquality<int>().equals(
            lastTenKeyCodes,
            konamiKeyCodes,
          ))
      .map((_) => konami.value = true)
      .startWith(false);

  connect(konami).to(konamiStream);
}
```
