import 'package:dart_mappable/dart_mappable.dart';

part 'graph.mapper.dart';

@MappableClass()
class Vertex with VertexMappable {
  final String id;

  Vertex(this.id);
}

@MappableClass()
class Graph with GraphMappable {
  final Map<String, Vertex> _vertices;
  final Map<String, Set<String>> _adjacencyList;
  final Map<String, Set<String>> _reverseAdjacencyList;

  @MappableConstructor()
  Graph({
    Map<String, Vertex>? vertices,
    Map<String, Set<String>>? adjacencyList,
    Map<String, Set<String>>? reverseAdjacencyList,
  })  : _vertices = vertices ?? {},
        _adjacencyList = adjacencyList ?? {},
        _reverseAdjacencyList = reverseAdjacencyList ?? {};

  Vertex? operator [](String vertexId) => _vertices[vertexId];

  void operator []=(String key, Vertex vertex) {
    assert(vertex.id == key);
    _vertices[key] = vertex;
    _adjacencyList[key] = {};
    _reverseAdjacencyList[key] = {};
  }

  List<Vertex> get vertices => _vertices.values.toList();

  void setVertex(Vertex vertex) => this[vertex.id] = vertex;

  void removeVertex(String vertexId) {
    if (_vertices.containsKey(vertexId)) {
      _vertices.remove(vertexId);
      _adjacencyList.remove(vertexId);
      _reverseAdjacencyList.remove(vertexId);
    } else {
      throw Exception("Vertex not found in the DAG");
    }
  }

  void addEdge(String from, String to) {
    if (!(_adjacencyList[from]?.add(to) ?? false) ||
        !(_reverseAdjacencyList[to]?.add(from) ?? false)) {
      throw Exception("Vertices not found in the DAG");
    }
  }
}
