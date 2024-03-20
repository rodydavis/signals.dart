// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_floor.dart';

class NumFloorMapper extends SubClassMapperBase<NumFloor> {
  NumFloorMapper._();

  static NumFloorMapper? _instance;
  static NumFloorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumFloorMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumFloor';

  static int _$id(NumFloor v) => v.id;
  static const Field<NumFloor, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumFloor v) => v.inputs;
  static const Field<NumFloor, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumFloor v) => v.offset;
  static const Field<NumFloor, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumFloor v) => v.label;
  static const Field<NumFloor, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumFloor v) => v.expanded;
  static const Field<NumFloor, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumFloor v) => v.getNode;
  static const Field<NumFloor, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumFloor> fields = const {
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
  final dynamic discriminatorValue = 'num_floor';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumFloor _instantiate(DecodingData data) {
    return NumFloor(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumFloor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumFloor>(map);
  }

  static NumFloor fromJson(String json) {
    return ensureInitialized().decodeJson<NumFloor>(json);
  }
}

mixin NumFloorMappable {
  String toJson() {
    return NumFloorMapper.ensureInitialized()
        .encodeJson<NumFloor>(this as NumFloor);
  }

  Map<String, dynamic> toMap() {
    return NumFloorMapper.ensureInitialized()
        .encodeMap<NumFloor>(this as NumFloor);
  }

  NumFloorCopyWith<NumFloor, NumFloor, NumFloor> get copyWith =>
      _NumFloorCopyWithImpl(this as NumFloor, $identity, $identity);
  @override
  String toString() {
    return NumFloorMapper.ensureInitialized().stringifyValue(this as NumFloor);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumFloorMapper.ensureInitialized()
                .isValueEqual(this as NumFloor, other));
  }

  @override
  int get hashCode {
    return NumFloorMapper.ensureInitialized().hashValue(this as NumFloor);
  }
}

extension NumFloorValueCopy<$R, $Out> on ObjectCopyWith<$R, NumFloor, $Out> {
  NumFloorCopyWith<$R, NumFloor, $Out> get $asNumFloor =>
      $base.as((v, t, t2) => _NumFloorCopyWithImpl(v, t, t2));
}

abstract class NumFloorCopyWith<$R, $In extends NumFloor, $Out>
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
  NumFloorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumFloorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumFloor, $Out>
    implements NumFloorCopyWith<$R, NumFloor, $Out> {
  _NumFloorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumFloor> $mapper =
      NumFloorMapper.ensureInitialized();
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
  NumFloor $make(CopyWithData data) => NumFloor(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumFloorCopyWith<$R2, NumFloor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumFloorCopyWithImpl($value, $cast, t);
}
