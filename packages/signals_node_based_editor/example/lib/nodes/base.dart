import 'package:signals_node_based_editor/signals_node_based_editor.dart';

abstract class BaseNode extends GraphNode {
  @override
  final String type$;
  BaseNode(this.type$);

  Map<String, dynamic> toJson();
}
