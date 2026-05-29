## 7.1.0

- **Architecture Migration**: Fully migrated the package from `custom_lint` to Dart's official standard `analysis_server_plugin` framework.
  - Now runs out-of-the-box using the built-in Dart Analysis Server.
  - Native IDE integrations for VS Code, Android Studio, and IntelliJ without running separate server processes.
  - Runs natively via standard `dart analyze` or `flutter analyze` commands.
- **5 core lint rules and diagnostics**:
  - `signals_avoid_create_in_build_method`: Alerts when creating signals inside widget `build` methods (which reinstantiates them on every frame).
  - `signals_avoid_deprecated_watch_extension`: Warns on using the deprecated `.watch(context)` and `.unwatch()` extensions.
  - `signals_avoid_deprecated_signals_mixin`: Flags classes using the legacy `SignalsMixin`.
  - `signals_prefer_named_builder`: Recommends using the named constructor or parameter for `SignalBuilder`.
  - `signals_prefer_unified_options`: Warns when passing scattered creator arguments in favor of consolidated options objects.
- **5 automated IDE code assists & quick-fixes**:
  - `Wrap with SignalBuilder`: Wraps any widget in a `SignalBuilder` to react to signal changes.
  - `Convert StatelessWidget to SignalWidget`: Instantly refactors a `StatelessWidget` to `SignalWidget`.
  - `Convert StatefulWidget to SignalStatefulWidget`: Refactors a standard `StatefulWidget` to `SignalStatefulWidget`.
  - `Migrate SignalsMixin to SignalStatefulWidget`: Automatically transitions legacy `SignalsMixin` usages to the modern `SignalStatefulWidget` state flow.
  - `Migrate Watch to SignalBuilder`: Converts deprecated `Watch` widgets to `SignalBuilder`.

## 6.3.1

## 5.0.0

- add `signals_avoid_create_in_build_method` to show a warning for signals created in the build method
- Bump `signals` to 5.0.0

## 4.2.0

- Bump `signals` to 4.2.0

## 1.1.0

- Bump `signals` to 2.0.0

## 1.0.0

- Add 'Wrap with Watch' fix
