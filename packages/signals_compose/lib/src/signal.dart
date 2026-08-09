import 'package:flutter/widgets.dart';
import "package:preact_signals/preact_signals.dart" as signals;

import '_widget_effect.dart';
import 'memorized.dart';

signals.Signal<T> signal<T>(BuildContext? context, T initialValue) {
  return withMemorized(context, () => _Signal(initialValue, context));
}

class _Signal<T> extends signals.Signal<T> with WidgetScopeSignal<T> {
  _Signal(super.internalValue, this.context);

  @override
  final BuildContext? context;
}
