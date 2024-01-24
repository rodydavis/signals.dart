---
title: Installing
description: How to install Signals
---

Signals can run anywhere Dart can run including VM, WASM, Dart to JS, Dart to Native, Flutter, and on the server.

Signals is a single package that contains the imports for flutter and dart and may not show the correct platforms on pub.dev (doesn't show dart only).

`Signals.dart` is available on [pub.dev](https://pub.dev/packages/signals).

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

## Usage

```dart
import 'package:signals/signals.dart';
```

or if you're using Flutter:

```dart
import 'package:signals/signals_flutter.dart';
```

There is also a [signals_flutter](https://pub.dev/packages/signals_flutter) and [signals_core](https://pub.dev/packages/signals_flutter) package on pub.dev if you want to use them directly. [Signals devtools](/signals.dart/flutter/devtools) are only included in the main package.

If you are interested in a early version of [signals_lint](https://pub.dev/packages/signals_lint) there is also a package on pub.dev to help with code refactoring.
