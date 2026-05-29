---
title: SignalProxyWidget
description: A low-level widget wrapper around RenderSignalProxyBox for custom painting / sizing needs.
---

A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalproxywidget"></a><a name="signalproxywidget"></a><code>SignalProxyWidget({super.key, required this.signals, super.child})</code>

Creates a new [SignalProxyWidget](/types/signalproxywidget).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="signals"></a><code>List<core.ReadonlySignal<dynamic>> signals</code>

The list of signals to observe.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createrenderobject"></a><code>RenderSignalProxyBox createRenderObject(BuildContext context)</code>

##### <a name="updaterenderobject"></a><code>void updateRenderObject(BuildContext context, RenderSignalProxyBox renderObject)</code>

</details>
