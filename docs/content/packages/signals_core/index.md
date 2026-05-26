---
title: signals_core
description: The signals library exposes four core functions which are the building blocks to model any business logic you can think of.
---

> Version: `7.0.0`

## Installation

```bash
dart pub add signals_core
```

The `signals_core` package exposes the foundational building blocks of the entire Signals reactive framework. It is 100% platform-agnostic, zero-dependency, and can be integrated into any Dart codebase—including shelf servers, database layers, command-line scripts, or serverless functions.

## Key Features

- **📐 Signals & Computeds**: Declare reactive variables and lazy, cacheable derived states.
- **⚡ Effects**: Trigger side effects (like saving to databases, logging, or writing to files) automatically in response to dependency changes.
- **🗂 Advanced Collections**: Built-in reactive collections including `listSignal`, `setSignal`, `mapSignal`, and `iterableSignal`.
- **🕒 Async Bindings**: Easily bind streams and futures directly to reactive states using `futureSignal` and `streamSignal`.
- **🔄 Undo/Redo Change Stack**: Track value histories and enable instant undo/redo functionality using `changeStack`.


## Quick Start

```dart
import 'package:signals_core/signals_core.dart';

void main() {
  final count = signal(0);
  final doubleCount = computed(() => count.value * 2);

  effect(() {
    print('Double count: ${doubleCount.value}');
  });

  count.value = 5; // Prints: Double count: 10
}
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">📦</span>
      <span class="category-title-text">Core</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/core/action">Action</a>
      <a class="content-link" href="/packages/signals_core/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals_core/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals_core/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals_core/core/linked-signal">Linked Signal</a>
      <a class="content-link" href="/packages/signals_core/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals_core/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals_core/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals_core/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals_core/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals_core/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals_core/async/future">Future</a>
      <a class="content-link" href="/packages/signals_core/async/stream">StreamSignal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Value</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/value/change-stack">ChangeStackSignal</a>
      <a class="content-link" href="/packages/signals_core/value/iterable">IterableSignal</a>
      <a class="content-link" href="/packages/signals_core/value/list">ListSignal</a>
      <a class="content-link" href="/packages/signals_core/value/map">MapSignal</a>
      <a class="content-link" href="/packages/signals_core/value/set">SetSignal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔌</span>
      <span class="category-title-text">Mixins</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/mixins/change-stack">ChangeStackSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/event-sink">EventSinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/iterable">IterableSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/list">ListSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/map">MapSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/queue">QueueSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/set">SetSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/sink">SinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/stream">StreamSignalMixin</a>
      <a class="content-link" href="/packages/signals_core/mixins/tracked">TrackedSignalMixin</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals_core/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals_core/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals_core/utilities/equality">SignalEquality</a>
      <a class="content-link" href="/packages/signals_core/utilities/observer">SignalsObserver</a>
    </div>
  </div>
</div>

<style>
  .package-contents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1.25rem;
    margin-top: 1.5rem;
    margin-bottom: 2rem;
  }
  .category-card {
    background-color: var(--card-bg, #ffffff);
    border: 1px solid var(--card-border, #e2e8f0);
    border-radius: 12px;
    padding: 1.25rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    display: flex;
    flex-direction: column;
  }
  .category-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(59, 130, 246, 0.08);
    border-color: #3b82f6 !important;
  }
  .category-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
    border-bottom: 1px solid var(--card-border, #e2e8f0);
    padding-bottom: 0.5rem;
  }
  .category-icon {
    font-size: 1.25rem;
  }
  .category-title-text {
    font-weight: 700;
    font-size: 1.05rem;
    color: var(--heading-color, #0f172a);
  }
  .category-links {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  .content-link {
    font-size: 0.9rem;
    font-weight: 500;
    color: #3b82f6 !important;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    transition: all 0.15s ease;
  }
  .content-link:hover {
    color: #2563eb !important;
    transform: translateX(2px);
  }
  :root {
    --card-bg: #ffffff;
    --card-border: #e2e8f0;
    --heading-color: #0f172a;
  }
  html.dark {
    --card-bg: #1e293b;
    --card-border: #334155;
    --heading-color: #f8fafc;
  }
</style>

