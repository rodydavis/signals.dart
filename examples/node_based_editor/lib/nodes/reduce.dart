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
        } as T;
      });
    });
  }

  @override
  Widget build() => Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            width: 80,
            child: Column(
              children: [
                for (var i = 0; i < inputs.length; i++)
                  Row(
                    children: [
                      if (i == inputs.length - 1)
                        Text(
                          switch (current.value) {
                            Reducer.add => '+ ',
                            Reducer.subtract => '- ',
                            Reducer.divide => '/ ',
                            Reducer.multiply => '* ',
                          },
                          textAlign: TextAlign.left,
                        ),
                      Expanded(
                        child: Text(
                          inputs[i].output.toString(),
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
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            left: 5,
            child: DropdownButton(
              isDense: true,
              items: Reducer.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              value: current.value,
              onChanged: (val) => current.set(val!),
            ),
          ),
        ],
      );

  @override
  Size size() => Size(200, 40 + (20.0 * (inputs.length + 2)));
}

enum Reducer {
  add,
  subtract,
  divide,
  multiply,
}
