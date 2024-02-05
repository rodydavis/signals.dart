import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';

final mediaQueryDataSignal = signal<MediaQueryData>(const MediaQueryData());
final localizationsSignal = signal<Locale>(const Locale('en'));
final directionalitySignal = signal<TextDirection>(TextDirection.ltr);
late final Signal<DefaultTextStyle> defaultTextStyleSignal;

bool _setup = false;

void updateWidgetsSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;

  mediaQueryDataSignal.value = MediaQuery.of(context);
  localizationsSignal.value = Localizations.localeOf(context);
  directionalitySignal.value = Directionality.of(context);
  defaultTextStyleSignal.value = DefaultTextStyle.of(context);
}
