---
title: preact_signals
description: Dart port of Preact.js Signals
---

> Version: `7.0.0`

## Installation

```bash
dart pub add preact_signals
```

The `preact_signals` package is a direct, ultra-high-performance Dart port of Preact.js Signals (v7.0.0). It brings fine-grained reactive programming to Dart VM, command-line interfaces, server environments, and web targets with maximum memory efficiency and minimal execution overhead.

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
      <span class="category-title-text">Core</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/preact_signals/core/action">Action</a>
      <a class="content-link" href="/packages/preact_signals/core/batch">Batch</a>
      <a class="content-link" href="/packages/preact_signals/core/computed">Computed</a>
      <a class="content-link" href="/packages/preact_signals/core/effect">Effect</a>
      <a class="content-link" href="/packages/preact_signals/core/readonly">ReadonlySignal</a>
      <a class="content-link" href="/packages/preact_signals/core/signal">Signal</a>
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

