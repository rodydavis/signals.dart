import 'package:flutter/material.dart';

import '../../../signals_flutter.dart';

final themeDataSignal = signal<ThemeData>(ThemeData());

bool _setup = false;

void updateMaterialSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;

  themeDataSignal.value = Theme.of(context);
}
