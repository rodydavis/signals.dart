[![Tests](https://github.com/rodydavis/signals.dart/actions/workflows/tests.yml/badge.svg)](https://github.com/rodydavis/signals.dart/actions/workflows/tests.yml)
[![Website](https://github.com/rodydavis/signals.dart/actions/workflows/website.yml/badge.svg)](https://github.com/rodydavis/signals.dart/actions/workflows/website.yml)
[![GitHub stars](https://img.shields.io/github/stars/rodydavis/signals.dart)](https://gitHub.com/rodydavis/signals.dart/stargazers/)
[![Coverage](https://codecov.io/gh/rodydavis/signals.dart/branch/main/graph/badge.svg?token=HvJYtaixiW)](https://codecov.io/gh/rodydavis/signals.dart)
[![GitHub issues](https://img.shields.io/github/issues/rodydavis/signals.dart)](https://github.com/rodydavis/signals.dart/issues/)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/rodydavis/signals.dart.svg)](https://gitHub.com/rodydavis/signals.dart/pull/)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

# Signals for Flutter

Signals features:

- 🪡 **Fine grained reactivity**: Based on [Preact Signals](https://preactjs.com/blog/signal-boosting/) and provides a fine grained reactivity system that will automatically track dependencies and free them when no longer needed
- ⛓️ **Lazy evaluation**: Signals are lazy and will only compute values when read. If a signal is not read, it will not be computed
- 🗜️ **Flexible API**: Every app is different and signals can be composed in multiple ways. There are a few rules to follow but the API surface is small
- 🔬 **Surgical Rendering**: Widgets can be rebuilt surgically, only marking dirty the parts of the Widget tree that need to be updated and if mounted
- 💙 **100% Dart Native**: Supports Dart JS (HTML), Shelf Server, CLI (and Native), VM, Flutter (Web, Mobile and Desktop). Signals can be used in any Dart project

To start using signals, check out the full [documentation](https://dartsignals.dev/).

## Other packages

| Package           | Pub                                                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------|
| `signals`         | [![signals](https://img.shields.io/pub/v/signals.svg)](https://pub.dev/packages/signals)                         |
| `signals_core`    | [![signals_core](https://img.shields.io/pub/v/signals_core.svg)](https://pub.dev/packages/signals_core)          |
| `signals_hooks`   | [![signals_hooks](https://img.shields.io/pub/v/signals_hooks.svg)](https://pub.dev/packages/signals_hooks)       |
| `signals_lint`    | [![signals_lint](https://img.shields.io/pub/v/signals_lint.svg)](https://pub.dev/packages/signals_lint)          |
