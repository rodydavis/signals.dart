---
title: signals_devtools_extension
description: Signals DevTools extension.
---

> Version: `1.1.0`

## Installation

```bash
dart pub add signals_devtools_extension
```

The `signals_devtools_extension` package installs a custom visual debugging tool directly inside Flutter DevTools. It provides visual insights, timeline updates, and reactive relationship diagrams of all active signals in your application.

## Key Features

- **📈 Updates Feed**: View a chronological timeline stream of every single signal value mutation, computation evaluation, and side effect run.
- **🕸 Dependency Graph Viewer**: Visualize your application's entire reactive architecture. Track source signals through computations down to downstream effects.
- **🔍 State Inspector**: Pause updates and inspect current values, dependencies, and listener states of any reactive node.


## Quick Start

```dart
// Simply run your Flutter app in debug mode.
// The "Signals" tab will automatically appear in your Flutter DevTools panel!
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">💙</span>
      <span class="category-title-text">Flutter</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_devtools_extension/flutter/devtools">SignalsDevToolsExtension</a>
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

