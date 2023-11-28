// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/api.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

import 'nodes_state.dart';
import 'service_extension.dart';

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
  String? message;

  @override
  void initState() {
    unawaited(refreshNodes());
    extensionManager.registerEventHandler(
      DevToolsExtensionEventType.unknown,
      // This callback will be called when the DevTools extension receives an
      // event of type [DevToolsExtensionEventType.unknown] from DevTools.
      (event) {
        message = event.data?.toString() ?? 'unknown event';
        print('event: $message');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: denseSpacing),
        child: ServiceExtension(),
      ),
    );
  }
}
