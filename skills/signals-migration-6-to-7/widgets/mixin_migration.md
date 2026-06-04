# SignalsMixin Migration

In version 7.0.0, `SignalsMixin` has been deprecated due to the performance overhead of full widget subtree tracking and lifecycle cleanup.

---

## 1. Migrating to `SignalWidget`

If you had a stateless or stateful widget that relied on `with SignalsMixin`, migrate it to a `SignalWidget` or localized `SignalBuilder` wrappers.

- **Before**:
  ```dart
  class CounterScreen extends StatefulWidget {
    const CounterScreen({super.key});
    @override
    State<CounterScreen> createState() => _CounterScreenState();
  }

  class _CounterScreenState extends State<CounterScreen> with SignalsMixin {
    @override
    Widget build(BuildContext context) {
      return Text('Count: ${counter.value}');
    }
  }
  ```
- **After (Subclassing)**:
  ```dart
  class CounterScreen extends SignalWidget {
    const CounterScreen({super.key});

    @override
    Widget build(BuildContext context) {
      // Subscribes dynamically on element level
      return Text('Count: ${counter.value}');
    }
  }
  ```
- **After (Localized Builders - Recommended)**:
  ```dart
  class CounterScreen extends StatelessWidget {
    const CounterScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: SignalBuilder(
            builder: (context, value) => Text('Count: $value'),
          ),
        ),
      );
    }
  }
  ```
