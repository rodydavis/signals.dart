# Signals Migration 6 to 7 Skills

This directory contains prompt instructions and developer guides for migrating projects from version 6.x to version 7.x of `signals.dart` and `signals_flutter`.

## Purpose

To organize, store, and provide structured refactoring patterns for developers and AI coding assistants migrating to the new APIs introduced in version 7.0.0. This includes managing unified options classes, async signal refactoring, and upgraded Flutter widget architectures.

## Structure & Subdirectories

This folder is structured into:

### 1. [options/](options/CONTEXT.md)
Covers API options updates:
- [signal_options.md](options/signal_options.md): Migrating writable/computed parameter creators.
- [async_options.md](options/async_options.md): Refactoring async creator options.
- [collection_options.md](options/collection_options.md): Migrating collection creator configurations.

### 2. [widgets/](widgets/CONTEXT.md)
Covers Flutter UI updates:
- [builder_migration.md](widgets/builder_migration.md): Updating `SignalBuilder` to the named `builder` parameter.
- [mixin_migration.md](widgets/mixin_migration.md): Safe refactoring guidelines to replace `SignalsMixin` with `SignalWidget`.

## Core Content Overview

- **Migration Overview Guide (`SKILL.md`)**: A master guide outlining major version changes. It covers unified options parameters (e.g. `SignalOptions`, `ComputedOptions`), deprecating raw individual parameters, async signal adjustments, the deprecation of `SignalsMixin`, required named widget builders, and writable computed (`linkedSignal`) updates.

## Usage/Exports

This directory is utilized in developer training and AI prompt injection to ensure code generator tools cleanly transition older 6.x codebases to modern 7.x patterns.
