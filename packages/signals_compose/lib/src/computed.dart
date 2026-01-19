import 'package:flutter/widgets.dart';
import "package:preact_signals/preact_signals.dart" as signals;

import '_widget_effect.dart';
import 'memorized.dart';

signals.ReadonlySignal<T> computed<T>(BuildContext? context, T Function() fn) {
  return withMemorized(context, () => _Computed(fn, context));
}

class _Computed<T> extends signals.Computed<T> with WidgetScopeSignal<T> {
  _Computed(super.fn, this.context);

  @override
  final BuildContext? context;
}
