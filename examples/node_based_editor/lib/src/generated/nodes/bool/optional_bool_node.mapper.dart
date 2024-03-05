// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_bool_node.dart';

class OptionalBoolNodeMapper extends SubClassMapperBase<OptionalBoolNode> {
  OptionalBoolNodeMapper._();

  static OptionalBoolNodeMapper? _instance;
  static OptionalBoolNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalBoolNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalBoolNode';

  static int _$id(OptionalBoolNode v) => v.id;
  static const Field<OptionalBoolNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalBoolNode v) =>
      v.inputs;
  static const Field<OptionalBoolNode, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalBoolNode v) => v.offset;
  static const Field<OptionalBoolNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalBoolNode v) => v.label;
  static const Field<OptionalBoolNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalBoolNode v) => v.expanded;
  static const Field<OptionalBoolNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalBoolNode v) => v.getNode;
  static const Field<OptionalBoolNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalBoolNode> fields = const {
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
  final dynamic discriminatorValue = 'optional_bool_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalBoolNode _instantiate(DecodingData data) {
    return OptionalBoolNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalBoolNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalBoolNode>(map);
  }

  static OptionalBoolNode fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalBoolNode>(json);
  }
}

mixin OptionalBoolNodeMappable {
  String toJson() {
    return OptionalBoolNodeMapper.ensureInitialized()
        .encodeJson<OptionalBoolNode>(this as OptionalBoolNode);
  }

  Map<String, dynamic> toMap() {
    return OptionalBoolNodeMapper.ensureInitialized()
        .encodeMap<OptionalBoolNode>(this as OptionalBoolNode);
  }

  OptionalBoolNodeCopyWith<OptionalBoolNode, OptionalBoolNode, OptionalBoolNode>
      get copyWith => _OptionalBoolNodeCopyWithImpl(
          this as OptionalBoolNode, $identity, $identity);
  @override
  String toString() {
    return OptionalBoolNodeMapper.ensureInitialized()
        .stringifyValue(this as OptionalBoolNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalBoolNodeMapper.ensureInitialized()
                .isValueEqual(this as OptionalBoolNode, other));
  }

  @override
  int get hashCode {
    return OptionalBoolNodeMapper.ensureInitialized()
        .hashValue(this as OptionalBoolNode);
  }
}

extension OptionalBoolNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalBoolNode, $Out> {
  OptionalBoolNodeCopyWith<$R, OptionalBoolNode, $Out>
      get $asOptionalBoolNode =>
          $base.as((v, t, t2) => _OptionalBoolNodeCopyWithImpl(v, t, t2));
}

abstract class OptionalBoolNodeCopyWith<$R, $In extends OptionalBoolNode, $Out>
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
  OptionalBoolNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalBoolNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalBoolNode, $Out>
    implements OptionalBoolNodeCopyWith<$R, OptionalBoolNode, $Out> {
  _OptionalBoolNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalBoolNode> $mapper =
      OptionalBoolNodeMapper.ensureInitialized();
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
  OptionalBoolNode $make(CopyWithData data) => OptionalBoolNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalBoolNodeCopyWith<$R2, OptionalBoolNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OptionalBoolNodeCopyWithImpl($value, $cast, t);
}
