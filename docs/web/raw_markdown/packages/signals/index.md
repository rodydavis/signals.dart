---
title: signals
description: Reactivity made simple. Do more by doing less. Supports Flutter and any Dart project including HTML/JS, CLI, Shelf Server, VM and more.
---

> Version: `7.1.0`

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
      <span class="category-title-text">Core Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/core/action">Action</a>
      <a class="content-link" href="/packages/signals/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals/core/linked-signal">LinkedSignal</a>
      <a class="content-link" href="/packages/signals/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals/async/future">FutureSignal</a>
      <a class="content-link" href="/packages/signals/async/mutation">MutationSignal</a>
      <a class="content-link" href="/packages/signals/async/stream">Stream</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Reactive Collections</span>
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
      <span class="category-title-text">Reactive Mixins</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/mixins/change-stack">ChangeStackSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/event-sink">EventSinkSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/iterable">IterableSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/list">ListSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/map">MapSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/queue">QueueSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/set">SetSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/signals-mixin">SignalsMixin</a>
      <a class="content-link" href="/packages/signals/mixins/sink">SinkSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/stream">StreamSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/tracked">TrackedSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/value-listenable-signal-mixin">ValueListenableSignalMixin</a>
      <a class="content-link" href="/packages/signals/mixins/value-notifier-signal-mixin">ValueNotifierSignalMixin</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals/utilities/observer">SignalsObserver</a>
      <a class="content-link" href="/packages/signals/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals/utilities/equality">SignalEquality</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🧩</span>
      <span class="category-title-text">Widget & Context Extensions</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/extensions/converted-signal-stateful-element">ConvertedSignalStatefulElement</a>
      <a class="content-link" href="/packages/signals/extensions/converted-signal-stateful-widget">ConvertedSignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals/extensions/converted-signal-widget">ConvertedSignalWidget</a>
      <a class="content-link" href="/packages/signals/extensions/lazy-signal">Lazy Signal</a>
      <a class="content-link" href="/packages/signals/extensions/signal-custom-painter">SignalCustomPainter</a>
      <a class="content-link" href="/packages/signals/extensions/signal-element">SignalElement</a>
      <a class="content-link" href="/packages/signals/extensions/signal-stateful-element">SignalStatefulElement</a>
      <a class="content-link" href="/packages/signals/extensions/signal-stateful-widget">SignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals/extensions/signal-value-listenable-utils">Signal Value Listenable Utils</a>
      <a class="content-link" href="/packages/signals/extensions/signal-value-notifier-utils">Signal Value Notifier Utils</a>
      <a class="content-link" href="/packages/signals/extensions/stateful-element-convert-extension">Stateful Element Convert Extension</a>
      <a class="content-link" href="/packages/signals/extensions/stateful-widget-convert-widget-extension">Stateful Widget Convert Widget Extension</a>
      <a class="content-link" href="/packages/signals/extensions/stateless-element-convert-extension">Stateless Element Convert Extension</a>
      <a class="content-link" href="/packages/signals/extensions/stateless-widget-convert-widget-extension">Stateless Widget Convert Widget Extension</a>
      <a class="content-link" href="/packages/signals/extensions/value-listenable-to-signal">Value Listenable To Signal</a>
      <a class="content-link" href="/packages/signals/extensions/value-notifier-to-signal">Value Notifier To Signal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Reactive Signals</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/signals/flutter-computed">FlutterComputed</a>
      <a class="content-link" href="/packages/signals/signals/flutter-readonly-signal">Flutter Readonly Signal</a>
      <a class="content-link" href="/packages/signals/signals/flutter-signal">FlutterSignal</a>
      <a class="content-link" href="/packages/signals/signals/ticker-signal">TickerSignal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">📱</span>
      <span class="category-title-text">Flutter Widgets</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/widgets/multi-signal-provider">MultiSignalProvider</a>
      <a class="content-link" href="/packages/signals/widgets/signal-animated-builder">SignalAnimatedBuilder</a>
      <a class="content-link" href="/packages/signals/widgets/signal-builder">SignalBuilder</a>
      <a class="content-link" href="/packages/signals/widgets/signal-custom-paint">SignalCustomPaint</a>
      <a class="content-link" href="/packages/signals/widgets/signal-painter-widget">SignalPainterWidget</a>
      <a class="content-link" href="/packages/signals/widgets/signal-provider">SignalProvider</a>
      <a class="content-link" href="/packages/signals/widgets/signal-proxy-widget">SignalProxyWidget</a>
      <a class="content-link" href="/packages/signals/widgets/signal-widget">SignalWidget</a>
      <a class="content-link" href="/packages/signals/widgets/watch">Watch</a>
      <a class="content-link" href="/packages/signals/widgets/watch-builder">WatchBuilder</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🎨</span>
      <span class="category-title-text">Low-Level Render Objects</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/render/render-signal-box">RenderSignalBox</a>
      <a class="content-link" href="/packages/signals/render/render-signal-custom-paint">RenderSignalCustomPaint</a>
      <a class="content-link" href="/packages/signals/render/render-signal-proxy-box">RenderSignalProxyBox</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔄</span>
      <span class="category-title-text">Lifecycle & Effects</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals/effects/signal-effect">SignalEffect</a>
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

