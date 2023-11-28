// Copyright 2023 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'package:devtools_app_shared/ui.dart';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'node_table.dart';
import 'nodes_state.dart';
import 'selected_node.dart';

class ServiceExtension extends StatelessWidget {
  const ServiceExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: denseSpacing),
            child: NodesTable(),
          ),
        ),
        const PaddedDivider.thin(),
        Builder(builder: (context) {
          final items = nodes.watch(context);
          final index = selectedIndex.watch(context);
          final length = items.length;
          if (length == 0) {
            return const SizedBox.shrink();
          }
          return SelectedNode(
            selectedNode: items[index],
            onIncrement:
                index == length - 1 ? null : () => changeId(increment: true),
            onDecrement: index == 0 ? null : () => changeId(increment: false),
          );
        }),
      ],
    );
  }
}
