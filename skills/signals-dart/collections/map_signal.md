# `MapSignal<K, V>` (Reactive Maps)

`MapSignal<K, V>` wraps standard Dart maps to enable dynamic tracking of dictionary-like reactive state.

---

## 1. Creation

```dart
final config = mapSignal(
  {'theme': 'dark', 'volume': 80},
  options: MapSignalOptions(
    name: 'config_map',
  ),
);
```

---

## 2. Mutations
```dart
config['theme'] = 'light'; // Triggers update
```
- **Granular Updates**: Accessing keys dynamically registers subscriptions for just those elements, preventing broad global renders where possible.
