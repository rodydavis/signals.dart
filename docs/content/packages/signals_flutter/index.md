---
title: signals_flutter
description: The signals library exposes four core functions which are the building blocks to model any business logic you can think of.
---

> Version: <code>7.1.0</code>

## Installation

```bash
flutter pub add signals_flutter
```

The <code>signals_flutter</code> package delivers high-performance, premium reactive UI updates for Flutter applications. By binding signals directly to the widget tree, it enables surgical, localized widget rebuilds without redrawing parent elements or complex state management boilerplate.

## Key Features

- **🚀 Implicit Tracking**: Inherit from [SignalWidget](/types/signalwidget) or [SignalStatefulWidget](/types/signalstatefulwidget) to establish automatic, mixin-free reactivity inside widget build methods.
- **⚡ Surgical Rebuilds**: Use [SignalBuilder](/types/signalbuilder) to surgically rebuild specific, localized nodes of the widget tree without redrawing parent elements.
- **🔄 Interoperability**: Seamlessly convert back and forth between Dart <code>Signals</code>, standard Flutter <code>ValueNotifiers</code>, and asynchronous <code>Streams</code>.


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
      <span class="category-title-text">Core Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/core/action">Action</a>
      <a class="content-link" href="/packages/signals_flutter/core/batch">Batch</a>
      <a class="content-link" href="/packages/signals_flutter/core/signal">Signal</a>
      <a class="content-link" href="/packages/signals_flutter/core/computed">Computed</a>
      <a class="content-link" href="/packages/signals_flutter/core/effect">Effect</a>
      <a class="content-link" href="/packages/signals_flutter/core/linked-signal">LinkedSignal</a>
      <a class="content-link" href="/packages/signals_flutter/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/signals_flutter/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Async Primitives</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/async/state">AsyncState</a>
      <a class="content-link" href="/packages/signals_flutter/async/signal">AsyncSignal</a>
      <a class="content-link" href="/packages/signals_flutter/async/computed">Computed</a>
      <a class="content-link" href="/packages/signals_flutter/async/connect">Connect</a>
      <a class="content-link" href="/packages/signals_flutter/async/future">FutureSignal</a>
      <a class="content-link" href="/packages/signals_flutter/async/stream">Stream</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔢</span>
      <span class="category-title-text">Reactive Collections</span>
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
      <span class="category-title-text">Reactive Mixins</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/mixins/change-stack">ChangeStackSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/event-sink">EventSinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/iterable">IterableSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/list">ListSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/map">MapSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/queue">QueueSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/set">SetSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/signals-mixin">SignalsMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/sink">SinkSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/stream">StreamSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/tracked">TrackedSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/value-listenable-signal-mixin">ValueListenableSignalMixin</a>
      <a class="content-link" href="/packages/signals_flutter/mixins/value-notifier-signal-mixin">ValueNotifierSignalMixin</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/utilities/container">SignalContainer</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/model">Model</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/observer">SignalsObserver</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/persisted">PersistedSignal</a>
      <a class="content-link" href="/packages/signals_flutter/utilities/equality">SignalEquality</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🧩</span>
      <span class="category-title-text">Widget & Context Extensions</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/extensions/converted-signal-stateful-element">ConvertedSignalStatefulElement</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/converted-signal-stateful-widget">ConvertedSignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/converted-signal-widget">ConvertedSignalWidget</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-custom-painter">SignalCustomPainter</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-element">SignalElement</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-stateful-element">SignalStatefulElement</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-stateful-widget">SignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-value-listenable-utils">Signal Value Listenable Utils</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/signal-value-notifier-utils">Signal Value Notifier Utils</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/stateful-element-convert-extension">Stateful Element Convert Extension</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/stateful-widget-convert-widget-extension">Stateful Widget Convert Widget Extension</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/stateless-element-convert-extension">Stateless Element Convert Extension</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/stateless-widget-convert-widget-extension">Stateless Widget Convert Widget Extension</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/value-listenable-to-signal">Value Listenable To Signal</a>
      <a class="content-link" href="/packages/signals_flutter/extensions/value-notifier-to-signal">Value Notifier To Signal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">⚡</span>
      <span class="category-title-text">Reactive Signals</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/signals/flutter-computed">FlutterComputed</a>
      <a class="content-link" href="/packages/signals_flutter/signals/flutter-readonly-signal">Flutter Readonly Signal</a>
      <a class="content-link" href="/packages/signals_flutter/signals/flutter-signal">FlutterSignal</a>
      <a class="content-link" href="/packages/signals_flutter/signals/ticker-signal">Ticker Signal</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">📱</span>
      <span class="category-title-text">Flutter Widgets</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/widgets/multi-signal-provider">MultiSignalProvider</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-animated-builder">SignalAnimatedBuilder</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-builder">SignalBuilder</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-custom-paint">SignalCustomPaint</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-painter-widget">SignalPainterWidget</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-provider">SignalProvider</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-proxy-widget">SignalProxyWidget</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/signal-widget">SignalWidget</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/watch">Watch</a>
      <a class="content-link" href="/packages/signals_flutter/widgets/watch-builder">WatchBuilder</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🎨</span>
      <span class="category-title-text">Low-Level Render Objects</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/render/render-signal-box">RenderSignalBox</a>
      <a class="content-link" href="/packages/signals_flutter/render/render-signal-custom-paint">RenderSignalCustomPaint</a>
      <a class="content-link" href="/packages/signals_flutter/render/render-signal-proxy-box">RenderSignalProxyBox</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🔄</span>
      <span class="category-title-text">Lifecycle & Effects</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_flutter/effects/signal-effect">SignalEffect</a>
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

