// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_object_node.dart';

class OptionalObjectNodeMapper extends SubClassMapperBase<OptionalObjectNode> {
  OptionalObjectNodeMapper._();

  static OptionalObjectNodeMapper? _instance;
  static OptionalObjectNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalObjectNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalObjectNode';

  static int _$id(OptionalObjectNode v) => v.id;
  static const Field<OptionalObjectNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalObjectNode v) =>
      v.inputs;
  static const Field<OptionalObjectNode, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalObjectNode v) => v.offset;
  static const Field<OptionalObjectNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalObjectNode v) => v.label;
  static const Field<OptionalObjectNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalObjectNode v) => v.expanded;
  static const Field<OptionalObjectNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalObjectNode v) => v.getNode;
  static const Field<OptionalObjectNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalObjectNode> fields = const {
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
  final dynamic discriminatorValue = 'optional_object_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalObjectNode _instantiate(DecodingData data) {
    return OptionalObjectNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalObjectNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalObjectNode>(map);
  }

  static OptionalObjectNode fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalObjectNode>(json);
  }
}

mixin OptionalObjectNodeMappable {
  String toJson() {
    return OptionalObjectNodeMapper.ensureInitialized()
        .encodeJson<OptionalObjectNode>(this as OptionalObjectNode);
  }

  Map<String, dynamic> toMap() {
    return OptionalObjectNodeMapper.ensureInitialized()
        .encodeMap<OptionalObjectNode>(this as OptionalObjectNode);
  }

  OptionalObjectNodeCopyWith<OptionalObjectNode, OptionalObjectNode,
          OptionalObjectNode>
      get copyWith => _OptionalObjectNodeCopyWithImpl(
          this as OptionalObjectNode, $identity, $identity);
  @override
  String toString() {
    return OptionalObjectNodeMapper.ensureInitialized()
        .stringifyValue(this as OptionalObjectNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalObjectNodeMapper.ensureInitialized()
                .isValueEqual(this as OptionalObjectNode, other));
  }

  @override
  int get hashCode {
    return OptionalObjectNodeMapper.ensureInitialized()
        .hashValue(this as OptionalObjectNode);
  }
}

extension OptionalObjectNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalObjectNode, $Out> {
  OptionalObjectNodeCopyWith<$R, OptionalObjectNode, $Out>
      get $asOptionalObjectNode =>
          $base.as((v, t, t2) => _OptionalObjectNodeCopyWithImpl(v, t, t2));
}

abstract class OptionalObjectNodeCopyWith<$R, $In extends OptionalObjectNode,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  OptionalObjectNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalObjectNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalObjectNode, $Out>
    implements OptionalObjectNodeCopyWith<$R, OptionalObjectNode, $Out> {
  _OptionalObjectNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalObjectNode> $mapper =
      OptionalObjectNodeMapper.ensureInitialized();
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
  OptionalObjectNode $make(CopyWithData data) => OptionalObjectNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalObjectNodeCopyWith<$R2, OptionalObjectNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OptionalObjectNodeCopyWithImpl($value, $cast, t);
}
