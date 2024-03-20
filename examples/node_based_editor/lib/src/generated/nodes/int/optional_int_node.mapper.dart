// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_int_node.dart';

class OptionalIntNodeMapper extends SubClassMapperBase<OptionalIntNode> {
  OptionalIntNodeMapper._();

  static OptionalIntNodeMapper? _instance;
  static OptionalIntNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalIntNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalIntNode';

  static int _$id(OptionalIntNode v) => v.id;
  static const Field<OptionalIntNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalIntNode v) =>
      v.inputs;
  static const Field<OptionalIntNode, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalIntNode v) => v.offset;
  static const Field<OptionalIntNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalIntNode v) => v.label;
  static const Field<OptionalIntNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalIntNode v) => v.expanded;
  static const Field<OptionalIntNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalIntNode v) => v.getNode;
  static const Field<OptionalIntNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalIntNode> fields = const {
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
  final dynamic discriminatorValue = 'optional_int_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalIntNode _instantiate(DecodingData data) {
    return OptionalIntNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalIntNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalIntNode>(map);
  }

  static OptionalIntNode fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalIntNode>(json);
  }
}

mixin OptionalIntNodeMappable {
  String toJson() {
    return OptionalIntNodeMapper.ensureInitialized()
        .encodeJson<OptionalIntNode>(this as OptionalIntNode);
  }

  Map<String, dynamic> toMap() {
    return OptionalIntNodeMapper.ensureInitialized()
        .encodeMap<OptionalIntNode>(this as OptionalIntNode);
  }

  OptionalIntNodeCopyWith<OptionalIntNode, OptionalIntNode, OptionalIntNode>
      get copyWith => _OptionalIntNodeCopyWithImpl(
          this as OptionalIntNode, $identity, $identity);
  @override
  String toString() {
    return OptionalIntNodeMapper.ensureInitialized()
        .stringifyValue(this as OptionalIntNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalIntNodeMapper.ensureInitialized()
                .isValueEqual(this as OptionalIntNode, other));
  }

  @override
  int get hashCode {
    return OptionalIntNodeMapper.ensureInitialized()
        .hashValue(this as OptionalIntNode);
  }
}

extension OptionalIntNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalIntNode, $Out> {
  OptionalIntNodeCopyWith<$R, OptionalIntNode, $Out> get $asOptionalIntNode =>
      $base.as((v, t, t2) => _OptionalIntNodeCopyWithImpl(v, t, t2));
}

abstract class OptionalIntNodeCopyWith<$R, $In extends OptionalIntNode, $Out>
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
  OptionalIntNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalIntNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalIntNode, $Out>
    implements OptionalIntNodeCopyWith<$R, OptionalIntNode, $Out> {
  _OptionalIntNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalIntNode> $mapper =
      OptionalIntNodeMapper.ensureInitialized();
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
  OptionalIntNode $make(CopyWithData data) => OptionalIntNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalIntNodeCopyWith<$R2, OptionalIntNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OptionalIntNodeCopyWithImpl($value, $cast, t);
}
