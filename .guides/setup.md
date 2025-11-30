# Setup

## Flutter App

For most Flutter applications, use the `signals` package which includes both core and flutter extensions.

```yaml
dependencies:
  signals: ^6.2.0
```

## Pure Dart

For CLI tools, servers, or other pure Dart projects, use `signals_core`.

```yaml
dependencies:
  signals_core: ^6.2.0
```

## Flutter Hooks

If you are using `flutter_hooks`, add `signals_hooks`.

```yaml
dependencies:
  signals_hooks: ^6.2.0
```

## Flutter Specific (Standalone)

If you only need the Flutter extensions without the main bundle (rare), use `signals_flutter`.

```yaml
dependencies:
  signals_flutter: ^6.2.0
```
