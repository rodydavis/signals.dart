// ignore_for_file: constant_identifier_names

// An named symbol/brand for detecting Signal instances even when they weren't
// created using the same signals library version.
import 'dart:async';

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

// Effects collected into a batch.

@internal
class BatchContext {
  Effect? batchedEffect;
  int batchDepth = 0;
  int batchIteration = 0;
}

@internal
final batchContextKey = Object();

@internal
final globalBatchContext = BatchContext();

@internal
BatchContext get batchContext =>
    Zone.current[batchContextKey] as BatchContext? ?? globalBatchContext;

@internal
Effect? get batchedEffect => batchContext.batchedEffect;

@internal
set batchedEffect(Effect? val) {
  batchContext.batchedEffect = val;
}

@internal
int get batchDepth => batchContext.batchDepth;

@internal
set batchDepth(int val) {
  batchContext.batchDepth = val;
}

@internal
int get batchIteration => batchContext.batchIteration;

@internal
set batchIteration(int val) {
  batchContext.batchIteration = val;
}

// Currently evaluated computed or effect.
@internal
final evalContextKey = Object();

@internal
Listenable? globalEvalContext;

@internal
Listenable? get evalContext =>
    globalEvalContext ?? (Zone.current[evalContextKey] as Listenable?);

// A global version number for signals, used for fast-pathing repeated
// computed.peek()/computed.value calls when nothing has changed globally.
@internal
int globalVersion = 0;

@internal
int lastGlobalId = 0;

@internal
final currentEffectKey = Object();

@internal
Effect? globalCurrentEffect;

@internal
Effect? get currentEffect =>
    globalCurrentEffect ?? (Zone.current[currentEffectKey] as Effect?);
