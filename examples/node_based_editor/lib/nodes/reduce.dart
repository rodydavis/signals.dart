import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

class ReduceNode<T extends num> extends Node<T, T> {
  @override
  late final Computed<T> output;

  late final Signal<Reducer> current;

  ReduceNode(
    Reducer currentReducer,
    List<Node<dynamic, T>> inputs,
  )   : current = signal(currentReducer),
        super(name: 'Reducer', inputs: inputs) {
    output = computed(() {
      final source = inputs.map((e) => e.output()).toList();
      return source.reduce((a, b) {
        return switch (current.value) {
          Reducer.add => a + b,
          Reducer.subtract => a - b,
          Reducer.divide => a / b,
          Reducer.multiply => a * b,
          Reducer.modulo => a % b,
          Reducer.truncateDivision => a ~/ b,
        } as T;
      });
    });
  }

  @override
  Widget build() => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < inputs.length; i++)
              Row(
                children: [
                  if (i == inputs.length - 1)
                    () {
                      return DropdownButton(
                        isDense: true,
                        items: Reducer.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(switch (e) {
                                    Reducer.add => '+',
                                    Reducer.subtract => '-',
                                    Reducer.divide => '/',
                                    Reducer.multiply => '*',
                                    Reducer.modulo => '%',
                                    Reducer.truncateDivision => '~/',
                                  }),
                                ))
                            .toList(),
                        value: current.value,
                        onChanged: (val) => current.set(val!),
                      );
                    }(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      inputs[i].output.toString(),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    output.toString(),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Size size() => Size(100, 30 + (20.0 * (inputs.length + 2)));
}

enum Reducer {
  add,
  subtract,
  divide,
  multiply,
  modulo,
  truncateDivision,
}
