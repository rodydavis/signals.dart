---
title: signals_devtools_extension
description: Signals DevTools extension.
---

> Version: `1.1.0`

## Installation

```bash
dart pub add signals_devtools_extension
```

The `signals_devtools_extension` package provides a premium, highly interactive debugging console and visualization dashboard directly embedded inside Flutter DevTools. It allows developers to inspect, audit, pause, and profile reactive states in real-time, instantly exposing dependency flows, memory lifecycles, and update cycles across all mobile, desktop, and web applications.

## Key Features

- **📈 Real-Time Updates Timeline**: View a live, chronological stream of all signal value mutations, computation re-evaluations, and side effect executions complete with deep value diffs and microsecond-level timestamps.
- **🕸 Interactive Physics Node Graph**: Render your entire application's reactive structure visually! Tracks the direct flow from raw input `Signals` to reactive intermediate `Computeds` down to final rendering sink `Effects` or widgets.
- **⏸️ Reaction Pause & Replay**: Freeze the reactive event stream dynamically at any point. Snapshot current states, inspect value trees, and play/resume events to track sequential microtask mutations step-by-step.
- **🔍 Deep Node Metadata Drawer**: Select any reactive node inside the graph or table to slide out a comprehensive inspector listing its ID, human-readable debug label, stringified value representation, and dynamic lists of upstream sources and downstream targets.
- **🛡️ Diagnostic Logging & Coalescing**: Option to enable direct VM console print logging or group sequential microtask updates to inspect coalesced batch updates.


## Quick Start

```dart
// 1. Run your Flutter application in Debug or Profile Mode:
//    flutter run
//
// 2. Open Dart DevTools inside your browser or IDE.
//
// 3. Locate the custom "Signals" tab in the main DevTools tab header panel.
//
// 4. Click the tab to immediately explore and profile your reactive states!
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

