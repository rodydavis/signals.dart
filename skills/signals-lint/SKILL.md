---
name: signals-lint
description: Standardized compiler diagnostics, static analysis lints, and automated IDE quick-fixes.
---

# signals_lint Tooling & Rules

This skill covers working with static code analysis, custom compiler warning diagnostics, and automated quick-fixes in the **signals.dart** ecosystem.

---

## 🚀 Activation & Setup

Ensure the plugin is active in your project to enable real-time IDE diagnostics and fixes:

```yaml
# pubspec.yaml
dev_dependencies:
  custom_lint: ^0.8.1
  signals_lint: ^7.0.0
```

```yaml
# analysis_options.yaml
analyzer:
  plugins:
    - custom_lint
```

---

## 🛡️ Lint Rules Reference

### 1. `signals_avoid_create_in_build_method`
Flags instances where a signal or computed variable is created inside a Flutter `build` method.
- **Problem**: Creating state during build causes state to reset on every rebuild.
- **Solution**: Move the creation to the class fields or initialize inside a state lifecycle hook.

---

### 2. `signals_avoid_deprecated_watch_extension`
Flags uses of deprecated `BuildContext.watch()` and `BuildContext.unwatch()` extensions.
- **Problem**: Watch extensions can cause broad stateful widget lifecycle overhead.
- **Solution**: Use localized `SignalBuilder` or inherit from `SignalWidget`/`SignalStatefulWidget`.

---

### 3. `signals_avoid_deprecated_signals_mixin`
Flags usage of deprecated `with SignalsMixin` mixins on StatefulWidget states.
- **Problem**: Inherits stateful widget tracking hooks unnecessarily.
- **Solution**: Inherit from `SignalStatefulWidget` instead.

---

### 4. `signals_prefer_named_builder`
Enforces named `builder:` callbacks in `SignalBuilder` and `Watch` elements instead of positional arguments.
- **Reason**: Guarantees standard API parameters and readability.

---

### 5. `signals_prefer_unified_options`
Flags direct creator configuration arguments (e.g. `autoDispose: true`).
- **Solution**: Bundle configuration properties under unified options classes (e.g., `options: SignalOptions(autoDispose: true)`).

---

## 💡 Automated IDE Code Assists (Quick-fixes)

Place your cursor on the relevant class name or widget instantiation inside your IDE to reveal these automatic assists via the quick-fix menu (`Cmd+.` or `Alt+Enter`):

1. **`WrapWithSignalBuilder`**: Wraps any widget expression inside `SignalBuilder(builder: (context) => ...)`.
2. **`ConvertStatelessToSignalWidget`**: Refactors a standard `StatelessWidget` into a `SignalWidget` instantly.
3. **`ConvertStatefulToSignalStatefulWidget`**: Refactors a standard `StatefulWidget` to a `SignalStatefulWidget`.
4. **`MigrateSignalsMixinToSignalStatefulWidget`**: Strips the legacy `SignalsMixin` and converts the class structure to `SignalStatefulWidget`.
5. **`MigrateWatchToSignalBuilder`**: Converts legacy `Watch(...)` instances into clean `SignalBuilder` widgets.
