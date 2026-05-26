// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// # Signals DevTools Extension Entry Point
///
/// This is the entry point for the Signals DevTools Extension. When loaded inside
/// Dart/Flutter DevTools, it executes this Flutter web application as an iframe.
///
/// :::tip
/// To run the DevTools extension locally in a simulated environment for development, use the following command:
/// ```bash
/// flutter run -d chrome --dart-define=use_simulated_environment=true
/// ```
/// :::
///
/// ---
///
/// ## How It Works
///
/// 1. **Reactivity Diagnostics**: The extension communicates with the running host application via Dart VM Service extensions.
/// 2. **Real-time Synchronization**: As signals are created, updated, or deleted, events are pushed to DevTools and rendered inside this extension.
/// 3. **Dependency Graph**: The extension uses a `GraphView` to visually plot the reactive dependencies between signals, computed states, and effects.
///
/// ## Integration and Usage in Client Applications
///
/// The DevTools extension is packaged alongside the `signals` package and is automatically discovered by Flutter DevTools.
///
/// ### Prerequisites
///
/// - A Flutter application using `signals` or `signals_flutter`.
/// - Run the application in **Debug Mode** or **Profile Mode** (VM service is disabled in Release Mode).
///
/// ### Setup Instructions
///
/// No manual setup is needed! In a debug environment, simply:
///
/// 1. Start your Flutter application:
///    ```bash
///    flutter run
///    ```
/// 2. Open Dart DevTools from your IDE or terminal.
/// 3. Look for the custom **Signals** tab in the DevTools menu.
/// 4. Click the tab to inspect your application's reactive graph.
library;


import 'package:flutter/material.dart';
import 'src/signals_devtools_extension.dart';

void main() {
  runApp(const SignalsDevToolsExtension());
}
