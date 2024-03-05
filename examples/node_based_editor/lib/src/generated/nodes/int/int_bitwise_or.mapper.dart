// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_bitwise_or.dart';

class IntBitwiseOrMapper extends SubClassMapperBase<IntBitwiseOr> {
  IntBitwiseOrMapper._();

  static IntBitwiseOrMapper? _instance;
  static IntBitwiseOrMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntBitwiseOrMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntBitwiseOr';

  static int _$id(IntBitwiseOr v) => v.id;
  static const Field<IntBitwiseOr, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntBitwiseOr v) => v.inputs;
  static const Field<IntBitwiseOr, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntBitwiseOr v) => v.offset;
  static const Field<IntBitwiseOr, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntBitwiseOr v) => v.label;
  static const Field<IntBitwiseOr, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntBitwiseOr v) => v.expanded;
  static const Field<IntBitwiseOr, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntBitwiseOr v) => v.getNode;
  static const Field<IntBitwiseOr, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntBitwiseOr> fields = const {
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
  final dynamic discriminatorValue = 'int_bitwise_or';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntBitwiseOr _instantiate(DecodingData data) {
    return IntBitwiseOr(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntBitwiseOr fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntBitwiseOr>(map);
  }

  static IntBitwiseOr fromJson(String json) {
    return ensureInitialized().decodeJson<IntBitwiseOr>(json);
  }
}

mixin IntBitwiseOrMappable {
  String toJson() {
    return IntBitwiseOrMapper.ensureInitialized()
        .encodeJson<IntBitwiseOr>(this as IntBitwiseOr);
  }

  Map<String, dynamic> toMap() {
    return IntBitwiseOrMapper.ensureInitialized()
        .encodeMap<IntBitwiseOr>(this as IntBitwiseOr);
  }

  IntBitwiseOrCopyWith<IntBitwiseOr, IntBitwiseOr, IntBitwiseOr> get copyWith =>
      _IntBitwiseOrCopyWithImpl(this as IntBitwiseOr, $identity, $identity);
  @override
  String toString() {
    return IntBitwiseOrMapper.ensureInitialized()
        .stringifyValue(this as IntBitwiseOr);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntBitwiseOrMapper.ensureInitialized()
                .isValueEqual(this as IntBitwiseOr, other));
  }

  @override
  int get hashCode {
    return IntBitwiseOrMapper.ensureInitialized()
        .hashValue(this as IntBitwiseOr);
  }
}

extension IntBitwiseOrValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntBitwiseOr, $Out> {
  IntBitwiseOrCopyWith<$R, IntBitwiseOr, $Out> get $asIntBitwiseOr =>
      $base.as((v, t, t2) => _IntBitwiseOrCopyWithImpl(v, t, t2));
}

abstract class IntBitwiseOrCopyWith<$R, $In extends IntBitwiseOr, $Out>
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
  IntBitwiseOrCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntBitwiseOrCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntBitwiseOr, $Out>
    implements IntBitwiseOrCopyWith<$R, IntBitwiseOr, $Out> {
  _IntBitwiseOrCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntBitwiseOr> $mapper =
      IntBitwiseOrMapper.ensureInitialized();
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
  IntBitwiseOr $make(CopyWithData data) => IntBitwiseOr(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntBitwiseOrCopyWith<$R2, IntBitwiseOr, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntBitwiseOrCopyWithImpl($value, $cast, t);
}
