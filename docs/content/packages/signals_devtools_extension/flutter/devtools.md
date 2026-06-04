---
title: SignalsDevToolsExtension
description: The main widget of the Signals DevTools Extension.
---

The main widget of the Signals DevTools Extension.

Wraps the **SignalsExtensionHomePage** inside a <code>DevToolsExtension</code> container
supplied by the <code>devtools_extensions</code> package. This allows it to:
- Connect securely to the Dart VM Service.
- Retrieve the application context and themes from DevTools.
- Render custom debugging tabs directly as a pane in Flutter DevTools.

### UI Elements

The UI is structured into two main diagnostic views:

1. **Updates Feed**:
   - Displays a live, chronological stream of all signal value updates, computed evaluations, and effect executions.
   - Includes previous and new values, timestamps, and active pause/resume capabilities to let developers snapshot reactions.

2. **Dependency Graph**:
   - An interactive dependency visualizer powered by <code>GraphView</code>.
   - Shows the relationship and flow of reactive nodes: <code>Signals</code> (sources) -> <code>Computeds</code> (intermediates) -> <code>Effects</code> (sinks).
   - Hovering or clicking on a node highlights its dependencies and current value.

<Info>
This panel leverages service extensions registered by <code>signals_core</code> in debug mode. It tracks creation,
updates, and removal of nodes dynamically using standard event streams.
</Info>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalsdevtoolsextension"></a><a name="signalsdevtoolsextension"></a><code>SignalsDevToolsExtension({super.key})</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>



---

## $Node


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="$node"></a><a name="$node"></a><code>$Node({required this.id, required this.type, this.label, this.value, this.sources, this.targets})</code>

##### <a name="$node-fromjson"></a><a name="fromjson"></a><code>$Node.fromJson(Map<String, dynamic> item)</code>

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="id"></a><code>int id</code>

##### <a name="type"></a><code>String type</code>

##### <a name="label"></a><code>String? label</code>

##### <a name="value"></a><code>String? value</code>

##### <a name="sources"></a><code>String? sources</code>

##### <a name="targets"></a><code>String? targets</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostring"></a><code>String toString()</code>

</details>



---

## BackgroundGrid


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="backgroundgrid"></a><a name="backgroundgrid"></a><code>BackgroundGrid({super.key, required this.backgroundColor, required this.foregroundColor})</code>

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="backgroundcolor"></a><code>Color backgroundColor</code>

##### <a name="foregroundcolor"></a><code>Color foregroundColor</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>



---

## NodeGraph


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodegraph"></a><a name="nodegraph"></a><code>NodeGraph({super.key})</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createstate"></a><code>State<NodeGraph> createState()</code>

</details>



---

## NodesTable


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodestable"></a><a name="nodestable"></a><code>NodesTable({super.key})</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>



---

## NodeView


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodeview"></a><a name="nodeview"></a><code>NodeView({required this.nodeId, super.key})</code>

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="nodeid"></a><code>int nodeId</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>



---

## SignalsExtensionHomePage


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalsextensionhomepage"></a><a name="signalsextensionhomepage"></a><code>SignalsExtensionHomePage({super.key})</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createstate"></a><code>State<SignalsExtensionHomePage> createState()</code>

</details>



---

## SignalUpdate


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalupdate"></a><a name="signalupdate"></a><code>SignalUpdate({required this.type, required this.signalType, required this.signalName, required this.signalId, this.prevValue, this.newValue, required this.timestamp, this.depth = 0})</code>

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="type"></a><code>String type</code>

##### <a name="signaltype"></a><code>String signalType</code>

##### <a name="signalname"></a><code>String signalName</code>

##### <a name="signalid"></a><code>int signalId</code>

##### <a name="prevvalue"></a><code>String? prevValue</code>

##### <a name="newvalue"></a><code>String? newValue</code>

##### <a name="timestamp"></a><code>DateTime timestamp</code>

##### <a name="depth"></a><code>int depth</code>

</details>



---

## UpdatesView


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="updatesview"></a><a name="updatesview"></a><code>UpdatesView({super.key})</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a><code>Widget build(BuildContext context)</code>

</details>
