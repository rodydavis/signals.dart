import 'package:flutter_test/flutter_test.dart';

import 'package:node_based_editor/src/generated/nodes/int/int_node.dart';

void main() {
  group('nodes', () {
    test('int', () {
      final node = IntNode.defaults(1);
      final node2 = IntNode.defaults(2);
      final nodes = [node, node2];

      IntNode? getNode(int id) {
        final idx = nodes.indexWhere((e) => e.id == id);
        if (idx != -1) return nodes[idx];
        return null;
      }

      node.getNode = getNode;
      node2.getNode = getNode;

      expect(node.id, 1);

      node.label.value = 'Hello';
      node.offset.value = (dx: 1, dy: node.offset.value.dy);
      node.linkInput('value', (nodeId: node2.id, outputKey: 'value'));
      node2.setInputValue('value', 10);

      // print(node.toMap());

      expect(node.label.value, 'Hello');
      expect(node.output('value')!.value, node2.input('value')!.value);
    });
  });
}
