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

##### <a name="multisignalprovider"></a><a name="multisignalprovider"></a>`MultiSignalProvider({super.key, required this.providers, required this.child})`

Exposes multiple [SignalProvider](/types/signalprovider) widgets inside a flat list.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="providers"></a>`List<SignalProvider> providers`

The list of single [SignalProvider](/types/signalprovider) widgets to nest.

##### <a name="child"></a>`Widget child`

The widget subtree that will have access to the provided signals.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>
