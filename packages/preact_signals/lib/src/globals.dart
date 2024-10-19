// ignore_for_file: constant_identifier_names

part of 'signals.dart';

// An named symbol/brand for detecting Signal instances even when they weren't
// created using the same signals library version.
const BRAND_SYMBOL = Symbol('preact-signals');

// Flags for Computed and Effect.
const RUNNING = 1 << 0;
const NOTIFIED = 1 << 1;
const OUTDATED = 1 << 2;
const DISPOSED = 1 << 3;
const HAS_ERROR = 1 << 4;
const TRACKING = 1 << 5;

// Effects collected into a batch.
Effect? batchedEffect;
int batchDepth = 0;
int batchIteration = 0;

// Currently evaluated computed or effect.
Listenable? evalContext;

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
int globalVersion = 0;

// mixin SignalsMixin<T> on _Signal<T> {}
// class Signal2<T> = _Signal<T> with SignalsMixin<T>;

int _lastGlobalId = 0;

Effect? currentEffect;
