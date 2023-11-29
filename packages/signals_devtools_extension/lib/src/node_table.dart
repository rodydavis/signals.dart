import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';

class NodesTable extends StatelessWidget {
  const NodesTable({super.key});
  @override
  Widget build(BuildContext context) {
    final items = nodes.watch(context);
    if (items.isEmpty) {
      return const Center(child: Text('No nodes created'));
    }
    final idx = selectedIndex.watch(context);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text('${item.type} (${item.id})'),
          subtitle: item.label == null ? null : Text(item.label ?? 'N/A'),
          onTap: () => selectedIndex.value = index,
          selected: idx == index,
        );
      },
    );
  }
}
