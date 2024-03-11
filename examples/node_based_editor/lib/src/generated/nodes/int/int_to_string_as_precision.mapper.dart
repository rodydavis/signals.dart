// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_string_as_precision.dart';

class IntToStringAsPrecisionMapper
    extends SubClassMapperBase<IntToStringAsPrecision> {
  IntToStringAsPrecisionMapper._();

  static IntToStringAsPrecisionMapper? _instance;
  static IntToStringAsPrecisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToStringAsPrecisionMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToStringAsPrecision';

  static int _$id(IntToStringAsPrecision v) => v.id;
  static const Field<IntToStringAsPrecision, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToStringAsPrecision v) =>
      v.inputs;
  static const Field<IntToStringAsPrecision, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToStringAsPrecision v) => v.offset;
  static const Field<IntToStringAsPrecision, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToStringAsPrecision v) => v.label;
  static const Field<IntToStringAsPrecision, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToStringAsPrecision v) => v.expanded;
  static const Field<IntToStringAsPrecision, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToStringAsPrecision v) =>
      v.getNode;
  static const Field<IntToStringAsPrecision, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToStringAsPrecision> fields = const {
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
  final dynamic discriminatorValue = 'int_to_string_as_precision';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToStringAsPrecision _instantiate(DecodingData data) {
    return IntToStringAsPrecision(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToStringAsPrecision fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToStringAsPrecision>(map);
  }

  static IntToStringAsPrecision fromJson(String json) {
    return ensureInitialized().decodeJson<IntToStringAsPrecision>(json);
  }
}

mixin IntToStringAsPrecisionMappable {
  String toJson() {
    return IntToStringAsPrecisionMapper.ensureInitialized()
        .encodeJson<IntToStringAsPrecision>(this as IntToStringAsPrecision);
  }

  Map<String, dynamic> toMap() {
    return IntToStringAsPrecisionMapper.ensureInitialized()
        .encodeMap<IntToStringAsPrecision>(this as IntToStringAsPrecision);
  }

  IntToStringAsPrecisionCopyWith<IntToStringAsPrecision, IntToStringAsPrecision,
          IntToStringAsPrecision>
      get copyWith => _IntToStringAsPrecisionCopyWithImpl(
          this as IntToStringAsPrecision, $identity, $identity);
  @override
  String toString() {
    return IntToStringAsPrecisionMapper.ensureInitialized()
        .stringifyValue(this as IntToStringAsPrecision);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToStringAsPrecisionMapper.ensureInitialized()
                .isValueEqual(this as IntToStringAsPrecision, other));
  }

  @override
  int get hashCode {
    return IntToStringAsPrecisionMapper.ensureInitialized()
        .hashValue(this as IntToStringAsPrecision);
  }
}

extension IntToStringAsPrecisionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToStringAsPrecision, $Out> {
  IntToStringAsPrecisionCopyWith<$R, IntToStringAsPrecision, $Out>
      get $asIntToStringAsPrecision =>
          $base.as((v, t, t2) => _IntToStringAsPrecisionCopyWithImpl(v, t, t2));
}

abstract class IntToStringAsPrecisionCopyWith<
    $R,
    $In extends IntToStringAsPrecision,
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
  IntToStringAsPrecisionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntToStringAsPrecisionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToStringAsPrecision, $Out>
    implements
        IntToStringAsPrecisionCopyWith<$R, IntToStringAsPrecision, $Out> {
  _IntToStringAsPrecisionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToStringAsPrecision> $mapper =
      IntToStringAsPrecisionMapper.ensureInitialized();
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
  IntToStringAsPrecision $make(CopyWithData data) => IntToStringAsPrecision(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToStringAsPrecisionCopyWith<$R2, IntToStringAsPrecision, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntToStringAsPrecisionCopyWithImpl($value, $cast, t);
}
