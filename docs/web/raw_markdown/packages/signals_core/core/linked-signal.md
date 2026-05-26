---
title: LinkedSignal
description: A writable computed signal that derives its value from a source,.
---

A writable computed signal that derives its value from a source,
but allows manual overrides. Whenever the source changes, the value
is reset back to the computed default.


### Constructors

##### <a name="linkedsignal"></a><a name="linkedsignal"></a>`LinkedSignal({required S Function() source, LinkedSignalOptions<T, S>? options})`

Creates a new [LinkedSignal](/packages/signals/core/linked-signal).


### Methods

##### <a name="set"></a>`bool set(T val, {bool force = false})`

##### <a name="value"></a>`T value`

##### <a name="value"></a>`value(T val)`

##### <a name="dispose"></a>`void dispose()`



---

## linkedSignal

Creates a [LinkedSignal](/packages/signals/core/linked-signal) that derives its value from a source,
but allows manual overrides. Whenever the source changes, the value
is reset back to the computed default.
