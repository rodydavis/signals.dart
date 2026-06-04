---
title: Installing
description: Learn how to install and configure Signals for pure Dart, Flutter, and developer tooling.
---

Signals is built with zero external dependencies and runs anywhere Dart can execute—including the Dart VM, Flutter (iOS, Android, macOS, Windows, Linux, Web), Web (WASM, JS), and server-side environments.

<Info>
  <strong>Unified Package</strong>: The standard <code>signals</code> package is a unified library that automatically selects the correct Dart-only or Flutter-native bindings depending on your target platform. In most cases, this is the only dependency you need!
</Info>

---

## Quick Start

Add the stable release of Signals to your project using the command line:

**For pure Dart projects:**
```bash
dart pub add signals
```

**For Flutter projects:**
```bash
flutter pub add signals
```

---

## Package Directory

For modular development, the ecosystem is divided into specific packages depending on your architecture:

| Package | Purpose | Target | Pub Badge |
| :--- | :--- | :--- | :--- |
| **<code>signals</code>** | Full reactive framework (includes Flutter bindings) | Dart & Flutter | [![signals](https://img.shields.io/pub/v/signals.svg)](https://pub.dev/packages/signals) |
| **<code>signals_flutter</code>** | UI-bound reactive components and <code>.watch(context)</code> extensions | Flutter Only | [![signals_flutter](https://img.shields.io/pub/v/signals_flutter.svg)](https://pub.dev/packages/signals_flutter) |
| **<code>signals_core</code>** | Zero-dependency, ultra-fast reactive primitives | Pure Dart / Web | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core) |
| **<code>signals_lint</code>** | Real-time static analysis and IDE quick-fixes | Dev Tooling | [![signals_lint](https://img.shields.io/pub/v/signals_lint.svg)](https://pub.dev/packages/signals_lint) |
| **<code>preact_signals</code>** | Direct low-overhead Dart port of Preact.js Signals | Core Engine | [![preact_signals](https://img.shields.io/pub/v/preact_signals.svg)](https://pub.dev/packages/preact_signals) |

---

## Manual Configuration (<code>pubspec.yaml</code>)

If you prefer to configure dependencies manually, add the following to your <code>pubspec.yaml</code> file:

### Stable Release (Recommended)
```yaml
dependencies:
  signals: ^7.0.0
```

### Development Release (Direct from Git)
To track the latest updates on the main branch of the repository:
```yaml
dependencies:
  signals:
    git:
      url: https://github.com/rodydavis/signals.dart
      ref: main
      path: packages/signals
```

---

## Linter Integration (<code>signals_lint</code>)

To guarantee best practices and catch performance gotchas before they hit production, we highly recommend integrating <code>signals_lint</code> into your development environment.

It automatically scans your code in real-time to alert you of common mistakes (such as creating signals inside Flutter <code>build</code> methods or reactive <code>effect</code> blocks) and provides automatic IDE quick-fixes.

### 1. Add Developer Dependency
Add the linter package under <code>dev_dependencies</code> in your <code>pubspec.yaml</code>:

```yaml
dev_dependencies:
  signals_lint: ^7.0.0
```

### 2. Enable Analyzer Plugin
Activate the plugin in your project's <code>analysis_options.yaml</code> file:

```yaml
analyzer:
  plugins:
    - signals_lint
```

Once added, restart your editor's Dart Analysis server to start receiving real-time warnings and quick-fixes directly in your IDE!
