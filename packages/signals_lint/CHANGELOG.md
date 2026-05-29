## 7.1.0

- Bump signals dev-dependency to 7.2.0

## 7.0.0

- Bump `signals` dev-dependency to `^7.0.0`.
- Upgrade and extend all lint rules and diagnostics to support the new v7 API patterns:
  - Robust check for `signals_avoid_create_in_build_method` tracking inline creations, helpers, and all signal types inside build methods.
  - New **`signals_avoid_deprecated_watch_extension`** lint rule checking for deprecated `.watch()` and `.unwatch()` extensions.
  - New **`signals_avoid_deprecated_signals_mixin`** lint rule flagging legacy `SignalsMixin` usages.
  - New **`signals_prefer_named_builder`** lint rule encouraging named `builder:` callbacks in `SignalBuilder`.
  - New **`signals_prefer_unified_options`** lint rule checking direct creator arguments in favor of options objects.
- Introduce highly powerful, automated IDE code assists:
  - **`WrapWithSignalBuilder`**: Quick-fix to wrap any widget in a targeted `SignalBuilder`.
  - **`ConvertStatelessToSignalWidget`**: Refactor `StatelessWidget` to high-performance `SignalWidget`.
  - **`ConvertStatefulToSignalStatefulWidget`**: Refactor `StatefulWidget` to `SignalStatefulWidget`.
  - **`MigrateSignalsMixinToSignalStatefulWidget`**: Clean up `SignalsMixin` and transition to `SignalStatefulWidget` automatically.
  - **`MigrateWatchToSignalBuilder`**: Upgrade positional or named `Watch` widgets to `SignalBuilder`.

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
