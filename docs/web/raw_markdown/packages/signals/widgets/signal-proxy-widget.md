---
title: SignalProxyWidget
description: A low-level widget wrapper around RenderSignalProxyBox for custom painting / sizing needs.
---

A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalproxywidget"></a><a name="signalproxywidget"></a>`SignalProxyWidget({super.key, required this.signals, super.child})`

Creates a new [SignalProxyWidget](/types/signalproxywidget).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="signals"></a>`List<core.ReadonlySignal<dynamic>> signals`

The list of signals to observe.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createrenderobject"></a>`RenderSignalProxyBox createRenderObject(BuildContext context)`

##### <a name="updaterenderobject"></a>`void updateRenderObject(BuildContext context, RenderSignalProxyBox renderObject)`

</details>
