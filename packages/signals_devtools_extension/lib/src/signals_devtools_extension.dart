// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    initNodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Signals DevTools Extension'),
          actions: const [
            IconButton(
              onPressed: refreshNodes,
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh nodes',
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Graph'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NodesTable(),
            NodeGraph(),
          ],
        ),
      ),
    );
  }
}
