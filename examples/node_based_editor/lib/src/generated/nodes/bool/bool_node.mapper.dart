// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bool_node.dart';

class BoolNodeMapper extends SubClassMapperBase<BoolNode> {
  BoolNodeMapper._();

  static BoolNodeMapper? _instance;
  static BoolNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoolNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'BoolNode';

  static int _$id(BoolNode v) => v.id;
  static const Field<BoolNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(BoolNode v) => v.inputs;
  static const Field<BoolNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(BoolNode v) => v.offset;
  static const Field<BoolNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(BoolNode v) => v.label;
  static const Field<BoolNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(BoolNode v) => v.expanded;
  static const Field<BoolNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(BoolNode v) => v.getNode;
  static const Field<BoolNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<BoolNode> fields = const {
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
  final dynamic discriminatorValue = 'bool_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static BoolNode _instantiate(DecodingData data) {
    return BoolNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static BoolNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoolNode>(map);
  }

  static BoolNode fromJson(String json) {
    return ensureInitialized().decodeJson<BoolNode>(json);
  }
}

mixin BoolNodeMappable {
  String toJson() {
    return BoolNodeMapper.ensureInitialized()
        .encodeJson<BoolNode>(this as BoolNode);
  }

  Map<String, dynamic> toMap() {
    return BoolNodeMapper.ensureInitialized()
        .encodeMap<BoolNode>(this as BoolNode);
  }

  BoolNodeCopyWith<BoolNode, BoolNode, BoolNode> get copyWith =>
      _BoolNodeCopyWithImpl(this as BoolNode, $identity, $identity);
  @override
  String toString() {
    return BoolNodeMapper.ensureInitialized().stringifyValue(this as BoolNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BoolNodeMapper.ensureInitialized()
                .isValueEqual(this as BoolNode, other));
  }

  @override
  int get hashCode {
    return BoolNodeMapper.ensureInitialized().hashValue(this as BoolNode);
  }
}

extension BoolNodeValueCopy<$R, $Out> on ObjectCopyWith<$R, BoolNode, $Out> {
  BoolNodeCopyWith<$R, BoolNode, $Out> get $asBoolNode =>
      $base.as((v, t, t2) => _BoolNodeCopyWithImpl(v, t, t2));
}

abstract class BoolNodeCopyWith<$R, $In extends BoolNode, $Out>
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
  BoolNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BoolNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoolNode, $Out>
    implements BoolNodeCopyWith<$R, BoolNode, $Out> {
  _BoolNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoolNode> $mapper =
      BoolNodeMapper.ensureInitialized();
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
  BoolNode $make(CopyWithData data) => BoolNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  BoolNodeCopyWith<$R2, BoolNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BoolNodeCopyWithImpl($value, $cast, t);
}
