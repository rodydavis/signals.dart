import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';
// coverage:ignore-start

/// Widgets signal that tracks the current [MediaQueryData]
///
/// [updateWidgetsSignals] is required to be called in the builder
/// method of the root app
final mediaQueryDataSignal = signal<MediaQueryData>(const MediaQueryData());

/// Widgets signal that tracks the current [Locale]
///
/// [updateWidgetsSignals] is required to be called in the builder
/// method of the root app
final localizationsSignal = signal<Locale>(const Locale('en'));

/// Widgets signal that tracks the current [TextDirection]
///
/// [updateWidgetsSignals] is required to be called in the builder
/// method of the root app
final directionalitySignal = signal<TextDirection>(TextDirection.ltr);

/// Widgets signal that tracks the current [DefaultTextStyle]
///
/// [updateWidgetsSignals] is required to be called in the builder
/// method of the root app
late final Signal<DefaultTextStyle> defaultTextStyleSignal;

bool _setup = false;

/// Init the widgets signals listener
///
/// ```dart
/// ...
/// MaterialApp(
///   builder: (context, child) {
///      updateWidgetsSignals(context);
///      return child;
///   }
/// )
/// ```
void updateWidgetsSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;

  mediaQueryDataSignal.value = MediaQuery.of(context);
  localizationsSignal.value = Localizations.localeOf(context);
  directionalitySignal.value = Directionality.of(context);
  defaultTextStyleSignal.value = DefaultTextStyle.of(context);
}
// coverage:ignore-end