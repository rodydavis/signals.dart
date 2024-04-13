import 'package:flutter/material.dart';

import '../../signals_flutter.dart';
// coverage:ignore-start

/// Material signal that tracks the current [ThemeData]
///
/// [updateMaterialSignals] is required to be called in the builder
/// method of the root app
final themeDataSignal = signal<ThemeData>(ThemeData());

bool _setup = false;

/// Init the material signals listener
///
/// ```dart
/// ...
/// MaterialApp(
///   builder: (context, child) {
///      updateMaterialSignals(context);
///      return child;
///   }
/// )
/// ```
void updateMaterialSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;

  themeDataSignal.value = Theme.of(context);
}
// coverage:ignore-end
