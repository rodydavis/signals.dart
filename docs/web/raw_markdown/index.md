---
title: Signals.dart
description: Fine-grained reactive programming framework for Dart and Flutter.
---

> **Do more by doing less.** A highly optimized, native Dart reactive programming framework based on the Preact Signals model.

<Info>
  Ready to get started? Check out the <a href="/reference/install">Installation Guide</a> or try it directly in your browser using the DartPad below.
</Info>

---

## Why Signals?

- **📖 Fine-Grained Reactivity**: Automatically tracks read dependencies and surgically updates only the exact parts of the application that changed.
- **⚡️ 100% Native Dart**: Compatible with VM, CLI, Server (Shelf), Web (JS), and Flutter (Mobile, Desktop, Web). Use signals in any Dart project!
- **📐 Lazy & Memoized**: Values are computed lazily only when requested, and derived computations (computeds) cache their results until upstream dependencies mutate.
- **🧩 Small & Composable API**: Minimal surface area that is incredibly easy to learn, integrate, and scale.
- **🚀 Surgical Rebuilds**: Integrates with Flutter to allow surgical UI rebuilds, only marking the exact mounted widgets as dirty.

---

## Interactive Playground

Take a look at signals in action with this interactive DartPad:

<iframe src="https://dartpad.dev/?id=1b2f58d30c33ee2ee5c5a159b8867861?theme=dark" style="width: 100%; height: 600px; border: 0; border-radius: 8px;"></iframe>

---

## Packages & Reference

We offer specialized packages for all layers of your stack:
- [<code>preact_signals</code>](/packages/preact_signals): The raw, low-level reactivity engine.
- [<code>signals_core</code>](/packages/signals_core): Pure Dart reactive collections, mixins, and async primitives.
- [<code>signals_flutter</code>](/packages/signals_flutter): Surgical UI bindings and GPU-optimized rendering.
- [<code>signals_hooks</code>](/packages/signals_hooks): Hooks integration for standard Flutter Hook projects.
- [<code>signals_lint</code>](/packages/signals_lint): Static analysis rules and IDE assists.
- [<code>signals_devtools_extension</code>](/packages/signals_devtools_extension): Visual inspector in DevTools.
- [<code>signals</code>](/packages/signals): The unified umbrella package for most apps.
