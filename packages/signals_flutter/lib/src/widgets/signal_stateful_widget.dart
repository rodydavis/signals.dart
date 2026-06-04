import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A reactive [StatefulWidget] that implicitly tracks and rebuilds on signal changes.
///
/// Subclasses of `SignalStatefulWidget` establish a dynamic reactive context directly at the
/// Flutter element layer. Any signal value accessed synchronously inside State's [build] method
/// is **implicitly tracked** and subscribed to. When a signal changes, only that element is rebuilt.
///
/// This offers a clean, Javascript-style reactivity experience while retaining all stateful lifecycles.
/// It is the modern, highly recommended replacement for the legacy, deprecated `SignalsMixin`.
///
/// ### Implicit Reactivity Example (Stateful)
/// ```dart
/// class CounterControl extends SignalStatefulWidget {
///   const CounterControl({super.key});
///
///   @override
///   State<CounterControl> createState() => _CounterControlState();
/// }
///
/// class _CounterControlState extends State<CounterControl> {
///   // Create state signals directly inside the State object:
///   final count = signal(0);
///
///   @override
///   Widget build(BuildContext context) {
///     // Automatically tracked on access and safely unsubscribed on unmount:
///     return ElevatedButton(
///       onPressed: () => count.value++,
///       child: Text('Count: ${count.value}'),
///     );
///   }
/// }
/// ```
///
/// > [!IMPORTANT]
/// > Only signals accessed *synchronously* during the execution of the `build` method are tracked.
/// > Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.
abstract class SignalStatefulWidget extends StatefulWidget {
  /// Constructor for [SignalStatefulWidget].
  const SignalStatefulWidget({super.key});

  @override
  StatefulElement createElement() => SignalStatefulElement(this);
}

/// Element for [SignalStatefulWidget] that manages implicit signal subscription and handles dynamic branching.
class SignalStatefulElement extends StatefulElement {
  /// Constructor for [SignalStatefulElement].
  SignalStatefulElement(super.widget);

  final _watch = <int, VoidCallback>{};
  bool _initializing = false;

  /// Subscribes to changes of the provided [value] and schedules a rebuild.
  void watchSignal(core.ReadonlySignal value) {
    _watch.putIfAbsent(
      value.globalId,
      () => value.subscribe((val) {
        if (_initializing) return;
        markNeedsBuild();
      }),
    );
  }

  void _updateWatch(Set<core.ReadonlySignal> signals) {
    _initializing = true;
    try {
      final toRemove = <int>[];
      _watch.forEach((id, dispose) {
        if (!signals.any((s) => s.globalId == id)) {
          dispose();
          toRemove.add(id);
        }
      });
      for (final id in toRemove) {
        _watch.remove(id);
      }
      for (final signal in signals) {
        watchSignal(signal);
      }
    } finally {
      _initializing = false;
    }
  }

  @override
  Widget build() {
    final signals = <core.ReadonlySignal>{};
    final oldOnSignalRead = core.onSignalRead;
    core.onSignalRead = (signal) {
      if (signal is core.ReadonlySignal) {
        signals.add(signal);
      }
    };

    try {
      return super.build();
    } finally {
      core.onSignalRead = oldOnSignalRead;
      if (signals.isEmpty) {
        for (final dispose in _watch.values) {
          dispose();
        }
        _watch.clear();
      } else {
        _updateWatch(signals);
      }
    }
  }

  @override
  void unmount() {
    for (final dispose in _watch.values) {
      dispose();
    }
    _watch.clear();
    super.unmount();
  }
}
