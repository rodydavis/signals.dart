# `LinkedSignal<T>` (Writable Computed)

A `LinkedSignal<T>` behaves like a `Computed<T>` signal by default, deriving its value from other upstream signals, but also allows direct manual mutation overrides.

---

## 1. Creation and Shorthand

```dart
final source = signal('Alice');

// Shorthand creation
final name = linkedSignal(() => source.value);

print(name.value); // 'Alice'
name.value = 'Bob'; // Manual override
print(name.value); // 'Bob'

source.value = 'Charlie'; // Upstream source updates, resetting override!
print(name.value); // 'Charlie'
```

---

## 2. Advanced Comparison Customization

You can use `LinkedSignalOptions` to define custom reset and preservation criteria based on structural object comparisons.

```dart
final user = signal((id: 1, name: 'Alice'));

final displayName = linkedSignal<String, ({int id, String name})>(
  () => user.value,
  options: LinkedSignalOptions(
    computation: (u, prev) {
      // If the active user ID matches the previous, keep the override!
      if (prev != null && prev.source.id == u.id) {
        return prev.value;
      }
      return u.name; // Else, reset
    },
  ),
);
```
