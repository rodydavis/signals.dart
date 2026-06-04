---
title: preact_signals
description: Dart port of Preact.js Signals
---

> Version: <code>7.0.1</code>

## Installation

```bash
dart pub add preact_signals
```

The <code>preact_signals</code> package is a direct, ultra-high-performance Dart port of Preact.js Signals (v7.0.0). It brings fine-grained reactive programming to Dart VM, command-line interfaces, server environments, and web targets with maximum memory efficiency and minimal execution overhead.

## Key Features

- **⚡ High Performance**: Built on a highly optimized, double-linked reactive graph that automatically caches derived values.
- **📦 Memory Efficient**: Automatic memory cleanup and garbage collection of inactive nodes.
- **🎯 Dynamic Dependency Tracking**: Automatically tracks which signals are read during execution and re-evaluates effects surgically only when those specific dependencies update.
- **🧪 Batching Updates**: Group multiple signal updates together into a single transaction so reactions and UI redraws occur only once.


## Quick Start

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final count = signal(0);
  final isEven = computed(() => count.value.isEven);

  // Automatically tracks and prints when dependencies update
  final dispose = effect(() {
    print('Count is ${count.value}, isEven: ${isEven.value}');
  });

  count.value = 1;
  count.value = 2;

  dispose();
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
      <a class="content-link" href="/packages/preact_signals/core/action">Action</a>
      <a class="content-link" href="/packages/preact_signals/core/batch">Batch</a>
      <a class="content-link" href="/packages/preact_signals/core/computed">Computed</a>
      <a class="content-link" href="/packages/preact_signals/core/signal">Signal</a>
      <a class="content-link" href="/packages/preact_signals/core/effect">Effect</a>
      <a class="content-link" href="/packages/preact_signals/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/preact_signals/core/untracked">Untracked</a>
    </div>
  </div>
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">🛠️</span>
      <span class="category-title-text">Utilities</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/preact_signals/utilities/model">Model</a>
      <a class="content-link" href="/packages/preact_signals/utilities/equality">SignalEquality</a>
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

