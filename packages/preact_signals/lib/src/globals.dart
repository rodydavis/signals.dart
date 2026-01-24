// ignore_for_file: constant_identifier_names

// An named symbol/brand for detecting Signal instances even when they weren't
// created using the same signals library version.
import 'package:meta/meta.dart';

import 'effect.dart';
import 'listenable.dart';

@internal
const BRAND_SYMBOL = Symbol('preact-signals');

// Flags for Computed and Effect.

@internal
const RUNNING = 1 << 0;

@internal
const NOTIFIED = 1 << 1;

@internal
const OUTDATED = 1 << 2;

@internal
const DISPOSED = 1 << 3;

@internal
const HAS_ERROR = 1 << 4;

@internal
const TRACKING = 1 << 5;

// Effects collected into a batch.

@internal
Effect? batchedEffect;

@internal
int batchDepth = 0;

@internal
int batchIteration = 0;

// Currently evaluated computed or effect.
@internal
Listenable? evalContext;

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
@internal
int globalVersion = 0;

@internal
int lastGlobalId = 0;

@internal
Effect? currentEffect;

@internal
@pragma('vm:never-inline')
@pragma('dart2js:noInline')
void throwCycleDetected() {
  throw Exception('Cycle detected');
}

@internal
@pragma('vm:never-inline')
@pragma('dart2js:noInline')
void throwOutOfOrderEffect() {
  throw Exception('Out-of-order effect');
}

@internal
@pragma('vm:never-inline')
@pragma('dart2js:noInline')
void throwSignalEffectException(Object error) {
  throw error;
}
