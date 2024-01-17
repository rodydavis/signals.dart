import 'package:flutter/material.dart';

import '../../signals_flutter.dart';

final themeDataSignal = signal<ThemeData>(ThemeData());

final brightnessSignal = computed(() => themeDataSignal().brightness);
final textThemeSignal = computed(() => themeDataSignal().textTheme);
final colorThemeSignal = computed(() => themeDataSignal().colorScheme);
final platformSignal = computed(() => themeDataSignal().platform);
final typographySignal = computed(() => themeDataSignal().typography);
final visualDensitySignal = computed(() => themeDataSignal().visualDensity);

bool _setup = false;

void updateMaterialSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;
  
  themeDataSignal.value = Theme.of(context);
}
