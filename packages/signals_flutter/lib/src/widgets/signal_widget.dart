import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A reactive [StatelessWidget] that implicitly tracks and rebuilds on signal changes.
/// 
/// `SignalWidget` establishes a dynamic reactive context directly at the Flutter element layer.
/// Any signal accessed via `.value` inside the [build] method is **implicitly tracked** and
/// subscribed to. When any of these signals mutate, only this widget is rebuilt.
/// 
/// This offers a clean, Javascript-style reactivity experience without needing manual
/// builder widgets (like `SignalBuilder`) or deprecated context watch extensions.
/// 
/// ### Implicit Reactivity Example (Stateless)
/// ```dart
/// final username = signal('Rody');
/// final status = signal('Online');
/// 
/// class UserProfileView extends SignalWidget {
///   const UserProfileView({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     // 'username' and 'status' are implicitly tracked on access:
///     return Column(
///       children: [
///         Text('Name: ${username.value}'),
///         Text('Status: ${status.value}'),
///       ],
///     );
///   }
/// }
/// ```
/// 
/// > [!IMPORTANT]
/// > Only signals accessed *synchronously* during the execution of the `build` method are tracked.
/// > Signals read inside async callbacks, listeners, or deferred tasks are not subscribed to.
abstract class SignalWidget extends StatelessWidget {
  /// Constructor for [SignalWidget].
  const SignalWidget({super.key});

  @override
  StatelessElement createElement() => SignalElement(this);
}

/// Element for [SignalWidget] that manages implicit signal subscription and handles dynamic branching.
class SignalElement extends StatelessElement {
  /// Constructor for [SignalElement].
  SignalElement(super.widget);

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
