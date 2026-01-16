import 'package:signals/signals.dart';

import 'graph.dart';

class GraphSignal extends Signal<Graph> implements Graph {
  GraphSignal(
    super.value, {
    super.options,
  });

  @override
  Vertex? operator [](String vertexId) => value[vertexId];

  @override
  void operator []=(String key, Vertex vertex) {
    value[key] = vertex;
    set(value, force: true);
  }

  @override
  List<Vertex> get vertices => value.vertices;

  @override
  void addEdge(String from, String to) {
    value.addEdge(from, to);
    set(value, force: true);
  }

  @override
  void removeVertex(String vertexId) {
    value.removeVertex(vertexId);
    set(value, force: true);
  }

  @override
  void setVertex(Vertex vertex) {
    value.setVertex(vertex);
    set(value, force: true);
  }

  @override
  GraphCopyWith<Graph, Graph, Graph> get copyWith => value.copyWith;

  @override
  Map<String, dynamic> toMap() => value.toMap();

  @override
  String toJson() => super.toJson();
}
