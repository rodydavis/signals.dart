import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';

class NodesTable extends StatelessWidget {
  const NodesTable({super.key});
  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      if (nodes.isEmpty) {
        return const Center(child: Text('No nodes created'));
      }
      return ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          final item = nodes[index];
          return ListTile(
            title: Text('${item.type} (${item.id})'),
            subtitle: item.label == null ? null : Text(item.label ?? 'N/A'),
            trailing: item.value == null ? null : Text(item.value ?? ''),
          );
        },
      );
    });
  }
}
