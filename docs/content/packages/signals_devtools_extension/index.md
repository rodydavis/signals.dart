---
title: signals_devtools_extension
description: Signals DevTools extension.
---

> Version: <code>1.1.0</code>

## Installation

```bash
dart pub add signals_devtools_extension
```

The <code>signals_devtools_extension</code> package provides a premium, highly interactive debugging console and visualization dashboard directly embedded inside Flutter DevTools. It allows developers to inspect, audit, pause, and profile reactive states in real-time, instantly exposing dependency flows, memory lifecycles, and update cycles across all mobile, desktop, and web applications.

## Key Features

- **📈 Real-Time Updates Timeline**: View a live, chronological stream of all signal value mutations, computation re-evaluations, and side effect executions complete with deep value diffs and microsecond-level timestamps.
- **🕸 Interactive Physics Node Graph**: Render your entire application's reactive structure visually! Tracks the direct flow from raw input <code>Signals</code> to reactive intermediate <code>Computeds</code> down to final rendering sink <code>Effects</code> or widgets.
- **⏸️ Reaction Pause & Replay**: Freeze the reactive event stream dynamically at any point. Snapshot current states, inspect value trees, and play/resume events to track sequential microtask mutations step-by-step.
- **🔍 Deep Node Metadata Drawer**: Select any reactive node inside the graph or table to slide out a comprehensive inspector listing its ID, human-readable debug label, stringified value representation, and dynamic lists of upstream sources and downstream targets.
- **🛡️ Diagnostic Logging & Coalescing**: Option to enable direct VM console print logging or group sequential microtask updates to inspect coalesced batch updates.


## Quick Start

```bash
# 1. Start your Flutter application in Debug or Profile Mode:
flutter run

# 2. Open Dart DevTools inside your browser or IDE
# 3. Locate and click the custom "Signals" tab in the main DevTools panel
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">💙</span>
      <span class="category-title-text">Flutter Components</span>
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

