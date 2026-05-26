// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// # 🛠️ Signals DevTools Extension
///
/// A premium, state-of-the-art interactive debugger and visual diagnostic dashboard for the Signals reactive framework, seamlessly embedded inside Dart & Flutter DevTools.
///
/// The extension executes as an optimized Flutter Web application loaded inside an iframe by the DevTools shell. It establishes a secure, bi-directional event tunnel with the running host application using the Dart VM Service.
///
/// ---
///
/// ## 🌟 Premium Diagnostic Features
///
/// ### 1. Chronological Updates Timeline
/// - **Live Stream Feed**: Captures every single signal modification, computation re-evaluation, and side effect run in real-time.
/// - **Pause & Snapshot**: Suspend the update stream at any moment to dissect current state values without interference from active events.
/// - **Detailed Diff Views**: Displays the exact `prevValue` and `newValue` alongside the node's unique ID and exact execution timestamp.
///
/// ### 2. Visual Dependency Graph
/// - **Interactive Node Mapping**: Visualizes the entire reactive tree of your application using a beautiful, physics-based `GraphView`.
/// - **Node Typing**: Clearly distinguishes between `Signals` (source inputs), `Computeds` (intermediate reactive transformers), and `Effects` (sink execution blocks).
/// - **Dynamic Focus**: Click or hover over any node in the graph to immediately highlight its direct upstream dependencies and downstream targets.
///
/// ### 3. Real-time Node Inspector & Drawer
/// - **Deep Metadata View**: Pause updates and select any node to slide open a detail drawer showing its full runtime model: ID, label, value representation, upstream source lists, and downstream targets.
///
/// ---
///
/// ## 🚀 Getting Started & Local Integration
///
/// No manual integration code is required! In a debug environment, simply:
///
/// 1. Start your Flutter application:
///    ```bash
///    flutter run
///    ```
/// 2. Open Dart DevTools from your IDE or terminal.
/// 3. Locate the custom **Signals** tab in the main DevTools menu panel.
/// 4. Click the tab to inspect your application's reactive graph!
///
/// ---
///
/// ## 🛠️ Local Development & Simulation
///
/// To run and debug the DevTools extension itself in a simulated environment using hot-reload, execute the following command:
///
/// ```bash
/// flutter run -d chrome --dart-define=use_simulated_environment=true
/// ```
///
/// > [!IMPORTANT]
/// > Reactivity diagnostics are only active in **Debug** or **Profile** modes. In **Release** builds, the VM Service extension is stripped out by the Dart compiler to optimize final application size and performance.
library;


import 'package:flutter/material.dart';
import 'src/signals_devtools_extension.dart';

void main() {
  runApp(const SignalsDevToolsExtension());
}
