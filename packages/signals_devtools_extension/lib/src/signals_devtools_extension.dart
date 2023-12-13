// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_devtools_extension/src/node_graph.dart';

import 'node_table.dart';
import 'nodes_state.dart';

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
  final tab = signal(0);

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    initNodes();
    await refreshNodes();
  }

  @override
  Widget build(BuildContext context) {
    final index = tab.watch(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                NavigationRail(
                  minWidth: 30,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('List'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.account_tree),
                      label: Text('Graph'),
                    ),
                  ],
                  selectedIndex: index,
                  onDestinationSelected: tab.set,
                  labelType: NavigationRailLabelType.all,
                ),
                Expanded(
                  child: SizedBox.expand(
                    child: Builder(builder: (context) {
                      if (index == 0) {
                        return const NodesTable();
                      } else {
                        return const NodeGraph();
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 15,
            left: 15,
            child: IconButton(
              onPressed: refreshNodes,
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh nodes',
            ),
          ),
        ],
      ),
    );
  }
}
