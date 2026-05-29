---
title: RenderSignalProxyBox
description: A low-level RenderProxyBox that subscribes to multiple reactive signals.
---

A low-level **RenderProxyBox** that subscribes to multiple reactive signals
and automatically schedules repaints without layout/rebuild when signals fire.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="rendersignalproxybox"></a><a name="rendersignalproxybox"></a><code>RenderSignalProxyBox({required List<core.ReadonlySignal<dynamic>> signals})</code>

Creates a new [RenderSignalProxyBox](/types/rendersignalproxybox) with the specified list of observed **signals**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="signals"></a><code>List<core.ReadonlySignal<dynamic>> signals</code>

Gets the current list of signals being observed.

##### <a name="signals"></a><code>signals(List<core.ReadonlySignal<dynamic>> val)</code>

Sets a new list of observed signals and resubscribes to them.

##### <a name="detach"></a><code>void detach()</code>

</details>
