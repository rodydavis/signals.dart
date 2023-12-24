import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AppLifecycleSignal extends StreamSignal<AppLifecycleState> {
  AppLifecycleSignal({
    String super.debugLabel = 'AppLifecycle',
    super.cancelOnError,
  }) : super(
          stream: _controller.stream,
          initialValue: WidgetsBinding.instance.lifecycleState,
        );

  static final _controller = _buildController();

  static StreamController<AppLifecycleState> _buildController() {
    final controller = StreamController<AppLifecycleState>.broadcast();
    WidgetsBinding.instance.addObserver(
      AppLifecycleListener(onStateChange: controller.add),
    );
    return controller;
  }
}
