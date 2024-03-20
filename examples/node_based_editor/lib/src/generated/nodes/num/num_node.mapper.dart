// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_node.dart';

class NumNodeMapper extends SubClassMapperBase<NumNode> {
  NumNodeMapper._();

  static NumNodeMapper? _instance;
  static NumNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumNode';

  static int _$id(NumNode v) => v.id;
  static const Field<NumNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumNode v) => v.inputs;
  static const Field<NumNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumNode v) => v.offset;
  static const Field<NumNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumNode v) => v.label;
  static const Field<NumNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumNode v) => v.expanded;
  static const Field<NumNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumNode v) => v.getNode;
  static const Field<NumNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumNode> fields = const {
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
  final dynamic discriminatorValue = 'num_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumNode _instantiate(DecodingData data) {
    return NumNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumNode>(map);
  }

  static NumNode fromJson(String json) {
    return ensureInitialized().decodeJson<NumNode>(json);
  }
}

mixin NumNodeMappable {
  String toJson() {
    return NumNodeMapper.ensureInitialized()
        .encodeJson<NumNode>(this as NumNode);
  }

  Map<String, dynamic> toMap() {
    return NumNodeMapper.ensureInitialized()
        .encodeMap<NumNode>(this as NumNode);
  }

  NumNodeCopyWith<NumNode, NumNode, NumNode> get copyWith =>
      _NumNodeCopyWithImpl(this as NumNode, $identity, $identity);
  @override
  String toString() {
    return NumNodeMapper.ensureInitialized().stringifyValue(this as NumNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumNodeMapper.ensureInitialized()
                .isValueEqual(this as NumNode, other));
  }

  @override
  int get hashCode {
    return NumNodeMapper.ensureInitialized().hashValue(this as NumNode);
  }
}

extension NumNodeValueCopy<$R, $Out> on ObjectCopyWith<$R, NumNode, $Out> {
  NumNodeCopyWith<$R, NumNode, $Out> get $asNumNode =>
      $base.as((v, t, t2) => _NumNodeCopyWithImpl(v, t, t2));
}

abstract class NumNodeCopyWith<$R, $In extends NumNode, $Out>
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
  NumNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumNode, $Out>
    implements NumNodeCopyWith<$R, NumNode, $Out> {
  _NumNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumNode> $mapper =
      NumNodeMapper.ensureInitialized();
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
  NumNode $make(CopyWithData data) => NumNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumNodeCopyWith<$R2, NumNode, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NumNodeCopyWithImpl($value, $cast, t);
}
