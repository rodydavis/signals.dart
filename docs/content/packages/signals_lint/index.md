---
title: signals_lint
description: linter and developer tool for signals
---

> Version: <code>7.0.0</code>

## Installation

```bash
dart pub add signals_lint
```

The <code>signals_lint</code> package is a developer productivity toolkit containing custom compiler diagnostics, real-time IDE analysis rules, and automated quick-fixes. It guarantees that reactive signals are consumed according to best practices, preventing memory leaks and anti-patterns at code time.

## Key Features

- **🛡 Anti-pattern Detection**: Warns when signals are instantiated directly inside build methods instead of state initializers.
- **💡 Real-time IDE Quick-fixes**: Supports automated quick-fixes (like replacing standard state parameters with reactive watch methods).
- **📝 Standardized Conventions**: Enforces uniform style guides and signal usage patterns across your team.


## Quick Start

```dart
// analysis_options.yaml
analyzer:
  plugins:
    - signals_lint
```

## Package Contents

<div class="package-contents-grid">
  <div class="category-card">
    <div class="category-header">
      <span class="category-icon">💙</span>
      <span class="category-title-text">Flutter Components</span>
    </div>
    <div class="category-links">
      <a class="content-link" href="/packages/signals_lint/flutter/convert-stateful-to-signal-stateful-widget">ConvertStatefulToSignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals_lint/flutter/convert-stateless-to-signal-widget">ConvertStatelessToSignalWidget</a>
      <a class="content-link" href="/packages/signals_lint/flutter/migrate-signals-mixin-to-signal-stateful-widget">MigrateSignalsMixinToSignalStatefulWidget</a>
      <a class="content-link" href="/packages/signals_lint/flutter/migrate-watch-to-signal-builder">MigrateWatchToSignalBuilder</a>
      <a class="content-link" href="/packages/signals_lint/flutter/signals-avoid-create-in-build-method">SignalsAvoidCreateInBuildMethod</a>
      <a class="content-link" href="/packages/signals_lint/flutter/signals-avoid-deprecated-signals-mixin">SignalsAvoidDeprecatedSignalsMixin</a>
      <a class="content-link" href="/packages/signals_lint/flutter/signals-avoid-deprecated-watch-extension">SignalsAvoidDeprecatedWatchExtension</a>
      <a class="content-link" href="/packages/signals_lint/flutter/signals-prefer-named-builder">SignalsPreferNamedBuilder</a>
      <a class="content-link" href="/packages/signals_lint/flutter/signals-prefer-unified-options">SignalsPreferUnifiedOptions</a>
      <a class="content-link" href="/packages/signals_lint/flutter/wrap-with-signal-builder">WrapWithSignalBuilder</a>
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

