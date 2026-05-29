---
title: signals_core
description: The signals library exposes four core functions which are the building blocks to model any business logic you can think of.
---

> Version: <code>7.1.0</code>

## Installation

```bash
dart pub add signals_core
```

The <code>signals_core</code> package exposes the foundational building blocks of the entire Signals reactive framework. It is 100% platform-agnostic, zero-dependency, and can be integrated into any Dart codebase—including shelf servers, database layers, command-line scripts, or serverless functions.

## Key Features

- **📐 Signals & Computeds**: Declare reactive variables and lazy, cacheable derived states.
- **⚡ Effects**: Trigger side effects (like saving to databases, logging, or writing to files) automatically in response to dependency changes.
- **🗂 Advanced Collections**: Built-in reactive collections including <code>listSignal</code>, <code>setSignal</code>, <code>mapSignal</code>, and <code>iterableSignal</code>.
- **🕒 Async Bindings**: Easily bind streams and futures directly to reactive states using <code>futureSignal</code> and <code>streamSignal</code>.
- **🔄 Undo/Redo Change Stack**: Track value histories and enable instant undo/redo functionality using <code>changeStack</code>.


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
      <span class="category-title-text">Core Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/core/action">Action</a>
      <a class="content-link" href="/packages/signals_core/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals_core/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals_core/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals_core/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals_core/core/linked-signal">LinkedSignal</a>
      <a class="content-link" href="/packages/signals_core/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals_core/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_core/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals_core/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals_core/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals_core/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals_core/async/future">FutureSignal</a>
      <a class="content-link" href="/packages/signals_core/async/stream">Stream</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Reactive Collections</span>
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
      <span class="category-title-text">Reactive Mixins</span>
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
      <a class="content-link" href="/packages/signals_core/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals_core/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals_core/utilities/observer">SignalsObserver</a>
      <a class="content-link" href="/packages/signals_core/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals_core/utilities/equality">SignalEquality</a>
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
    background-color: transparent;
    border: none;
    border-left: 3px solid var(--card-accent, #3b82f6);
    padding: 0.25rem 0 0.5rem 1rem;
    transition: all 0.2s ease;
    display: flex;
    flex-direction: column;
  }
  .category-card:hover {
    border-left-color: var(--card-accent-hover, #2563eb);
  }
  .category-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
    padding-bottom: 0px;
    border-bottom: none;
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
    --card-accent: #3b82f6;
    --card-accent-hover: #2563eb;
    --heading-color: #0f172a;
  }
  html.dark, [data-theme="dark"], html[data-theme="dark"] {
    --card-accent: #60a5fa;
    --card-accent-hover: #93c5fd;
    --heading-color: #f8fafc;
  }
</style>

