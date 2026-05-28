# signals_lint

Linter and developer tools for [signals](https://pub.dev/packages/signals).

This package is built on Dart's official standard `analysis_server_plugin` framework, meaning it runs natively inside the Dart Analysis Server. You get real-time lint warnings, suggestions, and automated quick-fixes/assists directly in your IDE (VS Code, Android Studio, IntelliJ) and via standard terminal commands.

---

## Getting Started

### 1. Add dependency

Add `signals_lint` to the `dev_dependencies` of your Dart or Flutter project:

```sh
dart pub add -d signals_lint
```

### 2. Configure analyzer plugin

Edit your `analysis_options.yaml` file to register `signals_lint` as an analyzer plugin:

```yaml
analyzer:
  plugins:
    - signals_lint
```

### 3. Run analysis

Verify that the plugin is running by executing:

```sh
dart analyze
# or for Flutter projects
flutter analyze
```

---

## Lint Rules

| Rule Name | Severity | Description |
| :--- | :--- | :--- |
| `signals_avoid_create_in_build_method` | **Warning** | Warns against creating signals inside widget `build` methods. |
| `signals_avoid_deprecated_watch_extension` | **Warning** | Flags deprecated `.watch(context)` and `.unwatch()` extensions. |
| `signals_avoid_deprecated_signals_mixin` | **Warning** | Flags usages of the legacy `SignalsMixin`. |
| `signals_prefer_named_builder` | **Info** | Encourages using named builder constructor arguments over positional parameters. |
| `signals_prefer_unified_options` | **Info** | Recommends consolidation of configuration parameters under unified option objects. |

---

## Automated IDE Assists & Quick-Fixes

### 1. Wrap with SignalBuilder

Quickly wraps any widget in a `SignalBuilder` to reactively rebuild it whenever referenced signals emit updates.

**Before:**
```dart
class MyWidget extends StatelessWidget {
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}
```

**After (via automated assist):**
```dart
class MyWidget extends StatelessWidget {
  final count = signal(0);

  @override
  Widget build(BuildContext context) {
    return SignalBuilder(
      builder: (context) => Text('Count: $count'),
    );
  }
}
```

### 2. Convert StatelessWidget to SignalWidget

Converts a standard `StatelessWidget` to `SignalWidget` to optimize reactive widget builds.

**Before:**
```dart
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}
```

**After (via automated assist):**
```dart
class CounterView extends SignalWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}
```

### 3. Convert StatefulWidget to SignalStatefulWidget

Refactors a standard `StatefulWidget` to a `SignalStatefulWidget` to gain built-in signal utilities.

---

## Core Packages

| Package | Pub |
| :--- | :--- |
| `signals` | [![signals](https://img.shields.io/pub/v/signals.svg)](https://pub.dev/packages/signals) |
| `signals_core` | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core) |
| `signals_flutter` | [![signals_flutter](https://img.shields.io/pub/v/signals_flutter.svg)](https://pub.dev/packages/signals_flutter) |
