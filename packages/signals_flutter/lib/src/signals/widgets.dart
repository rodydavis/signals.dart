import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';

final mediaQueryDataSignal = signal<MediaQueryData>(const MediaQueryData());

final sizeSignal = computed(() => mediaQueryDataSignal().size);
final paddingSignal = computed(() => mediaQueryDataSignal().padding);
final viewInsetsSignal = computed(() => mediaQueryDataSignal().viewInsets);
final platformBrightnessSignal =
    computed(() => mediaQueryDataSignal().platformBrightness);
final viewPaddingSignal = computed(() => mediaQueryDataSignal().viewPadding);
final systemGestureInsetsSignal =
    computed(() => mediaQueryDataSignal().systemGestureInsets);
final textScalerSignal = computed(() => mediaQueryDataSignal().textScaler);
final accessibleNavigationSignal =
    computed(() => mediaQueryDataSignal().accessibleNavigation);
final alwaysUse24HourFormatSignal =
    computed(() => mediaQueryDataSignal().alwaysUse24HourFormat);
final devicePixelRatioSignal =
    computed(() => mediaQueryDataSignal().devicePixelRatio);
final boldTextSignal = computed(() => mediaQueryDataSignal().boldText);
final disableAnimationsSignal =
    computed(() => mediaQueryDataSignal().disableAnimations);
final displayFeaturesSignal =
    computed(() => mediaQueryDataSignal().displayFeatures);

final localizationsSignal = signal<Locale>(const Locale('en'));

final countryCodeSignal = computed(() => localizationsSignal().countryCode);
final languageCodeSignal = computed(() => localizationsSignal().languageCode);
final scriptCodeSignal = computed(() => localizationsSignal().scriptCode);

final directionalitySignal = signal<TextDirection>(TextDirection.ltr);

late final Signal<DefaultTextStyle> defaultTextStyleSignal;

final styleSignal = computed(() => defaultTextStyleSignal().style);

bool _setup = false;

void updateWidgetsSignals(BuildContext context) {
  if (_setup) return;
  _setup = true;
  
  mediaQueryDataSignal.value = MediaQuery.of(context);
  localizationsSignal.value = Localizations.localeOf(context);
  directionalitySignal.value = Directionality.of(context);
  defaultTextStyleSignal.value = DefaultTextStyle.of(context);
}
