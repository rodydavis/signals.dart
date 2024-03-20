// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_shift_right.dart';

class IntBitwiseShiftRightMapper
    extends SubClassMapperBase<IntBitwiseShiftRight> {
  IntBitwiseShiftRightMapper._();

  static IntBitwiseShiftRightMapper? _instance;
  static IntBitwiseShiftRightMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntBitwiseShiftRightMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseShiftRight';

  static int _$id(IntBitwiseShiftRight v) => v.id;
  static const Field<IntBitwiseShiftRight, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntBitwiseShiftRight v) =>
      v.inputs;
  static const Field<IntBitwiseShiftRight, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseShiftRight v) => v.offset;
  static const Field<IntBitwiseShiftRight, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseShiftRight v) => v.label;
  static const Field<IntBitwiseShiftRight, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseShiftRight v) => v.expanded;
  static const Field<IntBitwiseShiftRight, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseShiftRight v) => v.getNode;
  static const Field<IntBitwiseShiftRight, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseShiftRight> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_shift_right';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseShiftRight _instantiate(DecodingData data) {
    return IntBitwiseShiftRight(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseShiftRight fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseShiftRight>(map);
  }

  static IntBitwiseShiftRight fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseShiftRight>(json);
  }
}

mixin IntBitwiseShiftRightMappable {
  String toJson() {
    return IntBitwiseShiftRightMapper.ensureInitialized()
        .encodeJson<IntBitwiseShiftRight>(this as IntBitwiseShiftRight);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseShiftRightMapper.ensureInitialized()
        .encodeMap<IntBitwiseShiftRight>(this as IntBitwiseShiftRight);
  }

  IntBitwiseShiftRightCopyWith<IntBitwiseShiftRight, IntBitwiseShiftRight,
          IntBitwiseShiftRight>
      get copyWith => _IntBitwiseShiftRightCopyWithImpl(
          this as IntBitwiseShiftRight, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseShiftRightMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseShiftRight);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseShiftRightMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseShiftRight, other));
  }

  @override
  int get hashCode {
    return IntBitwiseShiftRightMapper.ensureInitialized()
        .hashValue(this as IntBitwiseShiftRight);
  }
}

extension IntBitwiseShiftRightValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseShiftRight, $Out> {
  IntBitwiseShiftRightCopyWith<$R, IntBitwiseShiftRight, $Out>
      get $asIntBitwiseShiftRight =>
          $base.as((v, t, t2) => _IntBitwiseShiftRightCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseShiftRightCopyWith<
    $R,
    $In extends IntBitwiseShiftRight,
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
  IntBitwiseShiftRightCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntBitwiseShiftRightCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseShiftRight, $Out>
    implements IntBitwiseShiftRightCopyWith<$R, IntBitwiseShiftRight, $Out> {
  _IntBitwiseShiftRightCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseShiftRight> $mapper =
      IntBitwiseShiftRightMapper.ensureInitialized();
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
  IntBitwiseShiftRight $make(CopyWithData data) => IntBitwiseShiftRight(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseShiftRightCopyWith<$R2, IntBitwiseShiftRight, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntBitwiseShiftRightCopyWithImpl($value, $cast, t);
}
