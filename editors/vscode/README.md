# Overview:

VS code Extension for Signals (A reactive State-Management approach for Flutter using Observables and Signals)

This Extension Contains Snippets and Code-Actions for better Productivity when Using Signals in your Flutter Project.

## Features

Provides a set of snippets for the [`signals`](https://dartsignals.dev) library in Dart and Flutter.

## Snippets

| Prefix    | Description                                |
|-----------|--------------------------------------------|
| `sig`     | `signal()`                                 |
| `comp`    | `computed(() => ...)`                      |
| `itrsig`  | `iterableSignal<T>()`                      |
| `lstsig`  | `listSignal<T>()`                          |
| `mpsig`   | `mapSignal<K, V>()`                        |
| `stsig`   | `setSignal<T>()`                           |
| `undosig` | `changeStack()`                            |
| `asig`    | `asyncSignal()`                            |
| `ascomp`  | `computedAsync(() async => ...)`           |
| `fusig`   | `futureSignal<T>(() async => ...)`         |
| `stsig`   | `streamSignal<T>(() async* => ...)`        |
| `sigcon`  | `signalContainer<T, A>(() => ...)`         |
| `rsigcon` | `readonlySignalContainer<T, A>(() => ...)` |
| `valsig`  | `ValueSignal<T>`                           |
| `watch`   | `Watch((context) => ...)`                  |
| `watchb`  | `Watch.builder(builder: (context) => ...)` |
