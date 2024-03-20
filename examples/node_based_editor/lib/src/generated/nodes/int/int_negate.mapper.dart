// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_negate.dart';

class IntNegateMapper extends SubClassMapperBase<IntNegate> {
  IntNegateMapper._();

  static IntNegateMapper? _instance;
  static IntNegateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntNegateMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntNegate';

  static int _$id(IntNegate v) => v.id;
  static const Field<IntNegate, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntNegate v) => v.inputs;
  static const Field<IntNegate, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntNegate v) => v.offset;
  static const Field<IntNegate, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntNegate v) => v.label;
  static const Field<IntNegate, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntNegate v) => v.expanded;
  static const Field<IntNegate, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntNegate v) => v.getNode;
  static const Field<IntNegate, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntNegate> fields = const {
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
  final dynamic discriminatorValue = 'int_negate';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntNegate _instantiate(DecodingData data) {
    return IntNegate(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntNegate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntNegate>(map);
  }

  static IntNegate fromJson(String json) {
    return ensureInitialized().decodeJson<IntNegate>(json);
  }
}

mixin IntNegateMappable {
  String toJson() {
    return IntNegateMapper.ensureInitialized()
        .encodeJson<IntNegate>(this as IntNegate);
  }

  Map<String, dynamic> toMap() {
    return IntNegateMapper.ensureInitialized()
        .encodeMap<IntNegate>(this as IntNegate);
  }

  IntNegateCopyWith<IntNegate, IntNegate, IntNegate> get copyWith =>
      _IntNegateCopyWithImpl(this as IntNegate, $identity, $identity);
  @override
  String toString() {
    return IntNegateMapper.ensureInitialized()
        .stringifyValue(this as IntNegate);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntNegateMapper.ensureInitialized()
                .isValueEqual(this as IntNegate, other));
  }

  @override
  int get hashCode {
    return IntNegateMapper.ensureInitialized().hashValue(this as IntNegate);
  }
}

extension IntNegateValueCopy<$R, $Out> on ObjectCopyWith<$R, IntNegate, $Out> {
  IntNegateCopyWith<$R, IntNegate, $Out> get $asIntNegate =>
      $base.as((v, t, t2) => _IntNegateCopyWithImpl(v, t, t2));
}

abstract class IntNegateCopyWith<$R, $In extends IntNegate, $Out>
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
  IntNegateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntNegateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntNegate, $Out>
    implements IntNegateCopyWith<$R, IntNegate, $Out> {
  _IntNegateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntNegate> $mapper =
      IntNegateMapper.ensureInitialized();
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
  IntNegate $make(CopyWithData data) => IntNegate(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntNegateCopyWith<$R2, IntNegate, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntNegateCopyWithImpl($value, $cast, t);
}
