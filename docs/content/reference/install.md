---
title: Installing
description: How to install Signals
sidebar:
  order: 0
---



Signals can run anywhere Dart can run including VM, WASM, Dart to JS, Dart to Native, Flutter, and on the server.

<Callout>
Signals is a single package that contains the imports for flutter and dart and may not show the correct platforms on pub.dev (doesn't show dart only).
</Callout>

`Signals.dart` is available on pub.dev:

| Package                                                             | Pub                                                                                                              |
|---------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| [`signals`](packages/signals)                                       | [![signals](https://img.shields.io/pub/v/signals.svg)](https://pub.dev/packages/signals)                         |
| [`signals_core`](packages/signals_core)                             | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core)          |
| [`signals_flutter`](packages/signals_flutter)                       | [![signals_flutter](https://img.shields.io/pub/v/signals_flutter.svg)](https://pub.dev/packages/signals_flutter) |
| [`signals_lint`](packages/signals_lint)                             | [![signals_lint](https://img.shields.io/pub/v/signals_lint.svg)](https://pub.dev/packages/signals_lint)          |
| [`preact_signals`](packages/preact_signals)                             | [![signals_lint](https://img.shields.io/pub/v/preact_signals.svg)](https://pub.dev/packages/preact_signals)          |


## Get Started

Add the following to your `pubspec.yaml`:





<Tabs>
<TabItem label="Stable" value="Stable">

```dart
dependencies:
  signals: latest
```

</TabItem>
<TabItem label="Unstable" value="Unstable">

```dart
dependencies:
  signals:
    git:
      url: https://github.com/rodydavis/signals.dart
      ref: main
      path: packages/signals
```

</TabItem>
</Tabs>

or from the command line:

<Tabs>
<TabItem label="Dart" value="Dart">

```dart
dart pub add signals
```

</TabItem>
<TabItem label="Flutter" value="Flutter">

```dart
flutter pub add signals
```

</TabItem>
</Tabs>

## Usage

<Tabs>
<TabItem label="Dart" value="Dart">

```dart
import 'package:signals/signals.dart';
```

</TabItem>
<TabItem label="Flutter" value="Flutter">

```dart
import 'package:signals/signals_flutter.dart';
```

</TabItem>
</Tabs>


