import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';

class NodesTable extends StatelessWidget {
  const NodesTable({super.key});
  @override
  Widget build(BuildContext context) {
    return Watch((context, _) {
      if (nodes.isEmpty) {
        return const Center(child: Text('No nodes created'));
      }
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView.builder(
            itemCount: nodes.length,
            itemBuilder: (context, index) {
              final item = nodes[index];
              return ExpansionTile(
                leading: Text(item.id.toString()),
                title: item.label == null
                    ? Text(item.type)
                    : Text('${item.type} (${item.label})'),
                subtitle: item.value == null ? null : Text(item.value ?? ''),
                children: [
                  if (item.sources != null)
                    Builder(
                      builder: (context) {
                        final children = (item.sources ?? '')
                            .split(',')
                            .map((e) => int.parse(e))
                            .map((e) => nodes.firstWhere((n) => n.id == e))
                            .toList();
                        return ExpansionTile(
                          title: const Text('Sources'),
                          initiallyExpanded: true,
                          children: [
                            for (final child in children)
                              ListTile(
                                leading: Text(child.id.toString()),
                                title: child.label == null
                                    ? Text(child.type)
                                    : Text('${child.type} (${child.label})'),
                                subtitle: child.value == null
                                    ? null
                                    : Text(child.value ?? ''),
                              ),
                          ],
                        );
                      },
                    ),
                  if (item.targets != null)
                    Builder(
                      builder: (context) {
                        final children = (item.targets ?? '')
                            .split(',')
                            .map((e) => int.parse(e))
                            .map((e) => nodes.firstWhere((n) => n.id == e))
                            .toList();
                        return ExpansionTile(
                          title: const Text('Targets'),
                          initiallyExpanded: true,
                          children: [
                            for (final child in children)
                              ListTile(
                                leading: Text(child.id.toString()),
                                title: child.label == null
                                    ? Text(child.type)
                                    : Text('${child.type} (${child.label})'),
                                subtitle: child.value == null
                                    ? null
                                    : Text(child.value ?? ''),
                              ),
                          ],
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
