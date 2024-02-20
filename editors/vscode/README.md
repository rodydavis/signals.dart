# Overview:

VS code Extension for Signals (A reactive State-Management approach for Fluttter using Observables and Signals)

This Extension Contains Snippets and Code-Actions for better Productivity when Using Signals in your Flutter Project.

## Features

Provides a set of snippets for the `signal` - State Management Library of Flutter.


## Snippets

| Prefix   | Description                                                                                                                               |
|----------|-------------------------------------------------------------------------------------------------------------------------------------------|
| `sig`    | A Signal Object                                                                                                                           |
| `asig`   | An async Signal Object                                                                                                                    |
| `comp`   | The computed function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal’s value. |
| `ascomp` | Async Computed is syntax sugar around [FutureSignal].                                                                                     |
| `csk`    | Change stack is a way to track the signal values overtime and undo or redo values.                                                       |
| `its`    | Iterable signals can be created by extension or method and implement the Iterable interface.                                             |
| `lts`    | List signals can be created by extension or method and implement the List interface.                                                     |
| `mps`    | Map signals can be created by extension or method and implement the Map interface.                                                       |
| `sets`   | Set signals can be created by extension or method and implement the Set interface.                                                       |
| `cnct`   | Start with a signal and then use the connect method to create a connector. Streams will feed Signal value.                                |
| `futs`   | Returns AsyncState<T> for the value and can handle the various states.                                                                   |
| `rdsc`   | Returns a read-only Signal Container.                                                                                                     |
| `sigcon` | Returns a Signal Container.                                                                                                               |
| `strms`  | Returns a streamSignal instance.                                                                                                          |
| `tos`    | .toSignal()                                                                                                                               |
| `iscom`  | .isCompleted()                                                                                                                            |
| `rst`    | .reset()                                                                                                                                  |
| `disp`   | .dispose()                                                                                                                                  |
| `valnot` | .toValueNotifier()                                                                                                                        |
| `watchb` | To watch a signal for changes in Flutter, use the Watch widget. This will only rebuild this widget method and not the entire widget tree. |
| `wat`    | .watch() shorthand for Watch.builder.                                                                                                     |
| `lisn`    | .listen()                                                                                                     |
| `valsig`    | Extends the ValueSignal Class                                                                                                    |


