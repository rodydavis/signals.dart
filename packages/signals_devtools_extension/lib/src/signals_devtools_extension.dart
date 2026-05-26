// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_devtools_extension/src/node_graph.dart';
import 'package:signals_devtools_extension/src/widget/updates_view.dart';

import 'nodes_state.dart';

/// The main widget of the Signals DevTools Extension.
///
/// Wraps the [SignalsExtensionHomePage] inside a `DevToolsExtension` container
/// supplied by the `devtools_extensions` package. This allows it to:
/// - Connect securely to the Dart VM Service.
/// - Retrieve the application context and themes from DevTools.
/// - Render custom debugging tabs directly as a pane in Flutter DevTools.
///
/// ### UI Elements
///
/// The UI is structured into two main diagnostic views:
///
/// 1. **Updates Feed**:
///    - Displays a live, chronological stream of all signal value updates, computed evaluations, and effect executions.
///    - Includes previous and new values, timestamps, and active pause/resume capabilities to let developers snapshot reactions.
///
/// 2. **Dependency Graph**:
///    - An interactive dependency visualizer powered by `GraphView`.
///    - Shows the relationship and flow of reactive nodes: `Signals` (sources) -> `Computeds` (intermediates) -> `Effects` (sinks).
///    - Hovering or clicking on a node highlights its dependencies and current value.
///
/// :::info
/// This panel leverages service extensions registered by `signals_core` in debug mode. It tracks creation,
/// updates, and removal of nodes dynamically using standard event streams.
/// :::
class SignalsDevToolsExtension extends StatelessWidget {
  const SignalsDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: SignalsExtensionHomePage(),
    );
  }
}

class SignalsExtensionHomePage extends StatefulWidget {
  const SignalsExtensionHomePage({super.key});

  @override
  State<SignalsExtensionHomePage> createState() =>
      _SignalsExtensionHomePageState();
}

class _SignalsExtensionHomePageState extends State<SignalsExtensionHomePage> {
  final activeTab = signal<int>(0); // 0 = Updates, 1 = Graph
  final scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _nodesSubscriptionCleanup;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await serviceManager.onServiceAvailable;
    final cancel = initNodes();
    if (cancel != null) {
      _nodesSubscriptionCleanup = () => cancel();
    }
    await refreshNodes();
  }

  @override
  void dispose() {
    _nodesSubscriptionCleanup?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SignalBuilder(builder: (context) {
      final tabIndex = activeTab.value;
      final isPausedVal = isPaused.value;

      return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF181824) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              child: Row(
                children: [
                  // Title and Connection status
                  Row(
                    children: [
                      Text(
                        'Signals',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Glowing green status dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.6),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Connected',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Control Buttons matching JS UI
                  Row(
                    children: [
                      // Pause / Resume
                      TextButton.icon(
                        onPressed: () => isPaused.value = !isPausedVal,
                        icon: Icon(
                          isPausedVal ? Icons.play_arrow : Icons.pause,
                          size: 16,
                        ),
                        label: Text(isPausedVal ? 'Resume' : 'Pause'),
                        style: TextButton.styleFrom(
                          foregroundColor: isPausedVal
                              ? Colors.green
                              : theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Clear
                      TextButton.icon(
                        onPressed: () {
                          clearUpdates();
                        },
                        icon: const Icon(Icons.clear_all, size: 16),
                        label: const Text('Clear'),
                      ),
                      const SizedBox(width: 8),
                      // Settings Button
                      IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openEndDrawer();
                        },
                        icon: const Icon(Icons.settings, size: 20),
                        tooltip: 'Settings',
                      ),
                      const SizedBox(width: 8),
                      // Reload Button
                      IconButton(
                        onPressed: refreshNodes,
                        icon: const Icon(Icons.refresh, size: 20),
                        tooltip: 'Refresh nodes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        endDrawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                ),
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Debug Configuration',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Match JS Signals DevTools features',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    SwitchListTile(
                      value: true,
                      onChanged: (val) {},
                      title: const Text('Enable debug updates'),
                      subtitle: const Text(
                          'Capture signals modifications in real time'),
                    ),
                    const Divider(),
                    SwitchListTile(
                      value: true,
                      onChanged: (val) {},
                      title: const Text('Group related updates'),
                      subtitle: const Text(
                          'Coalesce sequential updates to the same signal'),
                    ),
                    const Divider(),
                    SwitchListTile(
                      value: false,
                      onChanged: (val) {},
                      title: const Text('Enable console logging'),
                      subtitle: const Text(
                          'Print signals changes directly to VM debug console'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Pill tabs switcher
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: isDark ? const Color(0xFF181824) : Colors.grey.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton(
                    context: context,
                    index: 0,
                    icon: Icons.list_alt,
                    label: 'Updates',
                    active: tabIndex == 0,
                  ),
                  const SizedBox(width: 16),
                  _buildTabButton(
                    context: context,
                    index: 1,
                    icon: Icons.account_tree_outlined,
                    label: 'Dependency Graph',
                    active: tabIndex == 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: tabIndex,
                children: const [
                  UpdatesView(),
                  NodeGraph(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabButton({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
    required bool active,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => activeTab.value = index,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? theme.colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: active
                ? theme.colorScheme.primary.withOpacity(0.4)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: active
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
