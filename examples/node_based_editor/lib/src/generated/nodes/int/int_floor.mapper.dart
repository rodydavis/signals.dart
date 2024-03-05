// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_floor.dart';

class IntFloorMapper extends SubClassMapperBase<IntFloor> {
  IntFloorMapper._();

  static IntFloorMapper? _instance;
  static IntFloorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntFloorMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntFloor';

  static int _$id(IntFloor v) => v.id;
  static const Field<IntFloor, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntFloor v) => v.inputs;
  static const Field<IntFloor, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntFloor v) => v.offset;
  static const Field<IntFloor, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntFloor v) => v.label;
  static const Field<IntFloor, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntFloor v) => v.expanded;
  static const Field<IntFloor, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntFloor v) => v.getNode;
  static const Field<IntFloor, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntFloor> fields = const {
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
  final dynamic discriminatorValue = 'int_floor';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntFloor _instantiate(DecodingData data) {
    return IntFloor(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntFloor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntFloor>(map);
  }

  static IntFloor fromJson(String json) {
    return ensureInitialized().decodeJson<IntFloor>(json);
  }
}

mixin IntFloorMappable {
  String toJson() {
    return IntFloorMapper.ensureInitialized()
        .encodeJson<IntFloor>(this as IntFloor);
  }

  Map<String, dynamic> toMap() {
    return IntFloorMapper.ensureInitialized()
        .encodeMap<IntFloor>(this as IntFloor);
  }

  IntFloorCopyWith<IntFloor, IntFloor, IntFloor> get copyWith =>
      _IntFloorCopyWithImpl(this as IntFloor, $identity, $identity);
  @override
  String toString() {
    return IntFloorMapper.ensureInitialized().stringifyValue(this as IntFloor);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntFloorMapper.ensureInitialized()
                .isValueEqual(this as IntFloor, other));
  }

  @override
  int get hashCode {
    return IntFloorMapper.ensureInitialized().hashValue(this as IntFloor);
  }
}

extension IntFloorValueCopy<$R, $Out> on ObjectCopyWith<$R, IntFloor, $Out> {
  IntFloorCopyWith<$R, IntFloor, $Out> get $asIntFloor =>
      $base.as((v, t, t2) => _IntFloorCopyWithImpl(v, t, t2));
}

abstract class IntFloorCopyWith<$R, $In extends IntFloor, $Out>
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
  IntFloorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntFloorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntFloor, $Out>
    implements IntFloorCopyWith<$R, IntFloor, $Out> {
  _IntFloorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntFloor> $mapper =
      IntFloorMapper.ensureInitialized();
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
  IntFloor $make(CopyWithData data) => IntFloor(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntFloorCopyWith<$R2, IntFloor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntFloorCopyWithImpl($value, $cast, t);
}
