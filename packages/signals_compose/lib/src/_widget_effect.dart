import 'package:flutter/widgets.dart';
import 'package:preact_signals/preact_signals.dart' as signals;
// ignore: implementation_imports
import "package:preact_signals/src/globals.dart" as signals;

import 'memorized.dart';

final _bindings = Expando<signals.Effect>();

signals.Effect lookupWidgetEffect(BuildContext context) {
  final element = context as Element;
  return _bindings[element] ??= signals.Effect(() {
    resetMemoizedFor(element);
    if (element.mounted && !element.dirty) {
      element.markNeedsBuild();
    }
  });
}

mixin WidgetScopeSignal<T> on signals.ReadonlySignal<T> {
  BuildContext? get context;

  @override
  T get value {
    if (context != null) {
      // ignore: invalid_use_of_internal_member
      final evalContext = signals.evalContext,
          effect =
              // ignore: invalid_use_of_internal_member
              signals.currentEffect ?? lookupWidgetEffect(context!);
      if (evalContext == null) {
        // ignore: invalid_use_of_internal_member
        // effect.flags |= signals.RUNNING;
        // ignore: invalid_use_of_internal_member
        effect.flags &= ~signals.DISPOSED;
        // ignore: invalid_use_of_internal_member
        signals.evalContext = effect;
        try {
          return super.value;
        } finally {
          // ignore: invalid_use_of_internal_member
          signals.evalContext = null;
        }
      }
    }

    return super.value;
  }
}
