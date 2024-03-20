// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'base_node.dart';

class BaseNodeMapper extends ClassMapperBase<BaseNode> {
  BaseNodeMapper._();

  static BaseNodeMapper? _instance;
  static BaseNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseNodeMapper._());
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
      NodeInputMapper.ensureInitialized();
      NodeOffsetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseNode';

  static int _$id(BaseNode v) => v.id;
  static const Field<BaseNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BaseNode v) => v.inputs;
  static const Field<BaseNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<String> _$label(BaseNode v) => v.label;
  static const Field<BaseNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<NodeOffset> _$offset(BaseNode v) => v.offset;
  static const Field<BaseNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<bool> _$expanded(BaseNode v) => v.expanded;
  static const Field<BaseNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BaseNode v) => v.getNode;
  static const Field<BaseNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BaseNode> fields = const {
    #id: _f$id,
    #inputs: _f$inputs,
    #label: _f$label,
    #offset: _f$offset,
    #expanded: _f$expanded,
    #getNode: _f$getNode,
  };

  static BaseNode _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('BaseNode');
  }

  @override
  final Function instantiate = _instantiate;

  static BaseNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseNode>(map);
  }

  static BaseNode fromJson(String json) {
    return ensureInitialized().decodeJson<BaseNode>(json);
  }
}

mixin BaseNodeMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BaseNodeCopyWith<BaseNode, BaseNode, BaseNode> get copyWith;
}

abstract class BaseNodeCopyWith<$R, $In extends BaseNode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, NodeInput<dynamic>,
      ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>> get inputs;
  $R call(
      {int? id,
      Map<String, NodeInput<dynamic>>? inputs,
      Signal<String>? label,
      Signal<NodeOffset>? offset,
      Signal<bool>? expanded});
  BaseNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class NodeInputMapper extends RecordMapperBase<NodeInput> {
  static NodeInputMapper? _instance;
  NodeInputMapper._();

  static NodeInputMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NodeInputMapper._());
      MapperBase.addType(<A, B>(f) => f<({A link, B value})>());
    }
    return _instance!;
  }

  static NodeLink? _$link(NodeInput v) => v.link;
  static const Field<NodeInput, NodeLink> _f$link = Field('link', _$link);
  static Signal<dynamic> _$value(NodeInput v) => v.value;
  static dynamic _arg$value<T>(f) => f<Signal<T>>();
  static const Field<NodeInput, Signal<dynamic>> _f$value =
      Field('value', _$value, arg: _arg$value);

  @override
  final MappableFields<NodeInput> fields = const {
    #link: _f$link,
    #value: _f$value,
  };

  @override
  Function get typeFactory => <T>(f) => f<NodeInput<T>>();

  @override
  List<Type> apply(MappingContext context) {
    return [
      context.arg(1, [0])
    ];
  }

  static NodeInput<T> _instantiate<T>(DecodingData<NodeInput> data) {
    return (link: data.dec(_f$link), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static NodeInput<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NodeInput<T>>(map);
  }

  static NodeInput<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<NodeInput<T>>(json);
  }
}

extension NodeInputMappable<T> on NodeInput<T> {
  Map<String, dynamic> toMap() {
    return NodeInputMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return NodeInputMapper.ensureInitialized().encodeJson(this);
  }

  NodeInputCopyWith<NodeInput<T>, T> get copyWith =>
      _NodeInputCopyWithImpl(this, $identity, $identity);
}

extension NodeInputValueCopy<$R, T>
    on ObjectCopyWith<$R, NodeInput<T>, NodeInput<T>> {
  NodeInputCopyWith<$R, T> get $asNodeInput =>
      $base.as((v, t, t2) => _NodeInputCopyWithImpl(v, t, t2));
}

abstract class NodeInputCopyWith<$R, T>
    implements RecordCopyWith<$R, NodeInput<T>> {
  $R call({NodeLink? link, Signal<T>? value});
  NodeInputCopyWith<$R2, T> $chain<$R2>(Then<NodeInput<T>, $R2> t);
}

class _NodeInputCopyWithImpl<$R, T> extends RecordCopyWithBase<$R, NodeInput<T>>
    implements NodeInputCopyWith<$R, T> {
  _NodeInputCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<NodeInput> $mapper =
      NodeInputMapper.ensureInitialized();
  @override
  $R call({Object? link = $none, Signal<T>? value}) => $apply(FieldCopyWithData(
      {if (link != $none) #link: link, if (value != null) #value: value}));
  @override
  NodeInput<T> $make(CopyWithData data) => (
        link: data.get(#link, or: $value.link),
        value: data.get(#value, or: $value.value)
      );

  @override
  NodeInputCopyWith<$R2, T> $chain<$R2>(Then<NodeInput<T>, $R2> t) =>
      _NodeInputCopyWithImpl($value, $cast, t);
}

class NodeOffsetMapper extends RecordMapperBase<NodeOffset> {
  static NodeOffsetMapper? _instance;
  NodeOffsetMapper._();

  static NodeOffsetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NodeOffsetMapper._());
      MapperBase.addType(<A, B>(f) => f<({A dx, B dy})>());
    }
    return _instance!;
  }

  static double _$dx(NodeOffset v) => v.dx;
  static const Field<NodeOffset, double> _f$dx = Field('dx', _$dx);
  static double _$dy(NodeOffset v) => v.dy;
  static const Field<NodeOffset, double> _f$dy = Field('dy', _$dy);

  @override
  final MappableFields<NodeOffset> fields = const {
    #dx: _f$dx,
    #dy: _f$dy,
  };

  @override
  Function get typeFactory => (f) => f<NodeOffset>();

  @override
  List<Type> apply(MappingContext context) {
    return [];
  }

  static NodeOffset _instantiate(DecodingData<NodeOffset> data) {
    return (dx: data.dec(_f$dx), dy: data.dec(_f$dy));
  }

  @override
  final Function instantiate = _instantiate;

  static NodeOffset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NodeOffset>(map);
  }

  static NodeOffset fromJson(String json) {
    return ensureInitialized().decodeJson<NodeOffset>(json);
  }
}

extension NodeOffsetMappable on NodeOffset {
  Map<String, dynamic> toMap() {
    return NodeOffsetMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return NodeOffsetMapper.ensureInitialized().encodeJson(this);
  }

  NodeOffsetCopyWith<NodeOffset> get copyWith =>
      _NodeOffsetCopyWithImpl(this, $identity, $identity);
}

extension NodeOffsetValueCopy<$R>
    on ObjectCopyWith<$R, NodeOffset, NodeOffset> {
  NodeOffsetCopyWith<$R> get $asNodeOffset =>
      $base.as((v, t, t2) => _NodeOffsetCopyWithImpl(v, t, t2));
}

abstract class NodeOffsetCopyWith<$R>
    implements RecordCopyWith<$R, NodeOffset> {
  $R call({double? dx, double? dy});
  NodeOffsetCopyWith<$R2> $chain<$R2>(Then<NodeOffset, $R2> t);
}

class _NodeOffsetCopyWithImpl<$R> extends RecordCopyWithBase<$R, NodeOffset>
    implements NodeOffsetCopyWith<$R> {
  _NodeOffsetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<NodeOffset> $mapper =
      NodeOffsetMapper.ensureInitialized();
  @override
  $R call({double? dx, double? dy}) => $apply(
      FieldCopyWithData({if (dx != null) #dx: dx, if (dy != null) #dy: dy}));
  @override
  NodeOffset $make(CopyWithData data) =>
      (dx: data.get(#dx, or: $value.dx), dy: data.get(#dy, or: $value.dy));

  @override
  NodeOffsetCopyWith<$R2> $chain<$R2>(Then<NodeOffset, $R2> t) =>
      _NodeOffsetCopyWithImpl($value, $cast, t);
}

class NodeLinkMapper extends RecordMapperBase<NodeLink> {
  static NodeLinkMapper? _instance;
  NodeLinkMapper._();

  static NodeLinkMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NodeLinkMapper._());
      MapperBase.addType(<A, B>(f) => f<({A nodeId, B outputKey})>());
    }
    return _instance!;
  }

  static int _$nodeId(NodeLink v) => v.nodeId;
  static const Field<NodeLink, int> _f$nodeId = Field('nodeId', _$nodeId);
  static String _$outputKey(NodeLink v) => v.outputKey;
  static const Field<NodeLink, String> _f$outputKey =
      Field('outputKey', _$outputKey);

  @override
  final MappableFields<NodeLink> fields = const {
    #nodeId: _f$nodeId,
    #outputKey: _f$outputKey,
  };

  @override
  Function get typeFactory => (f) => f<NodeLink>();

  @override
  List<Type> apply(MappingContext context) {
    return [];
  }

  static NodeLink _instantiate(DecodingData<NodeLink> data) {
    return (nodeId: data.dec(_f$nodeId), outputKey: data.dec(_f$outputKey));
  }

  @override
  final Function instantiate = _instantiate;

  static NodeLink fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NodeLink>(map);
  }

  static NodeLink fromJson(String json) {
    return ensureInitialized().decodeJson<NodeLink>(json);
  }
}

extension NodeLinkMappable on NodeLink {
  Map<String, dynamic> toMap() {
    return NodeLinkMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return NodeLinkMapper.ensureInitialized().encodeJson(this);
  }

  NodeLinkCopyWith<NodeLink> get copyWith =>
      _NodeLinkCopyWithImpl(this, $identity, $identity);
}

extension NodeLinkValueCopy<$R> on ObjectCopyWith<$R, NodeLink, NodeLink> {
  NodeLinkCopyWith<$R> get $asNodeLink =>
      $base.as((v, t, t2) => _NodeLinkCopyWithImpl(v, t, t2));
}

abstract class NodeLinkCopyWith<$R> implements RecordCopyWith<$R, NodeLink> {
  $R call({int? nodeId, String? outputKey});
  NodeLinkCopyWith<$R2> $chain<$R2>(Then<NodeLink, $R2> t);
}

class _NodeLinkCopyWithImpl<$R> extends RecordCopyWithBase<$R, NodeLink>
    implements NodeLinkCopyWith<$R> {
  _NodeLinkCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<NodeLink> $mapper =
      NodeLinkMapper.ensureInitialized();
  @override
  $R call({int? nodeId, String? outputKey}) => $apply(FieldCopyWithData({
        if (nodeId != null) #nodeId: nodeId,
        if (outputKey != null) #outputKey: outputKey
      }));
  @override
  NodeLink $make(CopyWithData data) => (
        nodeId: data.get(#nodeId, or: $value.nodeId),
        outputKey: data.get(#outputKey, or: $value.outputKey)
      );

  @override
  NodeLinkCopyWith<$R2> $chain<$R2>(Then<NodeLink, $R2> t) =>
      _NodeLinkCopyWithImpl($value, $cast, t);
}
