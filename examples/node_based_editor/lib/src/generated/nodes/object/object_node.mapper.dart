// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'object_node.dart';

class ObjectNodeMapper extends SubClassMapperBase<ObjectNode> {
  ObjectNodeMapper._();

  static ObjectNodeMapper? _instance;
  static ObjectNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectNode';

  static int _$id(ObjectNode v) => v.id;
  static const Field<ObjectNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(ObjectNode v) => v.inputs;
  static const Field<ObjectNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(ObjectNode v) => v.offset;
  static const Field<ObjectNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(ObjectNode v) => v.label;
  static const Field<ObjectNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(ObjectNode v) => v.expanded;
  static const Field<ObjectNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(ObjectNode v) => v.getNode;
  static const Field<ObjectNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<ObjectNode> fields = const {
    #id: _f$id,
    #inputs: _f$inputs,
    #offset: _f$offset,
    #label: _f$label,
    #expanded: _f$expanded,
    #getNode: _f$getNode,
  };

  @override
  final String discriminatorKey = '__type';
  @override
  final dynamic discriminatorValue = 'object_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static ObjectNode _instantiate(DecodingData data) {
    return ObjectNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectNode>(map);
  }

  static ObjectNode fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectNode>(json);
  }
}

mixin ObjectNodeMappable {
  String toJson() {
    return ObjectNodeMapper.ensureInitialized()
        .encodeJson<ObjectNode>(this as ObjectNode);
  }

  Map<String, dynamic> toMap() {
    return ObjectNodeMapper.ensureInitialized()
        .encodeMap<ObjectNode>(this as ObjectNode);
  }

  ObjectNodeCopyWith<ObjectNode, ObjectNode, ObjectNode> get copyWith =>
      _ObjectNodeCopyWithImpl(this as ObjectNode, $identity, $identity);
  @override
  String toString() {
    return ObjectNodeMapper.ensureInitialized()
        .stringifyValue(this as ObjectNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ObjectNodeMapper.ensureInitialized()
                .isValueEqual(this as ObjectNode, other));
  }

  @override
  int get hashCode {
    return ObjectNodeMapper.ensureInitialized().hashValue(this as ObjectNode);
  }
}

extension ObjectNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectNode, $Out> {
  ObjectNodeCopyWith<$R, ObjectNode, $Out> get $asObjectNode =>
      $base.as((v, t, t2) => _ObjectNodeCopyWithImpl(v, t, t2));
}

abstract class ObjectNodeCopyWith<$R, $In extends ObjectNode, $Out>
    implements BaseNodeCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
      ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>> get inputs;
  @override
  $R call(
      {int? id,
      Map<String, NodeInput<dynamic>>? inputs,
      Signal<NodeOffset>? offset,
      Signal<String>? label,
      Signal<bool>? expanded});
  ObjectNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ObjectNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectNode, $Out>
    implements ObjectNodeCopyWith<$R, ObjectNode, $Out> {
  _ObjectNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectNode> $mapper =
      ObjectNodeMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
          ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>>
      get inputs => MapCopyWith($value.inputs,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(inputs: v));
  @override
  $R call(
          {int? id,
          Map<String, NodeInput<dynamic>>? inputs,
          Signal<NodeOffset>? offset,
          Signal<String>? label,
          Signal<bool>? expanded}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (inputs != null) #inputs: inputs,
        if (offset != null) #offset: offset,
        if (label != null) #label: label,
        if (expanded != null) #expanded: expanded
      }));
  @override
  ObjectNode $make(CopyWithData data) => ObjectNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  ObjectNodeCopyWith<$R2, ObjectNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ObjectNodeCopyWithImpl($value, $cast, t);
}
