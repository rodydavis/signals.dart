// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_exclusive_or.dart';

class IntBitwiseExclusiveOrMapper
    extends SubClassMapperBase<IntBitwiseExclusiveOr> {
  IntBitwiseExclusiveOrMapper._();

  static IntBitwiseExclusiveOrMapper? _instance;
  static IntBitwiseExclusiveOrMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntBitwiseExclusiveOrMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseExclusiveOr';

  static int _$id(IntBitwiseExclusiveOr v) => v.id;
  static const Field<IntBitwiseExclusiveOr, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntBitwiseExclusiveOr v) =>
      v.inputs;
  static const Field<IntBitwiseExclusiveOr, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseExclusiveOr v) => v.offset;
  static const Field<IntBitwiseExclusiveOr, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseExclusiveOr v) => v.label;
  static const Field<IntBitwiseExclusiveOr, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseExclusiveOr v) => v.expanded;
  static const Field<IntBitwiseExclusiveOr, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseExclusiveOr v) =>
      v.getNode;
  static const Field<IntBitwiseExclusiveOr, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseExclusiveOr> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_exclusive_or';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseExclusiveOr _instantiate(DecodingData data) {
    return IntBitwiseExclusiveOr(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseExclusiveOr fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseExclusiveOr>(map);
  }

  static IntBitwiseExclusiveOr fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseExclusiveOr>(json);
  }
}

mixin IntBitwiseExclusiveOrMappable {
  String toJson() {
    return IntBitwiseExclusiveOrMapper.ensureInitialized()
        .encodeJson<IntBitwiseExclusiveOr>(this as IntBitwiseExclusiveOr);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseExclusiveOrMapper.ensureInitialized()
        .encodeMap<IntBitwiseExclusiveOr>(this as IntBitwiseExclusiveOr);
  }

  IntBitwiseExclusiveOrCopyWith<IntBitwiseExclusiveOr, IntBitwiseExclusiveOr,
          IntBitwiseExclusiveOr>
      get copyWith => _IntBitwiseExclusiveOrCopyWithImpl(
          this as IntBitwiseExclusiveOr, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseExclusiveOrMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseExclusiveOr);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseExclusiveOrMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseExclusiveOr, other));
  }

  @override
  int get hashCode {
    return IntBitwiseExclusiveOrMapper.ensureInitialized()
        .hashValue(this as IntBitwiseExclusiveOr);
  }
}

extension IntBitwiseExclusiveOrValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseExclusiveOr, $Out> {
  IntBitwiseExclusiveOrCopyWith<$R, IntBitwiseExclusiveOr, $Out>
      get $asIntBitwiseExclusiveOr =>
          $base.as((v, t, t2) => _IntBitwiseExclusiveOrCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseExclusiveOrCopyWith<
    $R,
    $In extends IntBitwiseExclusiveOr,
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
  IntBitwiseExclusiveOrCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntBitwiseExclusiveOrCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseExclusiveOr, $Out>
    implements IntBitwiseExclusiveOrCopyWith<$R, IntBitwiseExclusiveOr, $Out> {
  _IntBitwiseExclusiveOrCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseExclusiveOr> $mapper =
      IntBitwiseExclusiveOrMapper.ensureInitialized();
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
  IntBitwiseExclusiveOr $make(CopyWithData data) => IntBitwiseExclusiveOr(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseExclusiveOrCopyWith<$R2, IntBitwiseExclusiveOr, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntBitwiseExclusiveOrCopyWithImpl($value, $cast, t);
}
