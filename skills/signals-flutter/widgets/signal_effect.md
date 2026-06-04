# `SignalEffect` / `SignalListener`

`SignalEffect` (aliased as `SignalListener`) executes asynchronous or procedural side effects inside the Flutter lifecycle, avoiding direct side-effects during layout build phases.

---

## 1. Creation

```dart
final errorMessage = signal<String?>(null);

Widget build(BuildContext context) {
  return SignalEffect(
    effect: (context) {
      if (errorMessage.value != null) {
        // Trigger dialog asynchronously
        showDialog(
          context: context,
          builder: (_) => AlertDialog(title: Text(errorMessage.value!)),
        );
      }

      // Optional: Return a cleanup function
      return () {
        print('Cleaning up error dialog effect...');
      };
    },
    child: const MainView(),
  );
}
```

---

## 2. Advantages
- **Safe Lifecycle Sync**: Executes within standard layout callbacks rather than mid-build, avoiding unsafe framework state mutations.
- **Auto Disposal**: Correctly cancels and cleans up subscriptions on component destruction.
