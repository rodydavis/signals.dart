// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'optional_num_node.dart';

class OptionalNumNodeMapper extends SubClassMapperBase<OptionalNumNode> {
  OptionalNumNodeMapper._();

  static OptionalNumNodeMapper? _instance;
  static OptionalNumNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OptionalNumNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'OptionalNumNode';

  static int _$id(OptionalNumNode v) => v.id;
  static const Field<OptionalNumNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(OptionalNumNode v) =>
      v.inputs;
  static const Field<OptionalNumNode, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(OptionalNumNode v) => v.offset;
  static const Field<OptionalNumNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(OptionalNumNode v) => v.label;
  static const Field<OptionalNumNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(OptionalNumNode v) => v.expanded;
  static const Field<OptionalNumNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(OptionalNumNode v) => v.getNode;
  static const Field<OptionalNumNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<OptionalNumNode> fields = const {
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
  final dynamic discriminatorValue = 'optional_num_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static OptionalNumNode _instantiate(DecodingData data) {
    return OptionalNumNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static OptionalNumNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OptionalNumNode>(map);
  }

  static OptionalNumNode fromJson(String json) {
    return ensureInitialized().decodeJson<OptionalNumNode>(json);
  }
}

mixin OptionalNumNodeMappable {
  String toJson() {
    return OptionalNumNodeMapper.ensureInitialized()
        .encodeJson<OptionalNumNode>(this as OptionalNumNode);
  }

  Map<String, dynamic> toMap() {
    return OptionalNumNodeMapper.ensureInitialized()
        .encodeMap<OptionalNumNode>(this as OptionalNumNode);
  }

  OptionalNumNodeCopyWith<OptionalNumNode, OptionalNumNode, OptionalNumNode>
      get copyWith => _OptionalNumNodeCopyWithImpl(
          this as OptionalNumNode, $identity, $identity);
  @override
  String toString() {
    return OptionalNumNodeMapper.ensureInitialized()
        .stringifyValue(this as OptionalNumNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            OptionalNumNodeMapper.ensureInitialized()
                .isValueEqual(this as OptionalNumNode, other));
  }

  @override
  int get hashCode {
    return OptionalNumNodeMapper.ensureInitialized()
        .hashValue(this as OptionalNumNode);
  }
}

extension OptionalNumNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OptionalNumNode, $Out> {
  OptionalNumNodeCopyWith<$R, OptionalNumNode, $Out> get $asOptionalNumNode =>
      $base.as((v, t, t2) => _OptionalNumNodeCopyWithImpl(v, t, t2));
}

abstract class OptionalNumNodeCopyWith<$R, $In extends OptionalNumNode, $Out>
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
  OptionalNumNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _OptionalNumNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OptionalNumNode, $Out>
    implements OptionalNumNodeCopyWith<$R, OptionalNumNode, $Out> {
  _OptionalNumNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OptionalNumNode> $mapper =
      OptionalNumNodeMapper.ensureInitialized();
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
  OptionalNumNode $make(CopyWithData data) => OptionalNumNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  OptionalNumNodeCopyWith<$R2, OptionalNumNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _OptionalNumNodeCopyWithImpl($value, $cast, t);
}
