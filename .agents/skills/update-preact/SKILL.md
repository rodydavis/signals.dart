---
name: update-preact
description: Instructions and guidelines for updating the pinned Preact JS git submodule and synchronizing upstream updates to the Dart preact_signals package.
---

# Updating Preact JS Submodule and preact_signals Package

This guide details the systematic process for updating the pinned `Preact.js Signals` JS/TS git submodule (`third_party/preactjs_signals`) and porting its structural updates, algorithmic changes, and optimizations into the Dart `preact_signals` package.

---

## 1. Upstream Submodule Management

The upstream JavaScript/TypeScript implementation is tracked via a Git submodule located at `third_party/preactjs_signals`.

### A. Initializing and Synchronizing the Submodule
If the submodule is not initialized, run:
```bash
git submodule update --init --recursive
```

### B. Pinned Submodule Version Upgrade
To upgrade the pinned submodule version:
1. Navigate to the submodule directory:
   ```bash
   cd third_party/preactjs_signals
   ```
2. Fetch all latest upstream branches and tags:
   ```bash
   git fetch --tags origin
   ```
3. Checkout the desired release tag or commit hash:
   ```bash
   git checkout tags/v1.3.0 # or specific tag/commit hash
   ```
4. Return to the root workspace directory and stage the updated submodule pointer:
   ```bash
   cd ...
   git add third_party/preactjs_signals
   ```

---

## 2. Reviewing Upstream Core Architecture Changes

Once the submodule is checked out to the new version, review the differences inside Preact's TypeScript core codebase:
* Core Primitive File: [third_party/preactjs_signals/packages/core/src/index.ts](third_party/preactjs_signals/packages/core/src/index.ts)
* Test Suite File: [third_party/preactjs_signals/packages/core/test/index.test.ts](third_party/preactjs_signals/packages/core/test/index.test.ts)

Compare changes to locate:
1. **Algorithmic Optimizations**: Refinements in graph tracking, batch processing, or lazy evaluation cycles.
2. **Bug Fixes**: Handling of edge-case memory leaks, exception propagates, or subscription-tracking re-entrancy issues.
3. **API Contracts**: New methods or configuration parameters added to `Signal`, `Computed`, or `Effect`.

---

## 3. Porting Changes to Dart `preact_signals`

All ported logic must reside in the `packages/preact_signals` package.

### A. Code Synchronization
Modify the corresponding Dart implementation files to accurately align with the updated Preact JS algorithms:
* Core Signal Primitive: [packages/preact_signals/lib/src/signal.dart](packages/preact_signals/lib/src/signal.dart)
* Computed Engine: [packages/preact_signals/lib/src/computed.dart](packages/preact_signals/lib/src/computed.dart)
* Effect Engine: [packages/preact_signals/lib/src/effect.dart](packages/preact_signals/lib/src/effect.dart)
* Batch Execution: [packages/preact_signals/lib/src/batch.dart](packages/preact_signals/lib/src/batch.dart)

> [!IMPORTANT]
> Keep the Dart implementation highly semantic and idiomatic. While replicating Preact's structural logic is necessary to preserve reactive correctness and avoid cycles, leverage Dart's language features (such as `late` initializers, `WeakReference`, `Expando`, or `Extension types`) appropriately.

### B. Porting Upstream Tests
Ensure any new test cases introduced in Preact core's test suite are ported to:
* [packages/preact_signals/test/](packages/preact_signals/test/)

---

## 4. Package Release & Changelog Alignment

When changes are ported, increment package versions and document changes.

1. **Semantic Versioning**: Increase the version in [packages/preact_signals/pubspec.yaml](packages/preact_signals/pubspec.yaml) based on whether changes are major (breaking changes), minor (features), or patch (bug fixes).
2. **Changelog Documentation**: Document all changes and the specific upstream version tag synced in [packages/preact_signals/CHANGELOG.md](packages/preact_signals/CHANGELOG.md).

---

## 5. Verification Checklist

Execute these verification commands prior to staging code changes:

```bash
# 1. Update monorepo dependencies
melos bootstrap

# 2. Run static analysis
melos run analyze

# 3. Format files
dart format .

# 4. Execute all unit tests and verify 100% success
melos run test

# 5. Review combined coverage and verify high metrics
melos run coverage
```
