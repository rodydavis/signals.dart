# Signals Developer & AI Skills

This directory serves as the centralized repository for developer guidelines, API specifications, and specialized AI coding assistant prompts within the `signals.dart` reactivity ecosystem.

## Purpose

To provide a highly structured set of prompt-injection inputs and developer reference materials. These skills ensure that both AI coding assistants and human developers write consistent, optimized, memory-safe, and up-to-date code.

## Subdirectories Overview

This folder organizes rules and guidelines into distinct package and task boundaries:

### 1. [signals-dart/](signals-dart/CONTEXT.md)
Guidelines for writing pure Dart reactive state components using the primary `signals_core` API.
- Covers: core primitives (signals, computed, effect, batch), asynchronous states, reactive collections, and utility extensions (linked/tracked signals).

### 2. [signals-flutter/](signals-flutter/CONTEXT.md)
Guidelines for integrating reactive signals into Flutter applications.
- Covers: context-level `.watch(context)` extensions, lifecycle-safe elements (`SignalWidget`), localized builder subtrees (`SignalBuilder`), side effects (`SignalEffect`), and high-performance direct GPU painting (`SignalCustomPaint`).

### 3. [signals-preact-dart/](signals-preact-dart/CONTEXT.md)
Guidelines for the low-level `preact_signals` internal reactivity engine.
- Covers: primitive mechanics, dependency tracking loops, cycle detection, re-entrancy prevention, and execution context safety.

### 4. [signals-migration-6-to-7/](signals-migration-6-to-7/CONTEXT.md)
Refactoring guides for upgrading from signals.dart 6.x to 7.x.
- Covers: migrating parameters to unified options classes, updating asynchronous creators, refactoring positional builders, and phasing out `SignalsMixin`.

## Dependencies/Relationships

- **Repository Packages (`packages/`)**: These instructions directly align with and validate against the packages in the monorepo (e.g. `preact_signals`, `signals_core`, `signals_flutter`, `signals_hooks`, `signals_lint`).
- **AI Coding Integration**: Injected into LLM assistant contexts during code generation and auditing tasks to guarantee implementation safety.

## Usage/Exports

This folder exposes the four major training skills:
- `signals-dart`
- `signals-flutter`
- `signals-preact-dart`
- `signals-migration-6-to-7`
