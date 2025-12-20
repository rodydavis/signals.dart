// ignore_for_file: invalid_use_of_internal_member, implementation_imports

import 'package:flutter/widgets.dart';
import 'package:preact_signals/preact_signals.dart' as signals;
import "package:preact_signals/src/globals.dart" as signals;

import '_widget_effect.dart';

extension SignalWatcherOper<T> on signals.ReadonlySignal<T> {
  T watch(BuildContext context) {
    final effect = lookupWidgetEffect(context),
        prevEvalContext = signals.evalContext,
        prevEffect = signals.currentEffect;

    // effect.flags |= signals.RUNNING;
    effect.flags &= ~signals.DISPOSED;
    signals.evalContext = effect;
    signals.currentEffect = effect;
    try {
      return value;
    } finally {
      signals.evalContext = prevEvalContext;
      signals.currentEffect = prevEffect;
    }
  }
}
