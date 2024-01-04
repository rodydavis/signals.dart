import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AppLifecycleSignal extends ValueSignal<AppLifecycleState> {
  AppLifecycleSignal({
    super.debugLabel = 'AppLifecycle',
    AppLifecycleState? initialValue,
    Future<AppExitResponse> Function()? onAppExit,
    WidgetsBinding? binding,
  })  : widgetsBinding = binding ?? WidgetsBinding.instance,
        super(initialValue ??
            binding?.lifecycleState ??
            WidgetsBinding.instance.lifecycleState ??
            AppLifecycleState.resumed) {
    final listener = AppLifecycleListener(
      binding: widgetsBinding,
      onStateChange: set,
      onExitRequested: onAppExit,
    );
    widgetsBinding.addObserver(listener);
    onDispose(() {
      widgetsBinding.removeObserver(listener);
    });
  }

  final WidgetsBinding widgetsBinding;
}

AppLifecycleSignal appLifecycleSignal({
  String? debugLabel = 'AppLifecycle',
  AppLifecycleState? initialValue,
  Future<AppExitResponse> Function()? onAppExit,
  WidgetsBinding? binding,
}) {
  return AppLifecycleSignal(
    debugLabel: debugLabel,
    initialValue: initialValue,
    onAppExit: onAppExit,
    binding: binding,
  );
}
