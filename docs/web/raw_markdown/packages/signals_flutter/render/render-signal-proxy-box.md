---
title: RenderSignalProxyBox
description: A low-level RenderProxyBox that subscribes to multiple reactive signals.
---

A low-level **RenderProxyBox** that subscribes to multiple reactive signals
and automatically schedules repaints without layout/rebuild when signals fire.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalproxybox"></a><a name="rendersignalproxybox"></a>`RenderSignalProxyBox({required List<core.ReadonlySignal<dynamic>> signals})`

Creates a new [RenderSignalProxyBox](/types/rendersignalproxybox) with the specified list of observed **signals**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="signals"></a>`List<core.ReadonlySignal<dynamic>> signals`

Gets the current list of signals being observed.

##### <a name="signals"></a>`signals(List<core.ReadonlySignal<dynamic>> val)`

Sets a new list of observed signals and resubscribes to them.

##### <a name="detach"></a>`void detach()`

</details>
