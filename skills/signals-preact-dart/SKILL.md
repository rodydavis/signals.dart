---
name: signals-preact-dart
description: Core reactive programming best practices and primitive definitions for preact_signals in Dart. (v7.0.1)
---

# signals-preact-dart API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-preact-dart` (version `7.0.1`).

---

## 📊 Reactive Primitives Directory

The following table summarizes all available reactive primitives and widgets. Click on any primitive's name to view its detailed documentation, standard usage, and examples.

| Primitive | Category | Description |
| :--- | :--- | :--- |
| [signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/signal.md) | Primitive | An observable box containing a mutable value. Reading its value registers a dependency implicitly. |
| [Async Signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/Async Signal.md) | Primitive | An async Signal Object mapping loading, data success, and error failure states cleanly. |
| [Computed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/Computed.md) | Derived | Combine multiple signals into a derived, lazily-cached, read-only signal. |
| [AsyncComputed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/AsyncComputed.md) | Derived | Asynchronous Computed is syntax sugar around FutureSignal for async dependent tasks. |
| [linkedSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/linkedSignal.md) | Writable Derived | A writable derived signal that allows manual updates and resets to a source computation on mutation. |
| [ChangeStackSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/ChangeStackSignal.md) | Utilities | Track signal values over time, exposing simple, robust undo/redo capabilities. |
| [IterableSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/IterableSignal.md) | Collections | Iterable signals wrap collection items lazy-traversals mapped to custom reactivity layer. |
| [ListSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/ListSignal.md) | Collections | Optimized list wrapper proxying standard operations to support element-level reactivity. |
| [MapSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/MapSignal.md) | Collections | Granular map wrapper supporting isolated dictionary element lookup triggers. |
| [SetSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/SetSignal.md) | Collections | Custom set wrapper ignoring duplicate entries and triggering mutations on unique inserts. |
| [FutureSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/FutureSignal.md) | Primitive | Bypasses stream subscription overhead and resolves the future-evaluation loop elegantly. |
| [StreamSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/StreamSignal.md) | Primitive | Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states. |
| [Signal Container (Read-only)](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/Signal Container (Read-only).md) | Utilities | Returns a read-only parameterized caching Signal Container. |
| [Signal Container](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/Signal Container.md) | Utilities | Returns a mutable parameterized caching Signal Container. |
| [Value Signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/primitives/Value Signal.md) | Utilities | Custom Value Signal class definition template. |

---

## 📦 Parsed Library API Directory

The following table summarizes all available classes, functions, and extensions exported by the package. Click on any API's name to view its detailed signature, members, and documentation.

| API | Type | Description |
| :--- | :--- | :--- |
| [Signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/Signal.md) | `class` | Represents a mutable reactive state container that sits at the foundation of the reactivity system. |
| [signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/signal.md) | `function` | Convenient global constructor for creating a mutable reactive state signal. |
| [Computed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/Computed.md) | `class` | Represents a derived, read-only reactive state value computed from one or more other signals. |
| [computed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/computed.md) | `function` | Convenient global constructor for creating a derived computed signal. |
| [Effect](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/Effect.md) | `class` | Represents a passive observer that runs arbitrary side-effect code in response to signal changes. |
| [effect](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/effect.md) | `function` | Creates and immediately executes a new reactive [Effect](/types/effect). |
| [SignalEffectException](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalEffectException.md) | `class` | Error for when a effect fails to run the callback |
| [batch](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/batch.md) | `function` | Combines multiple signal writes into a single update transaction that is flushed only after the callback completes. |
| [untracked](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/untracked.md) | `function` | Runs a callback function fn that can read signal values without establishing a reactive subscription. |
| [ReadonlySignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ReadonlySignal.md) | `class` | An interface for read-only signals. |
| [readonly](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/readonly.md) | `function` | Creates a new read-only signal initialized with value. |
| [SignalOptionsBase](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalOptionsBase.md) | `class` | Base configuration options for reactive components and signals. |
| [EffectOptions](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/EffectOptions.md) | `class` | Configuration options for reactive [Effect](/types/effect)s. |
| [ReadonlySignalOptions](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ReadonlySignalOptions.md) | `class` | Configuration options for a [ReadonlySignal](/types/readonlysignal). |
| [SignalOptions](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalOptions.md) | `class` | Configuration options for a [Signal](/types/signal). |
| [ComputedOptions](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ComputedOptions.md) | `class` | Configuration options for a [Computed](/types/computed) signal. |
| [SignalEquality](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalEquality.md) | `class` | Defines the equality check algorithm used by signals to determine if a new value |
| [SignalStandardEquality](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalStandardEquality.md) | `class` | Standard equality check (a == b) |
| [SignalIdentityEquality](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalIdentityEquality.md) | `class` | Identity equality check (identical(a, b)) |
| [SignalCustomEquality](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalCustomEquality.md) | `class` | Custom equality check using a custom function |
| [SignalDeepEquality](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalDeepEquality.md) | `class` | Deep equality check for collections |
| [action](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action.md) | `function` | Wraps a callback function into a reusable, batched, and untracked action. |
| [action0](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action0.md) | `function` | Wraps a 0-argument callback function in a type-safe action. |
| [action1](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action1.md) | `function` | Wraps a 1-argument callback function in a type-safe action. |
| [action2](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action2.md) | `function` | Wraps a 2-argument callback function in a type-safe action. |
| [action3](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action3.md) | `function` | Wraps a 3-argument callback function in a type-safe action. |
| [action4](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action4.md) | `function` | Wraps a 4-argument callback function in a type-safe action. |
| [action5](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action5.md) | `function` | Wraps a 5-argument callback function in a type-safe action. |
| [action6](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action6.md) | `function` | Wraps a 6-argument callback function in a type-safe action. |
| [action7](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action7.md) | `function` | Wraps a 7-argument callback function in a type-safe action. |
| [action8](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action8.md) | `function` | Wraps an 8-argument callback function in a type-safe action. |
| [action9](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action9.md) | `function` | Wraps a 9-argument callback function in a type-safe action. |
| [action10](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/action10.md) | `function` | Wraps a 10-argument callback function in a type-safe action. |
| [ActionExt0](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt0.md) | `extension` | Extension on a 0-argument function to wrap it in a type-safe action. |
| [ActionExt1](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt1.md) | `extension` | Extension on a 1-argument function to wrap it in a type-safe action. |
| [ActionExt2](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt2.md) | `extension` | Extension on a 2-argument function to wrap it in a type-safe action. |
| [ActionExt3](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt3.md) | `extension` | Extension on a 3-argument function to wrap it in a type-safe action. |
| [ActionExt4](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt4.md) | `extension` | Extension on a 4-argument function to wrap it in a type-safe action. |
| [ActionExt5](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt5.md) | `extension` | Extension on a 5-argument function to wrap it in a type-safe action. |
| [ActionExt6](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt6.md) | `extension` | Extension on a 6-argument function to wrap it in a type-safe action. |
| [ActionExt7](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt7.md) | `extension` | Extension on a 7-argument function to wrap it in a type-safe action. |
| [ActionExt8](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt8.md) | `extension` | Extension on an 8-argument function to wrap it in a type-safe action. |
| [ActionExt9](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt9.md) | `extension` | Extension on a 9-argument function to wrap it in a type-safe action. |
| [ActionExt10](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/ActionExt10.md) | `extension` | Extension on a 10-argument function to wrap it in a type-safe action. |
| [SignalModelOptions](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalModelOptions.md) | `class` | Options for configuring a [SignalModel](/types/signalmodel). |
| [SignalModel](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalModel.md) | `class` | A premium wrapper for cohesive state packages constructed with [createModel](/types/createmodel). |
| [SignalModelConstructor](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/SignalModelConstructor.md) | `class` | A constructor for models that manages nested effects. |
| [createModel](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-preact-dart/api/createModel.md) | `function` | Creates a new model constructor with an instanced factory. |
