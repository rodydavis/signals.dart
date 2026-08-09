# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 7.1.0 (2026-05-29)

### Changes
- **SignalContainer Generic Simplification**: Removed redundant unused type parameter `T` from `SignalContainer`. Only `<Arg, S>` are needed now.

---

## 7.0.0 (2026-05-24)

### Breaking Changes
- **FutureSignal Direct AsyncSignal Base**: `FutureSignal` now extends `AsyncSignal` directly instead of `StreamSignal`, optimizing performance and removing stream-backed event-sink/listener overhead.
- **Signal Options Encapsulation**: Removed individual configuration named parameters (e.g. `autoDispose`, `debugLabel`) from all signal creator functions across `signals_core`. Options must be passed inside strongly-typed options configuration objects.
- **SignalBuilder Constructor**: Updated `SignalBuilder` constructor signature to accept a required named parameter `builder:` instead of a positional function argument.

### New Features
- **Writable Computed Signals (`linkedSignal` / `linkedSignalOptions`)**: Implementation of Angular-style writable computed signals.
- **New Flutter Rendering & Lifecycle Widgets**: Added stateless/stateful `SignalWidget`, static-cache optimized `SignalAnimatedBuilder`, inline side-effects `SignalEffect`/`SignalListener`, and GPU-accelerated drawing targeting `SignalCustomPaint`.
- **Memory-Safe watch Context Extension**: Built `Expando`/`WeakReference`/`Finalizer`-based `.watch(context)` preventing lapsed-listener memory leaks.
- **Value Semantics options**: Integrated copyWith, operator ==, and hashCode across all option variants.

---

## 2026-05-24

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`preact_signals` - `v6.3.1`](#preact_signals---v631)
 - [`signals` - `v6.3.1`](#signals---v631)
 - [`signals_core` - `v6.3.1`](#signals_core---v631)
 - [`signals_flutter` - `v6.3.1`](#signals_flutter---v631)
 - [`signals_hooks` - `v6.3.1`](#signals_hooks---v631)
 - [`signals_lint` - `v6.3.1`](#signals_lint---v631)

---

#### `preact_signals` - `v6.3.1`

#### `signals` - `v6.3.1`

 - **FIX**: Doc comment package import.

#### `signals_core` - `v6.3.1`

 - **REFACTOR**: migrate signal mixins to mixin classes.
 - **REFACTOR**: Rename persisted signal classes to correct typo.
 - **REFACTOR**: Formatting.
 - **REFACTOR**: allow setting a signal value inside computed.
 - **REFACTOR**: inline signal subscribe.
 - **REFACTOR**: share peek() between signal/computed.
 - **REFACTOR**: inline cycle detection.
 - **REFACTOR**: use untracked for signal subscribe.
 - **FIX**: map.remove - only notify when value was removed.
 - **FIX**(signals): accessing cached `SignalContainer` in `Effect` cause loop.
 - **FIX**(signals): accessing cached `SignalContainer` in `Effect` cause loop.
 - **FIX**: untracked always reset evaluation context.
 - **FIX**: #179 and add overrideWith.
 - **FIX**: #175 - add missing autoDispose/equality on signals.
 - **FIX**: https://github.com/rodydavis/signals.dart/issues/156.
 - **FEAT**: Impl loading for state reloading and refreshing classes.
 - **FEAT**: Improve async state.
 - **FEAT**: Changed Async{Loading,Data,Error} to be const.
 - **FEAT**: Better type safety on Connect.
 - **DOCS**: rename _computed => _fn.
 - **DOCS**: rename some internal API methods.

#### `signals_flutter` - `v6.3.1`

 - **REFACTOR**: migrate signal mixins to mixin classes.
 - **FIX**(flutter): prevent ConcurrentModificationError in SignalsMixin.
 - **FIX**(signals_flutter): remove listener on dispose for ValueListenable.toSignal().
 - **FIX**: resolve hashCode collision in .watchSignal.
 - **FEAT**(signals_flutter): return FlutterSignal/-Computed from SignalsMixin.createSignal/-Computed.

#### `signals_hooks` - `v6.3.1`

 - **FIX**: call super.dispose in SignalHookState.

#### `signals_lint` - `v6.3.1`

