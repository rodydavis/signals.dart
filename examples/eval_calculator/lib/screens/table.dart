import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../core/context.dart';
import '../core/value_row.dart';
import '../widgets/update_notice.dart';

class TableCalculator extends StatelessWidget {
  const TableCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Table Calculator'),
      ),
      body: const TextTable(),
    );
  }
}

const _style = TextStyle(fontSize: 24);

class TextTable extends StatefulWidget {
  const TextTable({super.key});

  @override
  State<TextTable> createState() => _TextTableState();
}

class _TextTableState extends State<TextTable> {
  final evalContext = EvalContext();
  final textList = listSignal<ValueRow>([]);
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addRow(context, 'a = 3');
      addRow(context, 'b = 5');
      addRow(context, 'c = a + b');
    });
  }

  void addRow(BuildContext context, String definition) {
    final node = evalContext.addRow(context, definition);
    if (node != null) textList.add(node);
  }

  Widget valueToWidget(ValueRow valueRow, BuildContext context) {
    final valueDisplay = Watch(
      (context, _) => Text(valueRow.signalObject.value.toString(), style: _style),
    );

    if (valueRow.type == ValueType.number) {
      return Row(
        children: [
          Expanded(child: Text(valueRow.lhs, style: _style)),
          valueDisplay,
          const VerticalDivider(),
          IconButton.filled(
            icon: const Icon(Icons.remove),
            onPressed: () {
              (valueRow.signalObject as Signal).value--;
            },
          ),
          const SizedBox(width: 4),
          IconButton.filled(
            icon: const Icon(Icons.add),
            onPressed: () {
              (valueRow.signalObject as Signal).value++;
            },
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
              child: Text('${valueRow.lhs} = ${valueRow.rhs}', style: _style)),
          valueDisplay,
          UpdateNotice(signalObject: valueRow.signalObject),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context, _) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...(textList.map((row) => valueToWidget(row, context)).toList()),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter definition',
                      hintText: 'd = a * b',
                    ),
                    onSubmitted: (string) => addRow(context, string),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () => addRow(context, textController.text),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
