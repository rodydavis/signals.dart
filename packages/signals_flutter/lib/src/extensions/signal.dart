import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart';

import '../mixins/signals.dart';
import '../widgets/widgets.dart';

/// Dynamic metadata storage attached directly to the Element instance.
/// Expando is a weak-keyed map using object identity, meaning it is immune
/// to identityHashCode collisions and doesn't prevent GC.
final _elementSubscriptions =
    Expando<List<({int signalId, VoidCallback dispose})>>();

/// The Finalizer executes its callback when the Element is garbage-collected.
/// It runs the signal subscription's disposer to prevent lapsed-listener leaks.
final _finalizer = Finalizer<VoidCallback>((dispose) => dispose());

/// Signal extensions for watching value changes on BuildContext.
extension FlutterReadonlySignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of.
  @Deprecated(
      'Use implicit signal tracking in SignalWidget/SignalStatefulWidget, or localized builders like SignalBuilder/Watch instead.')
  T watch(
    BuildContext context, {
    String? debugLabel,
  }) {
    // 1. If context is our custom SignalElement/SignalStatefulElement, delegate to it
    if (context is SignalElement) {
      context.watchSignal(this);
      return peek();
    }
    if (context is SignalStatefulElement) {
      context.watchSignal(this);
      return peek();
    }

    // 2. If context is a stateful widget using SignalsMixin, delegate to it
    if (context is StatefulElement) {
      final state = context.state;
      if (state is SignalsMixin) {
        return state.watchSignal(this);
      }
    }

    // 3. For any standard Element (Stateless/Stateful)
    if (context is Element) {
      final element = context;
      final signalId = globalId;

      // Check if we already have an active subscription for this signal on this element
      final subs = _elementSubscriptions[element] ??= [];
      final alreadySubscribed = subs.any((s) => s.signalId == signalId);

      if (!alreadySubscribed) {
        // Create a weak reference to the element to avoid lapsed-listener leaks.
        // The subscription closure will NOT keep the element alive in memory!
        final weakElement = WeakReference(element);

        final dispose = subscribe((_) {
          final el = weakElement.target;
          if (el != null && el.mounted) {
            el.markNeedsBuild();
          }
        });

        // Attach the subscription disposer to the Finalizer. When the element is
        // garbage-collected by the Dart VM, this disposer runs automatically.
        _finalizer.attach(element, dispose, detach: dispose);

        // Track it in our Expando to prevent duplicate subscriptions
        subs.add((signalId: signalId, dispose: dispose));
      }
    }

    // Return the value without subscribing again
    return peek();
  }

  /// Stop subscriptions to updates on a signal for watchers.
  @Deprecated(
      'Use implicit signal tracking in SignalWidget/SignalStatefulWidget, or localized builders like SignalBuilder/Watch instead.')
  void unwatch(BuildContext context) {
    if (context is StatefulElement) {
      final state = context.state;
      if (state is SignalsMixin) {
        state.unwatchSignal(this);
        return;
      }
    }
    if (context is Element) {
      final subs = _elementSubscriptions[context];
      if (subs != null) {
        final matchIndex = subs.indexWhere((s) => s.signalId == globalId);
        if (matchIndex != -1) {
          final sub = subs.removeAt(matchIndex);
          _finalizer.detach(sub.dispose);
          sub.dispose();
        }
      }
    }
  }
}
