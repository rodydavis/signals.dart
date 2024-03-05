// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_node.dart';

class DoubleNodeMapper extends SubClassMapperBase<DoubleNode> {
  DoubleNodeMapper._();

  static DoubleNodeMapper? _instance;
  static DoubleNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleNode';

  static int _$id(DoubleNode v) => v.id;
  static const Field<DoubleNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleNode v) => v.inputs;
  static const Field<DoubleNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleNode v) => v.offset;
  static const Field<DoubleNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleNode v) => v.label;
  static const Field<DoubleNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleNode v) => v.expanded;
  static const Field<DoubleNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleNode v) => v.getNode;
  static const Field<DoubleNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleNode> fields = const {
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
  final dynamic discriminatorValue = 'double_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleNode _instantiate(DecodingData data) {
    return DoubleNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleNode>(map);
  }

  static DoubleNode fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleNode>(json);
  }
}

mixin DoubleNodeMappable {
  String toJson() {
    return DoubleNodeMapper.ensureInitialized()
        .encodeJson<DoubleNode>(this as DoubleNode);
  }

  Map<String, dynamic> toMap() {
    return DoubleNodeMapper.ensureInitialized()
        .encodeMap<DoubleNode>(this as DoubleNode);
  }

  DoubleNodeCopyWith<DoubleNode, DoubleNode, DoubleNode> get copyWith =>
      _DoubleNodeCopyWithImpl(this as DoubleNode, $identity, $identity);
  @override
  String toString() {
    return DoubleNodeMapper.ensureInitialized()
        .stringifyValue(this as DoubleNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleNodeMapper.ensureInitialized()
                .isValueEqual(this as DoubleNode, other));
  }

  @override
  int get hashCode {
    return DoubleNodeMapper.ensureInitialized().hashValue(this as DoubleNode);
  }
}

extension DoubleNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleNode, $Out> {
  DoubleNodeCopyWith<$R, DoubleNode, $Out> get $asDoubleNode =>
      $base.as((v, t, t2) => _DoubleNodeCopyWithImpl(v, t, t2));
}

abstract class DoubleNodeCopyWith<$R, $In extends DoubleNode, $Out>
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
  DoubleNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleNode, $Out>
    implements DoubleNodeCopyWith<$R, DoubleNode, $Out> {
  _DoubleNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleNode> $mapper =
      DoubleNodeMapper.ensureInitialized();
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
  DoubleNode $make(CopyWithData data) => DoubleNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleNodeCopyWith<$R2, DoubleNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleNodeCopyWithImpl($value, $cast, t);
}
