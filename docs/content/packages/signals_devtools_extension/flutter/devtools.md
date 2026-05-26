---
title: SignalsDevToolsExtension
description: The main widget of the Signals DevTools Extension.
---

The main widget of the Signals DevTools Extension.

Wraps the [SignalsExtensionHomePage](/packages/signals_devtools_extension/flutter/devtools) inside a `DevToolsExtension` container
supplied by the `devtools_extensions` package. This allows it to:
- Connect securely to the Dart VM Service.
- Retrieve the application context and themes from DevTools.
- Render custom debugging tabs directly as a pane in Flutter DevTools.

### UI Elements

The UI is structured into two main diagnostic views:

1. **Updates Feed**:
   - Displays a live, chronological stream of all signal value updates, computed evaluations, and effect executions.
   - Includes previous and new values, timestamps, and active pause/resume capabilities to let developers snapshot reactions.

2. **Dependency Graph**:
   - An interactive dependency visualizer powered by `GraphView`.
   - Shows the relationship and flow of reactive nodes: `Signals` (sources) -> `Computeds` (intermediates) -> `Effects` (sinks).
   - Hovering or clicking on a node highlights its dependencies and current value.

<Info>
This panel leverages service extensions registered by `signals_core` in debug mode. It tracks creation,
updates, and removal of nodes dynamically using standard event streams.
</Info>


### Constructors

##### <a name="signalsdevtoolsextension"></a><a name="signalsdevtoolsextension"></a>`SignalsDevToolsExtension({super.key})`


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## $Node


### Constructors

##### <a name="$node"></a><a name="$node"></a>`$Node({required this.id, required this.type, this.label, this.value, this.sources, this.targets})`

##### <a name="$node-fromjson"></a><a name="fromjson"></a>`$Node.fromJson(Map<String, dynamic> item)`


### Properties

##### <a name="id"></a>`int id`

##### <a name="type"></a>`String type`

##### <a name="label"></a>`String? label`

##### <a name="value"></a>`String? value`

##### <a name="sources"></a>`String? sources`

##### <a name="targets"></a>`String? targets`


### Methods

##### <a name="tostring"></a>`String toString()`



---

## BackgroundGrid


### Constructors

##### <a name="backgroundgrid"></a><a name="backgroundgrid"></a>`BackgroundGrid({super.key, required this.backgroundColor, required this.foregroundColor})`


### Properties

##### <a name="backgroundcolor"></a>`Color backgroundColor`

##### <a name="foregroundcolor"></a>`Color foregroundColor`


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## NodeGraph


### Constructors

##### <a name="nodegraph"></a><a name="nodegraph"></a>`NodeGraph({super.key})`


### Methods

##### <a name="createstate"></a>`State<NodeGraph> createState()`



---

## NodesTable


### Constructors

##### <a name="nodestable"></a><a name="nodestable"></a>`NodesTable({super.key})`


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## NodeView


### Constructors

##### <a name="nodeview"></a><a name="nodeview"></a>`NodeView({required this.nodeId, super.key})`


### Properties

##### <a name="nodeid"></a>`int nodeId`


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`



---

## SignalsExtensionHomePage


### Constructors

##### <a name="signalsextensionhomepage"></a><a name="signalsextensionhomepage"></a>`SignalsExtensionHomePage({super.key})`


### Methods

##### <a name="createstate"></a>`State<SignalsExtensionHomePage> createState()`



---

## SignalUpdate


### Constructors

##### <a name="signalupdate"></a><a name="signalupdate"></a>`SignalUpdate({required this.type, required this.signalType, required this.signalName, required this.signalId, this.prevValue, this.newValue, required this.timestamp, this.depth = 0})`


### Properties

##### <a name="type"></a>`String type`

##### <a name="signaltype"></a>`String signalType`

##### <a name="signalname"></a>`String signalName`

##### <a name="signalid"></a>`int signalId`

##### <a name="prevvalue"></a>`String? prevValue`

##### <a name="newvalue"></a>`String? newValue`

##### <a name="timestamp"></a>`DateTime timestamp`

##### <a name="depth"></a>`int depth`



---

## UpdatesView


### Constructors

##### <a name="updatesview"></a><a name="updatesview"></a>`UpdatesView({super.key})`


### Methods

##### <a name="build"></a>`Widget build(BuildContext context)`
