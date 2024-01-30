import 'package:flutter/material.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:signals/signals_flutter.dart';

import '../core/context.dart';
import '../core/value_row.dart';

const _style = TextStyle(fontSize: 14);

class SpreadsheetCalculator extends StatefulWidget {
  const SpreadsheetCalculator({super.key});

  @override
  State<SpreadsheetCalculator> createState() => _SpreadsheetCalculatorState();
}

class _SpreadsheetCalculatorState extends State<SpreadsheetCalculator> {
  int _rowCount = 20;
  int _colCount = 30;
  final evalContext = EvalContext();
  final cells = mapSignal<(int, int), ValueRow?>({});
  final editCell = signal<(int, int)?>(null);
  final textController = TextEditingController();
  late final text = textController.toSignal();
  late final selectedCells = computed(
    () => text.value.text.replaceFirst('=', '').split('+'),
  );

  Widget valueToWidget(ValueRow valueRow, BuildContext context) {
    final valueDisplay = Watch(
      (context) => Text(valueRow.signalObject.value.toString(), style: _style),
    );

    if (valueRow.type == ValueType.number) {
      return valueDisplay;
    } else {
      return valueDisplay;
    }
  }

  @override
  Widget build(BuildContext context) {
    const cellSize = 30.0;
    return Watch((context) {
      final selected = selectedCells();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Spreadsheet Calculator'),
        ),
        body: Column(
          children: [
            if (editCell.value != null)
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Edit cell: ${editCell()!.description}',
                    hintText: 'd = a * b',
                    suffix: IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        final str = textController.text.trim();
                        if (str.isNotEmpty &&
                            str != '${editCell()!.description}=') {
                          if (cells[editCell()!]?.definition != str) {
                            final node = evalContext.addRow(context, str);
                            if (node != null) {
                              cells[editCell()!] = node;
                            }
                          }
                        } else {
                          cells.remove(editCell()!);
                        }
                        editCell.value = null;
                        textController.clear();
                      },
                    ),
                  ),
                ),
              ),
            Expanded(
              child: TableView.builder(
                columns: [
                  for (var i = 1; i < _colCount; i++)
                    const TableColumn(width: 64 * 3),
                ],
                rowCount: _rowCount,
                rowHeight: cellSize,
                rowBuilder: (context, row, contentBuilder) {
                  return contentBuilder(
                    context,
                    (context, column) {
                      final cell = (column, row);
                      final implicitSelection =
                          selected.any((e) => e == cell.description);
                      final current = cells[cell];
                      return InkWell(
                        onTap: () {
                          if (editCell.value == null) {
                            editCell.value = cell;
                            if (current != null) {
                              textController.text = current.definition;
                            } else {
                              textController.text = '${cell.description}=';
                            }
                          } else {
                            textController.text += cell.description;
                          }
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: .5,
                            ),
                          ),
                          child: Container(
                            decoration: editCell.value == cell
                                ? BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : implicitSelection
                                    ? BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )
                                    : null,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: editCell.value == cell
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : implicitSelection
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                              ),
                              child: Tooltip(
                                message: cell.description,
                                child: Center(
                                  child: current != null
                                      ? valueToWidget(current, context)
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        persistentFooterButtons: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                _rowCount += 10;
              });
            },
            child: const Text('Add 10 Rows'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _colCount += 10;
              });
            },
            child: const Text('Add 10 Columns'),
          ),
        ],
      );
    });
  }
}

extension on (int, int) {
  String get column {
    var s = '';
    for (var i = 0; i < ($1 + 1); i++) {
      s = nextCol(s);
    }
    return s;
  }

  String get row => '${$2}';
  String get description => '$column$row';
}

String nextChar(String? c) =>
    c != null && c.isNotEmpty ? String.fromCharCode(c.codeUnitAt(0) + 1) : 'A';

String nextCol(String s) => s.replaceFirstMapped(
      RegExp(r'([^Z]?)(Z*$)'),
      (match) =>
          nextChar(match.group(1)) + match.group(2)!.replaceAll('Z', 'A'),
    );
