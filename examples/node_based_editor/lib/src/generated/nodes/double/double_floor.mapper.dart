// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_floor.dart';

class DoubleFloorMapper extends SubClassMapperBase<DoubleFloor> {
  DoubleFloorMapper._();

  static DoubleFloorMapper? _instance;
  static DoubleFloorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleFloorMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleFloor';

  static int _$id(DoubleFloor v) => v.id;
  static const Field<DoubleFloor, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleFloor v) => v.inputs;
  static const Field<DoubleFloor, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleFloor v) => v.offset;
  static const Field<DoubleFloor, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleFloor v) => v.label;
  static const Field<DoubleFloor, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleFloor v) => v.expanded;
  static const Field<DoubleFloor, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleFloor v) => v.getNode;
  static const Field<DoubleFloor, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleFloor> fields = const {
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
  final dynamic discriminatorValue = 'double_floor';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleFloor _instantiate(DecodingData data) {
    return DoubleFloor(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleFloor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleFloor>(map);
  }

  static DoubleFloor fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleFloor>(json);
  }
}

mixin DoubleFloorMappable {
  String toJson() {
    return DoubleFloorMapper.ensureInitialized()
        .encodeJson<DoubleFloor>(this as DoubleFloor);
  }

  Map<String, dynamic> toMap() {
    return DoubleFloorMapper.ensureInitialized()
        .encodeMap<DoubleFloor>(this as DoubleFloor);
  }

  DoubleFloorCopyWith<DoubleFloor, DoubleFloor, DoubleFloor> get copyWith =>
      _DoubleFloorCopyWithImpl(this as DoubleFloor, $identity, $identity);
  @override
  String toString() {
    return DoubleFloorMapper.ensureInitialized()
        .stringifyValue(this as DoubleFloor);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleFloorMapper.ensureInitialized()
                .isValueEqual(this as DoubleFloor, other));
  }

  @override
  int get hashCode {
    return DoubleFloorMapper.ensureInitialized().hashValue(this as DoubleFloor);
  }
}

extension DoubleFloorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleFloor, $Out> {
  DoubleFloorCopyWith<$R, DoubleFloor, $Out> get $asDoubleFloor =>
      $base.as((v, t, t2) => _DoubleFloorCopyWithImpl(v, t, t2));
}

abstract class DoubleFloorCopyWith<$R, $In extends DoubleFloor, $Out>
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
  DoubleFloorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleFloorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleFloor, $Out>
    implements DoubleFloorCopyWith<$R, DoubleFloor, $Out> {
  _DoubleFloorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleFloor> $mapper =
      DoubleFloorMapper.ensureInitialized();
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
  DoubleFloor $make(CopyWithData data) => DoubleFloor(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleFloorCopyWith<$R2, DoubleFloor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleFloorCopyWithImpl($value, $cast, t);
}
