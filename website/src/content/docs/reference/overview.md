---
title: Overview
description: An overview of the signals library
---

Signals are not new and have been around for a long time. They are also known as [signals](https://en.wikipedia.org/wiki/Signals_and_slots) or [observables](https://en.wikipedia.org/wiki/Observable_pattern).

Many popular JavaScript frameworks now include signals as part of their core library. Each of the implementations have their own unique features and APIs. `Signals.dart` is a port of the [Preact signals library](https://preactjs.com/blog/introducing-signals/) and is designed to be as close to the original API as possible in the core API.

Signals in preact started off by being implemented with dependencies tracked using a set but was later changed to use a linked list. The linked list implementation is more performant by taking advantage of [signal boosting](https://preactjs.com/blog/signal-boosting/) and is the implementation used in `Signals.dart`.

There is also a [DartPad](https://dartpad.dev/?id=d5f16f6be22e716d90419e41d10f281a) playground with some of the core methods that you can use to experiment!

> If you are coming from the JS world and are comfortable with signals this should feel very familiar. If you are looking for a state management library in Flutter that can be used in the JS world and outside of Dart then look no further!

## Sync vs Async

One important thing to remember about signals is that it is a synchronous state graph and while it has helpers for async futures and streams all signals are sync.

You might start to work with signals and then wonder why there is not an `AsyncComputed`. The closest you can get is a [`FutureSignal`](/signals.dart/dart/async/future) with dependencies passed in.

All UI state is sync and you need to read values to display the current state potentially every frame.

Here is a potentially difficult example to build that signals makes easy:

<iframe width="560" height="315" src="https://www.youtube.com/embed/ZNVK917PCX4?si=adg0lTHV1bYvmx9K" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Minimal Updates

Another nice thing about signals is the computation you get to save. If you never read a signal it never gets computed. That means that if you have a chain of computed values and never read the value of the last one then none of the callbacks would be called.

Signals also are a `pull` based state management library unlike most `push` based systems. This means that just because you update a signal value it does not mean that it will propagate (i.e. notifyListeners) to its targets.

Computed is also a special signal that keeps track of its dependencies and caches its value so it will only recompute on read and when the dependencies change. This can be pretty extensive and you can have a chain of computed signals and each of them are optimizing for the minimal amount of updates.

## Further reading

- https://signia.tldraw.dev/docs/what-are-signals
- https://www.solidjs.com/guides/reactivity
- https://angular.io/guide/signals
- https://vuejs.org/guide/extras/reactivity-in-depth.html
