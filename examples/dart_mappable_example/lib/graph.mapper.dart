// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'graph.dart';

class VertexMapper extends ClassMapperBase<Vertex> {
  VertexMapper._();

  static VertexMapper? _instance;
  static VertexMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VertexMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Vertex';

  static String _$id(Vertex v) => v.id;
  static const Field<Vertex, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<Vertex> fields = const {
    #id: _f$id,
  };

  static Vertex _instantiate(DecodingData data) {
    return Vertex(data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static Vertex fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Vertex>(map);
  }

  static Vertex fromJson(String json) {
    return ensureInitialized().decodeJson<Vertex>(json);
  }
}

mixin VertexMappable {
  String toJson() {
    return VertexMapper.ensureInitialized().encodeJson<Vertex>(this as Vertex);
  }

  Map<String, dynamic> toMap() {
    return VertexMapper.ensureInitialized().encodeMap<Vertex>(this as Vertex);
  }

  VertexCopyWith<Vertex, Vertex, Vertex> get copyWith =>
      _VertexCopyWithImpl(this as Vertex, $identity, $identity);
  @override
  String toString() {
    return VertexMapper.ensureInitialized().stringifyValue(this as Vertex);
  }

  @override
  bool operator ==(Object other) {
    return VertexMapper.ensureInitialized().equalsValue(this as Vertex, other);
  }

  @override
  int get hashCode {
    return VertexMapper.ensureInitialized().hashValue(this as Vertex);
  }
}

extension VertexValueCopy<$R, $Out> on ObjectCopyWith<$R, Vertex, $Out> {
  VertexCopyWith<$R, Vertex, $Out> get $asVertex =>
      $base.as((v, t, t2) => _VertexCopyWithImpl(v, t, t2));
}

abstract class VertexCopyWith<$R, $In extends Vertex, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  VertexCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VertexCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Vertex, $Out>
    implements VertexCopyWith<$R, Vertex, $Out> {
  _VertexCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Vertex> $mapper = VertexMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  Vertex $make(CopyWithData data) => Vertex(data.get(#id, or: $value.id));

  @override
  VertexCopyWith<$R2, Vertex, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _VertexCopyWithImpl($value, $cast, t);
}

class GraphMapper extends ClassMapperBase<Graph> {
  GraphMapper._();

  static GraphMapper? _instance;
  static GraphMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GraphMapper._());
      VertexMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Graph';

  static Map<String, Vertex> _$_vertices(Graph v) => v._vertices;
  static const Field<Graph, Map<String, Vertex>> _f$_vertices =
      Field('_vertices', _$_vertices, key: 'vertices', opt: true);
  static Map<String, Set<String>> _$_adjacencyList(Graph v) => v._adjacencyList;
  static const Field<Graph, Map<String, Set<String>>> _f$_adjacencyList = Field(
      '_adjacencyList', _$_adjacencyList,
      key: 'adjacencyList', opt: true);
  static Map<String, Set<String>> _$_reverseAdjacencyList(Graph v) =>
      v._reverseAdjacencyList;
  static const Field<Graph, Map<String, Set<String>>> _f$_reverseAdjacencyList =
      Field('_reverseAdjacencyList', _$_reverseAdjacencyList,
          key: 'reverseAdjacencyList', opt: true);

  @override
  final MappableFields<Graph> fields = const {
    #_vertices: _f$_vertices,
    #_adjacencyList: _f$_adjacencyList,
    #_reverseAdjacencyList: _f$_reverseAdjacencyList,
  };

  static Graph _instantiate(DecodingData data) {
    return Graph(
        vertices: data.dec(_f$_vertices),
        adjacencyList: data.dec(_f$_adjacencyList),
        reverseAdjacencyList: data.dec(_f$_reverseAdjacencyList));
  }

  @override
  final Function instantiate = _instantiate;

  static Graph fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Graph>(map);
  }

  static Graph fromJson(String json) {
    return ensureInitialized().decodeJson<Graph>(json);
  }
}

mixin GraphMappable {
  String toJson() {
    return GraphMapper.ensureInitialized().encodeJson<Graph>(this as Graph);
  }

  Map<String, dynamic> toMap() {
    return GraphMapper.ensureInitialized().encodeMap<Graph>(this as Graph);
  }

  GraphCopyWith<Graph, Graph, Graph> get copyWith =>
      _GraphCopyWithImpl(this as Graph, $identity, $identity);
  @override
  String toString() {
    return GraphMapper.ensureInitialized().stringifyValue(this as Graph);
  }

  @override
  bool operator ==(Object other) {
    return GraphMapper.ensureInitialized().equalsValue(this as Graph, other);
  }

  @override
  int get hashCode {
    return GraphMapper.ensureInitialized().hashValue(this as Graph);
  }
}

extension GraphValueCopy<$R, $Out> on ObjectCopyWith<$R, Graph, $Out> {
  GraphCopyWith<$R, Graph, $Out> get $asGraph =>
      $base.as((v, t, t2) => _GraphCopyWithImpl(v, t, t2));
}

abstract class GraphCopyWith<$R, $In extends Graph, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, Vertex, VertexCopyWith<$R, Vertex, Vertex>>
      get _vertices;
  MapCopyWith<$R, String, Set<String>,
      ObjectCopyWith<$R, Set<String>, Set<String>>> get _adjacencyList;
  MapCopyWith<$R, String, Set<String>,
      ObjectCopyWith<$R, Set<String>, Set<String>>> get _reverseAdjacencyList;
  $R call(
      {Map<String, Vertex>? vertices,
      Map<String, Set<String>>? adjacencyList,
      Map<String, Set<String>>? reverseAdjacencyList});
  GraphCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GraphCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Graph, $Out>
    implements GraphCopyWith<$R, Graph, $Out> {
  _GraphCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Graph> $mapper = GraphMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, Vertex, VertexCopyWith<$R, Vertex, Vertex>>
      get _vertices => MapCopyWith($value._vertices,
          (v, t) => v.copyWith.$chain(t), (v) => call(vertices: v));
  @override
  MapCopyWith<$R, String, Set<String>,
          ObjectCopyWith<$R, Set<String>, Set<String>>>
      get _adjacencyList => MapCopyWith(
          $value._adjacencyList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(adjacencyList: v));
  @override
  MapCopyWith<$R, String, Set<String>,
          ObjectCopyWith<$R, Set<String>, Set<String>>>
      get _reverseAdjacencyList => MapCopyWith(
          $value._reverseAdjacencyList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(reverseAdjacencyList: v));
  @override
  $R call(
          {Object? vertices = $none,
          Object? adjacencyList = $none,
          Object? reverseAdjacencyList = $none}) =>
      $apply(FieldCopyWithData({
        if (vertices != $none) #vertices: vertices,
        if (adjacencyList != $none) #adjacencyList: adjacencyList,
        if (reverseAdjacencyList != $none)
          #reverseAdjacencyList: reverseAdjacencyList
      }));
  @override
  Graph $make(CopyWithData data) => Graph(
      vertices: data.get(#vertices, or: $value._vertices),
      adjacencyList: data.get(#adjacencyList, or: $value._adjacencyList),
      reverseAdjacencyList:
          data.get(#reverseAdjacencyList, or: $value._reverseAdjacencyList));

  @override
  GraphCopyWith<$R2, Graph, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GraphCopyWithImpl($value, $cast, t);
}
