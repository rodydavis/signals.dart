# Signals Preact Dart Skills

This directory contains prompt instructions and developer guides for the low-level `preact_signals` package in the `signals.dart` monorepo.

## Purpose

To organize, store, and provide structured patterns for utilizing the core `preact_signals` library. It instructs coding assistants on how the low-level internal reactivity engine operates, including dependency tracking, evaluation cycles, and memory efficiency.

## Structure & Subdirectories

This folder is structured into:

### [core/](core/CONTEXT.md)
Covers core primitives:
- [signal.md](core/signal.md): Writable signals.
- [readonly.md](core/readonly.md): Encapsulation patterns.
- [computed.md](core/computed.md): Memoized lazy evaluation.
- [effect.md](core/effect.md): Subscriber observation cycles.
- [batch.md](core/batch.md): Grouping mutations to prevent update churn.

## Core Content Overview

- **Quick Start Guide (`SKILL.md`)**: Core primitive setup and use cases, covering dependency tracking rules, evaluation safety, re-entrancy prevention, cycle detection, and memory leak prevention in synchronous reactivity contexts.

## Usage/Exports

This directory is utilized in developer training and AI prompt injection to ensure all low-level modifications to the core reactivity engine (`preact_signals`) follow strict safety and performance guidelines.
