---
title: Installing
description: How to install Signals
---

Signals can run anywhere Dart can run including VM, WASM, Dart to JS, Dart to Native, Flutter, and on the server.

_Signals is a single package that contains the imports for flutter and dart and may not show the correct platforms on pub.dev (doesn't show dart only)._

## Stable

`Signals.dart` is available on pub.dev:

| Package           | Pub                                                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------|
| `signals`         | [![signals](https://img.shields.io/pub/v/signals.svg)](https://pub.dev/packages/signals)                         |
| `signals_core`    | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core)          |
| `signals_flutter` | [![signals_flutter](https://img.shields.io/pub/v/signals_flutter.svg)](https://pub.dev/packages/signals_flutter) |
| `signals_lint`    | [![signals_lint](https://img.shields.io/pub/v/signals_lint.svg)](https://pub.dev/packages/signals_lint)          |

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  signals: latest
```

or from the command line:

```bash
$ dart pub add signals
```

Or if you're using Flutter:

```bash
$ flutter pub add signals
```

### Usage

```dart
import 'package:signals/signals.dart';
```

or if you're using Flutter:

```dart
import 'package:signals/signals_flutter.dart';
```

## Unstable

To reference the package from GitHub:

```yaml
dependencies:
  signals:
    git:
      url: https://github.com/rodydavis/signals.dart
      ref: main
```
