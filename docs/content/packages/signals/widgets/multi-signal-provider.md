---
title: MultiSignalProvider
description: A dependency-injection / state propagation widget that allows passing.
---

A dependency-injection / state propagation widget that allows passing
multiple reactive signals down the Flutter widget tree.

This avoids the deeply nested trees that result from nesting multiple
single [SignalProvider](/types/signalprovider) widgets.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="multisignalprovider"></a><a name="multisignalprovider"></a><code>MultiSignalProvider({super.key, required this.providers, required this.child})</code>

Exposes multiple [SignalProvider](/types/signalprovider) widgets inside a flat list.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="providers"></a><code>List<SignalProvider> providers</code>

The list of single [SignalProvider](/types/signalprovider) widgets to nest.

##### <a name="child"></a><code>Widget child</code>

The widget subtree that will have access to the provided signals.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>
