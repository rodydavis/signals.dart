---
title: signals_flutter
description: The signals library exposes four core functions which are the building blocks to model any business logic you can think of.
---

> Version: `7.0.0`

## Installation

```bash
flutter pub add signals_flutter
```

The `signals_flutter` package delivers high-performance, premium reactive UI updates for Flutter applications. By binding signals directly to the widget tree, it enables surgical, localized widget rebuilds without redrawing parent elements or complex state management boilerplate.

## Key Features

- **🚀 Implicit Tracking**: Inherit from [SignalWidget] or [SignalStatefulWidget] to establish automatic, mixin-free reactivity inside widget build methods.
- **⚡ Surgical Rebuilds**: Use [SignalBuilder] to surgically rebuild specific, localized nodes of the widget tree without redrawing parent elements.
- **🔄 Interoperability**: Seamlessly convert back and forth between Dart `Signals`, standard Flutter `ValueNotifiers`, and asynchronous `Streams`.


## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class CounterWidget extends SignalWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing .value implicitly tracks and rebuilds this widget on change:
    return ElevatedButton(
      onPressed: () => counter.value++,
      child: Text('Count: ${counter.value}'),
    );
  }
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
      <a class="content-link" href="/packages/signals_flutter/core/action">Action</a>
      <a class="content-link" href="/packages/signals_flutter/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals_flutter/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals_flutter/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals_flutter/core/linked-signal">Linked Signal</a>
      <a class="content-link" href="/packages/signals_flutter/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals_flutter/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals_flutter/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals_flutter/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals_flutter/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals_flutter/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals_flutter/async/future">Future</a>
      <a class="content-link" href="/packages/signals_flutter/async/stream">Stream</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Value</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/value/change-stack">ChangeStackSignal</a>
      <a class="content-link" href="/packages/signals_flutter/value/iterable">IterableSignal</a>
      <a class="content-link" href="/packages/signals_flutter/value/list">ListSignal</a>
      <a class="content-link" href="/packages/signals_flutter/value/map">MapSignal</a>
      <a class="content-link" href="/packages/signals_flutter/value/set">SetSignal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔌</span>
      <span class="category-title-text">Mixins</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/mixins/change-stack">ChangeStackSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/event-sink">EventSinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/iterable">IterableSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/list">ListSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/map">MapSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/queue">QueueSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/set">SetSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/sink">SinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/stream">StreamSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/tracked">TrackedSignalMixin</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/equality">SignalEquality</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/observer">SignalsObserver</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">💙</span>
      <span class="category-title-text">Flutter</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/flutter/computed">FlutterComputed</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/watch">SignalAnimatedBuilder</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/signal">FlutterSignal</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/signal-provider">SignalProvider</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/signals-mixin">SignalsMixin</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/value-listenable">Value Listenable</a>
      <a class="content-link" href="/packages/signals_flutter/flutter/value-notifier">Value Notifier</a>
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

