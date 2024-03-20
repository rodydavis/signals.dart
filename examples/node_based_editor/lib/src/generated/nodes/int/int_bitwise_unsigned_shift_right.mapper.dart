// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_unsigned_shift_right.dart';

class IntBitwiseUnsignedShiftRightMapper
    extends SubClassMapperBase<IntBitwiseUnsignedShiftRight> {
  IntBitwiseUnsignedShiftRightMapper._();

  static IntBitwiseUnsignedShiftRightMapper? _instance;
  static IntBitwiseUnsignedShiftRightMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = IntBitwiseUnsignedShiftRightMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseUnsignedShiftRight';

  static int _$id(IntBitwiseUnsignedShiftRight v) => v.id;
  static const Field<IntBitwiseUnsignedShiftRight, int> _f$id =
      Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(
          IntBitwiseUnsignedShiftRight v) =>
      v.inputs;
  static const Field<IntBitwiseUnsignedShiftRight,
      Map<String, NodeInput<dynamic>>> _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseUnsignedShiftRight v) =>
      v.offset;
  static const Field<IntBitwiseUnsignedShiftRight, Signal<NodeOffset>>
      _f$offset = Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseUnsignedShiftRight v) => v.label;
  static const Field<IntBitwiseUnsignedShiftRight, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseUnsignedShiftRight v) => v.expanded;
  static const Field<IntBitwiseUnsignedShiftRight, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseUnsignedShiftRight v) =>
      v.getNode;
  static const Field<IntBitwiseUnsignedShiftRight, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseUnsignedShiftRight> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_unsigned_shift_right';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseUnsignedShiftRight _instantiate(DecodingData data) {
    return IntBitwiseUnsignedShiftRight(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseUnsignedShiftRight fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseUnsignedShiftRight>(map);
  }

  static IntBitwiseUnsignedShiftRight fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseUnsignedShiftRight>(json);
  }
}

mixin IntBitwiseUnsignedShiftRightMappable {
  String toJson() {
    return IntBitwiseUnsignedShiftRightMapper.ensureInitialized()
        .encodeJson<IntBitwiseUnsignedShiftRight>(
            this as IntBitwiseUnsignedShiftRight);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseUnsignedShiftRightMapper.ensureInitialized()
        .encodeMap<IntBitwiseUnsignedShiftRight>(
            this as IntBitwiseUnsignedShiftRight);
  }

  IntBitwiseUnsignedShiftRightCopyWith<IntBitwiseUnsignedShiftRight,
          IntBitwiseUnsignedShiftRight, IntBitwiseUnsignedShiftRight>
      get copyWith => _IntBitwiseUnsignedShiftRightCopyWithImpl(
          this as IntBitwiseUnsignedShiftRight, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseUnsignedShiftRightMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseUnsignedShiftRight);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseUnsignedShiftRightMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseUnsignedShiftRight, other));
  }

  @override
  int get hashCode {
    return IntBitwiseUnsignedShiftRightMapper.ensureInitialized()
        .hashValue(this as IntBitwiseUnsignedShiftRight);
  }
}

extension IntBitwiseUnsignedShiftRightValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseUnsignedShiftRight, $Out> {
  IntBitwiseUnsignedShiftRightCopyWith<$R, IntBitwiseUnsignedShiftRight, $Out>
      get $asIntBitwiseUnsignedShiftRight => $base.as(
          (v, t, t2) => _IntBitwiseUnsignedShiftRightCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseUnsignedShiftRightCopyWith<
    $R,
    $In extends IntBitwiseUnsignedShiftRight,
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
  IntBitwiseUnsignedShiftRightCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntBitwiseUnsignedShiftRightCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseUnsignedShiftRight, $Out>
    implements
        IntBitwiseUnsignedShiftRightCopyWith<$R, IntBitwiseUnsignedShiftRight,
            $Out> {
  _IntBitwiseUnsignedShiftRightCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseUnsignedShiftRight> $mapper =
      IntBitwiseUnsignedShiftRightMapper.ensureInitialized();
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
  IntBitwiseUnsignedShiftRight $make(CopyWithData data) =>
      IntBitwiseUnsignedShiftRight(
          id: data.get(#id, or: $value.id),
          inputs: data.get(#inputs, or: $value.inputs),
          offset: data.get(#offset, or: $value.offset),
          label: data.get(#label, or: $value.label),
          expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseUnsignedShiftRightCopyWith<$R2, IntBitwiseUnsignedShiftRight, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntBitwiseUnsignedShiftRightCopyWithImpl($value, $cast, t);
}
