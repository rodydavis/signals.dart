import 'package:flutter/material.dart';
import 'package:flutter_preact_signals/flutter_preact_signals.dart';

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
    // return Table(
    //   border: TableBorder.all(
    //     color: Theme.of(context).colorScheme.onSurface,
    //   ),
    //   columnWidths: const <int, TableColumnWidth>{
    //     0: FlexColumnWidth(),
    //     1: FlexColumnWidth(),
    //     2: FlexColumnWidth(),
    //     3: FlexColumnWidth(),
    //   },
    //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //   children: <TableRow>[
    //     TableRow(
    //       children: <Widget>[
    //         _GridEntry(
    //           text: 'Global ID',
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         ),
    //         _GridEntry(
    //           text: 'Type',
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         ),
    //         _GridEntry(
    //           text: 'Debug Label',
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         ),
    //         _GridEntry(
    //           text: 'Value',
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         ),
    //       ],
    //     ),
    //     for (final node in items)
    //       TableRow(
    //         children: [
    //           _GridEntry(text: node.id.toString()),
    //           _GridEntry(text: node.type),
    //           _GridEntry(text: node.label ?? 'N/A'),
    //           _GridEntry(text: node.value ?? ''),
    //         ],
    //       ),
    //   ],
    // );
  }
}

// class _GridEntry extends StatelessWidget {
//   const _GridEntry({required this.text, this.style});

//   final String text;
//   final TextStyle? style;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         text,
//         style: style ?? Theme.of(context).textTheme.bodyMedium,
//       ),
//     );
//   }
// }
