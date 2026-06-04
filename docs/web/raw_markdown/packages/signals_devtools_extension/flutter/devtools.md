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

##### <a name="signalsdevtoolsextension"></a><a name="signalsdevtoolsextension"></a>`SignalsDevToolsExtension({super.key})`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>



---

## $Node


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="$node"></a><a name="$node"></a>`$Node({required this.id, required this.type, this.label, this.value, this.sources, this.targets})`

##### <a name="$node-fromjson"></a><a name="fromjson"></a>`$Node.fromJson(Map<String, dynamic> item)`

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="id"></a>`int id`

##### <a name="type"></a>`String type`

##### <a name="label"></a>`String? label`

##### <a name="value"></a>`String? value`

##### <a name="sources"></a>`String? sources`

##### <a name="targets"></a>`String? targets`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tostring"></a>`String toString()`

</details>



---

## BackgroundGrid


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="backgroundgrid"></a><a name="backgroundgrid"></a>`BackgroundGrid({super.key, required this.backgroundColor, required this.foregroundColor})`

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="backgroundcolor"></a>`Color backgroundColor`

##### <a name="foregroundcolor"></a>`Color foregroundColor`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>



---

## NodeGraph


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodegraph"></a><a name="nodegraph"></a>`NodeGraph({super.key})`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createstate"></a>`State<NodeGraph> createState()`

</details>



---

## NodesTable


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodestable"></a><a name="nodestable"></a>`NodesTable({super.key})`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>



---

## NodeView


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="nodeview"></a><a name="nodeview"></a>`NodeView({required this.nodeId, super.key})`

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="nodeid"></a>`int nodeId`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>



---

## SignalsExtensionHomePage


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalsextensionhomepage"></a><a name="signalsextensionhomepage"></a>`SignalsExtensionHomePage({super.key})`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="createstate"></a>`State<SignalsExtensionHomePage> createState()`

</details>



---

## SignalUpdate


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalupdate"></a><a name="signalupdate"></a>`SignalUpdate({required this.type, required this.signalType, required this.signalName, required this.signalId, this.prevValue, this.newValue, required this.timestamp, this.depth = 0})`

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="type"></a>`String type`

##### <a name="signaltype"></a>`String signalType`

##### <a name="signalname"></a>`String signalName`

##### <a name="signalid"></a>`int signalId`

##### <a name="prevvalue"></a>`String? prevValue`

##### <a name="newvalue"></a>`String? newValue`

##### <a name="timestamp"></a>`DateTime timestamp`

##### <a name="depth"></a>`int depth`

</details>



---

## UpdatesView


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="updatesview"></a><a name="updatesview"></a>`UpdatesView({super.key})`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="build"></a>`Widget build(BuildContext context)`

</details>
