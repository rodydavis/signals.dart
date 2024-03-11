// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_shift_left.dart';

class IntBitwiseShiftLeftMapper
    extends SubClassMapperBase<IntBitwiseShiftLeft> {
  IntBitwiseShiftLeftMapper._();

  static IntBitwiseShiftLeftMapper? _instance;
  static IntBitwiseShiftLeftMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntBitwiseShiftLeftMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseShiftLeft';

  static int _$id(IntBitwiseShiftLeft v) => v.id;
  static const Field<IntBitwiseShiftLeft, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntBitwiseShiftLeft v) =>
      v.inputs;
  static const Field<IntBitwiseShiftLeft, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseShiftLeft v) => v.offset;
  static const Field<IntBitwiseShiftLeft, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseShiftLeft v) => v.label;
  static const Field<IntBitwiseShiftLeft, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseShiftLeft v) => v.expanded;
  static const Field<IntBitwiseShiftLeft, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseShiftLeft v) => v.getNode;
  static const Field<IntBitwiseShiftLeft, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseShiftLeft> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_shift_left';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseShiftLeft _instantiate(DecodingData data) {
    return IntBitwiseShiftLeft(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseShiftLeft fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseShiftLeft>(map);
  }

  static IntBitwiseShiftLeft fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseShiftLeft>(json);
  }
}

mixin IntBitwiseShiftLeftMappable {
  String toJson() {
    return IntBitwiseShiftLeftMapper.ensureInitialized()
        .encodeJson<IntBitwiseShiftLeft>(this as IntBitwiseShiftLeft);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseShiftLeftMapper.ensureInitialized()
        .encodeMap<IntBitwiseShiftLeft>(this as IntBitwiseShiftLeft);
  }

  IntBitwiseShiftLeftCopyWith<IntBitwiseShiftLeft, IntBitwiseShiftLeft,
          IntBitwiseShiftLeft>
      get copyWith => _IntBitwiseShiftLeftCopyWithImpl(
          this as IntBitwiseShiftLeft, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseShiftLeftMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseShiftLeft);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseShiftLeftMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseShiftLeft, other));
  }

  @override
  int get hashCode {
    return IntBitwiseShiftLeftMapper.ensureInitialized()
        .hashValue(this as IntBitwiseShiftLeft);
  }
}

extension IntBitwiseShiftLeftValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseShiftLeft, $Out> {
  IntBitwiseShiftLeftCopyWith<$R, IntBitwiseShiftLeft, $Out>
      get $asIntBitwiseShiftLeft =>
          $base.as((v, t, t2) => _IntBitwiseShiftLeftCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseShiftLeftCopyWith<$R, $In extends IntBitwiseShiftLeft,
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
  IntBitwiseShiftLeftCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntBitwiseShiftLeftCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseShiftLeft, $Out>
    implements IntBitwiseShiftLeftCopyWith<$R, IntBitwiseShiftLeft, $Out> {
  _IntBitwiseShiftLeftCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseShiftLeft> $mapper =
      IntBitwiseShiftLeftMapper.ensureInitialized();
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
  IntBitwiseShiftLeft $make(CopyWithData data) => IntBitwiseShiftLeft(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseShiftLeftCopyWith<$R2, IntBitwiseShiftLeft, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntBitwiseShiftLeftCopyWithImpl($value, $cast, t);
}
