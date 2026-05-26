---
title: signals
description: Reactivity made simple. Do more by doing less. Supports Flutter and any Dart project including HTML/JS, CLI, Shelf Server, VM and more.
---

> Version: `7.0.0`

## Installation

```bash
dart pub add signals
```

The `signals` package is the main overarching package for the Signals framework. It exports the complete core reactive package (`signals_core`) along with full Flutter extensions (`signals_flutter`) to provide a seamless out-of-the-box state management developer experience.

## Key Features

- **📦 Unified Import**: Direct access to all core signals, computations, batch updates, reactive collections, and Flutter builders.
- **🎯 Full Reactivity**: The single source of truth for building extremely responsive, state-of-the-art Flutter and Dart applications.
- **📈 Standardized Ecosystem**: Recommended package entry point for all standard mobile, web, desktop, and multiplatform Flutter development.


## Quick Start

```dart
import 'package:signals/signals_flutter.dart';

// Access everything from a single package!
final count = signal(0);
final doubleCount = computed(() => count.value * 2);
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">📦</span>
      <span class="category-title-text">Core</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/core/action">Action</a>
      <a class="content-link" href="/packages/signals/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals/core/linked-signal">Linked Signal</a>
      <a class="content-link" href="/packages/signals/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals/async/future">FutureSignal</a>
      <a class="content-link" href="/packages/signals/async/stream">Stream</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Value</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/value/change-stack">ChangeStackSignal</a>
      <a class="content-link" href="/packages/signals/value/iterable">IterableSignal</a>
      <a class="content-link" href="/packages/signals/value/list">ListSignal</a>
      <a class="content-link" href="/packages/signals/value/map">MapSignal</a>
      <a class="content-link" href="/packages/signals/value/set">SetSignal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔌</span>
      <span class="category-title-text">Mixins</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/mixins/change-stack">ChangeStackSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/event-sink">EventSinkSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/iterable">IterableSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/list">ListSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/map">MapSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/queue">QueueSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/set">SetSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/sink">SinkSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/stream">StreamSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/tracked">TrackedSignalMixin</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals/utilities/equality">SignalEquality</a>
      <a class="content-link" href="/packages/signals/utilities/observer">SignalsObserver</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">💙</span>
      <span class="category-title-text">Flutter</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/flutter/computed">FlutterComputed</a>
      <a class="content-link" href="/packages/signals/flutter/watch">SignalAnimatedBuilder</a>
      <a class="content-link" href="/packages/signals/flutter/signal">FlutterSignal</a>
      <a class="content-link" href="/packages/signals/flutter/signal-provider">SignalProvider</a>
      <a class="content-link" href="/packages/signals/flutter/signals-mixin">SignalsMixin</a>
      <a class="content-link" href="/packages/signals/flutter/value-listenable">Value Listenable</a>
      <a class="content-link" href="/packages/signals/flutter/value-notifier">Value Notifier</a>
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

