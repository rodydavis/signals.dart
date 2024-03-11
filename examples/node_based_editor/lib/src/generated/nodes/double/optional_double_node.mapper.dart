// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_double_node.dart';

class OptionalDoubleNodeMapper extends SubClassMapperBase<OptionalDoubleNode> {
  OptionalDoubleNodeMapper._();

  static OptionalDoubleNodeMapper? _instance;
  static OptionalDoubleNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalDoubleNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalDoubleNode';

  static int _$id(OptionalDoubleNode v) => v.id;
  static const Field<OptionalDoubleNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalDoubleNode v) =>
      v.inputs;
  static const Field<OptionalDoubleNode, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalDoubleNode v) => v.offset;
  static const Field<OptionalDoubleNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalDoubleNode v) => v.label;
  static const Field<OptionalDoubleNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalDoubleNode v) => v.expanded;
  static const Field<OptionalDoubleNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalDoubleNode v) => v.getNode;
  static const Field<OptionalDoubleNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalDoubleNode> fields = const {
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
  final dynamic discriminatorValue = 'optional_double_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalDoubleNode _instantiate(DecodingData data) {
    return OptionalDoubleNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalDoubleNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalDoubleNode>(map);
  }

  static OptionalDoubleNode fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalDoubleNode>(json);
  }
}

mixin OptionalDoubleNodeMappable {
  String toJson() {
    return OptionalDoubleNodeMapper.ensureInitialized()
        .encodeJson<OptionalDoubleNode>(this as OptionalDoubleNode);
  }

  Map<String, dynamic> toMap() {
    return OptionalDoubleNodeMapper.ensureInitialized()
        .encodeMap<OptionalDoubleNode>(this as OptionalDoubleNode);
  }

  OptionalDoubleNodeCopyWith<OptionalDoubleNode, OptionalDoubleNode,
          OptionalDoubleNode>
      get copyWith => _OptionalDoubleNodeCopyWithImpl(
          this as OptionalDoubleNode, $identity, $identity);
  @override
  String toString() {
    return OptionalDoubleNodeMapper.ensureInitialized()
        .stringifyValue(this as OptionalDoubleNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalDoubleNodeMapper.ensureInitialized()
                .isValueEqual(this as OptionalDoubleNode, other));
  }

  @override
  int get hashCode {
    return OptionalDoubleNodeMapper.ensureInitialized()
        .hashValue(this as OptionalDoubleNode);
  }
}

extension OptionalDoubleNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalDoubleNode, $Out> {
  OptionalDoubleNodeCopyWith<$R, OptionalDoubleNode, $Out>
      get $asOptionalDoubleNode =>
          $base.as((v, t, t2) => _OptionalDoubleNodeCopyWithImpl(v, t, t2));
}

abstract class OptionalDoubleNodeCopyWith<$R, $In extends OptionalDoubleNode,
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
  OptionalDoubleNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalDoubleNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalDoubleNode, $Out>
    implements OptionalDoubleNodeCopyWith<$R, OptionalDoubleNode, $Out> {
  _OptionalDoubleNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalDoubleNode> $mapper =
      OptionalDoubleNodeMapper.ensureInitialized();
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
  OptionalDoubleNode $make(CopyWithData data) => OptionalDoubleNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalDoubleNodeCopyWith<$R2, OptionalDoubleNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OptionalDoubleNodeCopyWithImpl($value, $cast, t);
}
