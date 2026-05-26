---
title: signals_hooks
description: flutter_hooks bindings for signals
---

> Version: `7.0.0`

## Installation

```bash
flutter pub add signals_hooks
```

The `signals_hooks` package provides seamless, type-safe bindings for the highly popular `flutter_hooks` package. It enables developers to declare, instantiate, and automatically clean up reactive signals directly inside hook-based functional widgets.

## Key Features

- **🎣 Hook-based Signalling**: Instantly declare state with `useSignal()` inside functional Hook widgets.
- **🌀 Automatic Disposal**: No manual cleanup or dispose overrides required; the hook manages the entire signal life cycle.
- **⚡ useComputed & useAsyncComputed**: Create cacheable hook-scoped computations and fetch async states inside your Hook widgets.


## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_hooks.dart';

class HookCounter extends HookWidget {
  const HookCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Creates a signal tied to the widget life cycle
    final count = useSignal(0);
    
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">📄</span>
      <span class="category-title-text">Widgets</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_hooks/widgets/signal-hook-builder">SignalHookBuilder</a>
      <a class="content-link" href="/packages/signals_hooks/widgets/signal-hook-widget">SignalHookWidget</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🪝</span>
      <span class="category-title-text">Hooks</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_hooks/hooks/use-async-computed">useAsyncComputed</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-async-signal">useAsyncSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-change-stack-signal">useChangeStackSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-computed">useComputed</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-connect">useConnect</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-existing-signal">useExistingSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-future-signal">useFutureSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-iterable-signal">useIterableSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-lazy-signal">useLazySignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-linked-signal">useLinkedSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-list-signal">useListSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-map-signal">useMapSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-queue-signal">useQueueSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-set-signal">useSetSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-signal">useSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-signal-effect">useSignalEffect</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-signal-value">useSignalValue</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-stream-signal">useStreamSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-tracked-signal">useTrackedSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-value-listenable-to-signal">useValueListenableToSignal</a>
      <a class="content-link" href="/packages/signals_hooks/hooks/use-value-notifier-to-signal">useValueNotifierToSignal</a>
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

