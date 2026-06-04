# Signals.dart Monorepo

Welcome to the `signals.dart` monorepo, a high-performance reactivity ecosystem for Dart and Flutter.

## Project Structure

This project is managed with [Melos](https://melos.invertase.dev/) and follows a modular architecture.

### [packages/](packages/CONTEXT.md)
The core library ecosystem.
- **`preact_signals`**: The low-level internal reactivity engine.
- **`signals_core`**: The primary Dart API with advanced types and extensions.
- **`signals_flutter`**: Native Flutter widgets and lifecycle management.
- **`signals`**: The user-facing umbrella package.
- **`signals_lint`**: Custom linter rules for best practices.
- **`signals_hooks`**: Integration for `flutter_hooks` users.
- **`signals_devtools_extension`**: Inspector for the Flutter DevTools.

### [examples/](examples/CONTEXT.md)
A broad collection of sample projects:
- **Flutter**: Counter, Shopping Cart, Infinite Scroll, Animations.
- **Pure Dart**: CLI examples, integration with code generation.
- **Experimental**: HTML Canvas, Node-based editors.

### [skills/](skills/CONTEXT.md)
Specialized developer guidelines and AI coding assistant prompts that cover pure Dart reactivity, Flutter widgets, and major version migrations.

### Supporting Directories
- **[scripts/](scripts/)**: Automation for project maintenance and documentation.
- **[website/](website/)**: Source code for the [dartsignals.dev](https://dartsignals.dev) documentation.

## Core Philosophies

1. **Fine-grained Reactivity**: Only rebuild exactly what changed.
2. **Lazy Evaluation**: Computed values are only calculated when actually needed.
3. **Implicit Dependency Tracking**: Automatically knows what to update based on what is read.
4. **Garbage Collection Aware**: Designed to prevent memory leaks by automatically unsubscribing when observers are no longer reachable.

## Development Workflow

- **Setup**: `melos bootstrap`
- **Testing**: `melos run test`
- **Analysis**: `melos run analyze`
- **Docs**: Full documentation available at [dartsignals.dev](https://dartsignals.dev).
