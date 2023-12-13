/// Signals core is the core library for signals.
///
/// It contains the core signals `signal`, `computed`, `effect`, `batch` and
/// `untracked`.
library signals_core;
// Core API
export 'src/core/signals.dart'
    show
        signal,
        computed,
        effect,
        batch,
        untracked,
        disableSignalsDevTools,
        EffectCleanup,
        Computed,
        Signal,
        ValueSignal,
        ReadonlySignal;
// Value signals
export 'src/value/iterable.dart';
export 'src/value/list.dart';
export 'src/value/set.dart';
export 'src/value/map.dart';
// Extensions
export 'src/extensions/iterable.dart';
export 'src/extensions/list.dart';
export 'src/extensions/set.dart';
export 'src/extensions/map.dart';
