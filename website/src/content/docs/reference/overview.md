---
title: Overview
description: An overview of the signals library
---

Signals are not new and have been around for a long time. They are also known as [signals](https://en.wikipedia.org/wiki/Signals_and_slots) or [observables](https://en.wikipedia.org/wiki/Observable_pattern).

Many popular JavaScript frameworks now include signals as part of their core library. Each of the implementations have their own unique features and APIs. Signals.dart is a port of the [Preact signals library](https://preactjs.com/blog/introducing-signals/) and is designed to be as close to the original as possible.

Signals in preact started off by being implemented with dependencies tracked using a set but was later changed to use a linked list. The linked list implementation is more performant by taking advantage of [signal boosting](https://preactjs.com/blog/signal-boosting/) and is the implementation used in `Signals.dart`.

There is also a [DartPad](https://dartpad.dev/?id=d5f16f6be22e716d90419e41d10f281a) playground with some of the core methods that you can use to experiment!

## Further reading

- https://signia.tldraw.dev/docs/what-are-signals
- https://www.solidjs.com/guides/reactivity
- https://vuejs.org/guide/extras/reactivity-in-depth.html
