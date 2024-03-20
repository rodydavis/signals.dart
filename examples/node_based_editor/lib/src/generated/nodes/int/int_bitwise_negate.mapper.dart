// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_negate.dart';

class IntBitwiseNegateMapper extends SubClassMapperBase<IntBitwiseNegate> {
  IntBitwiseNegateMapper._();

  static IntBitwiseNegateMapper? _instance;
  static IntBitwiseNegateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntBitwiseNegateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseNegate';

  static int _$id(IntBitwiseNegate v) => v.id;
  static const Field<IntBitwiseNegate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntBitwiseNegate v) =>
      v.inputs;
  static const Field<IntBitwiseNegate, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseNegate v) => v.offset;
  static const Field<IntBitwiseNegate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseNegate v) => v.label;
  static const Field<IntBitwiseNegate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseNegate v) => v.expanded;
  static const Field<IntBitwiseNegate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseNegate v) => v.getNode;
  static const Field<IntBitwiseNegate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseNegate> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_negate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseNegate _instantiate(DecodingData data) {
    return IntBitwiseNegate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseNegate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseNegate>(map);
  }

  static IntBitwiseNegate fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseNegate>(json);
  }
}

mixin IntBitwiseNegateMappable {
  String toJson() {
    return IntBitwiseNegateMapper.ensureInitialized()
        .encodeJson<IntBitwiseNegate>(this as IntBitwiseNegate);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseNegateMapper.ensureInitialized()
        .encodeMap<IntBitwiseNegate>(this as IntBitwiseNegate);
  }

  IntBitwiseNegateCopyWith<IntBitwiseNegate, IntBitwiseNegate, IntBitwiseNegate>
      get copyWith => _IntBitwiseNegateCopyWithImpl(
          this as IntBitwiseNegate, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseNegateMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseNegate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseNegateMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseNegate, other));
  }

  @override
  int get hashCode {
    return IntBitwiseNegateMapper.ensureInitialized()
        .hashValue(this as IntBitwiseNegate);
  }
}

extension IntBitwiseNegateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseNegate, $Out> {
  IntBitwiseNegateCopyWith<$R, IntBitwiseNegate, $Out>
      get $asIntBitwiseNegate =>
          $base.as((v, t, t2) => _IntBitwiseNegateCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseNegateCopyWith<$R, $In extends IntBitwiseNegate, $Out>
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
  IntBitwiseNegateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntBitwiseNegateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseNegate, $Out>
    implements IntBitwiseNegateCopyWith<$R, IntBitwiseNegate, $Out> {
  _IntBitwiseNegateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseNegate> $mapper =
      IntBitwiseNegateMapper.ensureInitialized();
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
  IntBitwiseNegate $make(CopyWithData data) => IntBitwiseNegate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseNegateCopyWith<$R2, IntBitwiseNegate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntBitwiseNegateCopyWithImpl($value, $cast, t);
}
