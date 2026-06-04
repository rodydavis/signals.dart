---
name: update-examples-dependencies
description: Update all the `./examples` dependencies to the latest repository/third-party versions and fix any compiler or analysis issues.
---

# Update Examples Dependencies & Code Fixes

This skill provides a systematic and automated workflow to update dependencies in all Dart/Flutter examples located in the `./examples` directory and fix any code compilation, deprecation, or linter warnings that arise.

## Objective
Ensure all `./examples` packages are upgraded to target the latest core package versions (e.g. `signals`) of the repository, run a full `pub upgrade` on third-party dependencies to prevent stale locks, and repair any broken code or deprecation warnings under analysis.

## Workflow

### 1. Run the Automated Update Script
Locate the helper script at `scripts/update_dependencies.dart` or within this skill's scripts directory:
```bash
dart run .agents/skills/update-examples-dependencies/scripts/update_dependencies.dart
```

This script will:
- Read `packages/signals/pubspec.yaml` to detect the current package version of `signals`.
- Recursively find all `pubspec.yaml` files inside `./examples/`.
- Replace the `signals` dependency version constraint with the exact latest version constraint (e.g., `^6.3.1`).
- Execute `flutter pub upgrade` or `dart pub upgrade` on each example package.

### 2. Bootstrap the Workspace
After upgrading individual package pubspecs, link the workspace packages and ensure they resolve successfully by running:
```bash
melos bootstrap
```

### 3. Analyze and Fix Code Issues
With all packages upgraded, run static analysis to check for breaking changes or new warnings:
```bash
melos run analyze
```
For any deprecations (such as v6 to v7 API transitions or external package changes):
- Inspect the file and reference standard migration rules (e.g., `migration-6-to-7` if migrating to v7).
- Refactor the code in place to use modern, non-deprecated APIs.
- Fix all compiler errors and static analysis warnings until `melos run analyze` succeeds cleanly.
