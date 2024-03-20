// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_string_as_precision.dart';

class NumToStringAsPrecisionMapper
    extends SubClassMapperBase<NumToStringAsPrecision> {
  NumToStringAsPrecisionMapper._();

  static NumToStringAsPrecisionMapper? _instance;
  static NumToStringAsPrecisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumToStringAsPrecisionMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToStringAsPrecision';

  static int _$id(NumToStringAsPrecision v) => v.id;
  static const Field<NumToStringAsPrecision, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToStringAsPrecision v) =>
      v.inputs;
  static const Field<NumToStringAsPrecision, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToStringAsPrecision v) => v.offset;
  static const Field<NumToStringAsPrecision, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToStringAsPrecision v) => v.label;
  static const Field<NumToStringAsPrecision, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToStringAsPrecision v) => v.expanded;
  static const Field<NumToStringAsPrecision, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToStringAsPrecision v) =>
      v.getNode;
  static const Field<NumToStringAsPrecision, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToStringAsPrecision> fields = const {
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
  final dynamic discriminatorValue = 'num_to_string_as_precision';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToStringAsPrecision _instantiate(DecodingData data) {
    return NumToStringAsPrecision(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToStringAsPrecision fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToStringAsPrecision>(map);
  }

  static NumToStringAsPrecision fromJson(String json) {
    return ensureInitialized().decodeJson<NumToStringAsPrecision>(json);
  }
}

mixin NumToStringAsPrecisionMappable {
  String toJson() {
    return NumToStringAsPrecisionMapper.ensureInitialized()
        .encodeJson<NumToStringAsPrecision>(this as NumToStringAsPrecision);
  }

  Map<String, dynamic> toMap() {
    return NumToStringAsPrecisionMapper.ensureInitialized()
        .encodeMap<NumToStringAsPrecision>(this as NumToStringAsPrecision);
  }

  NumToStringAsPrecisionCopyWith<NumToStringAsPrecision, NumToStringAsPrecision,
          NumToStringAsPrecision>
      get copyWith => _NumToStringAsPrecisionCopyWithImpl(
          this as NumToStringAsPrecision, $identity, $identity);
  @override
  String toString() {
    return NumToStringAsPrecisionMapper.ensureInitialized()
        .stringifyValue(this as NumToStringAsPrecision);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToStringAsPrecisionMapper.ensureInitialized()
                .isValueEqual(this as NumToStringAsPrecision, other));
  }

  @override
  int get hashCode {
    return NumToStringAsPrecisionMapper.ensureInitialized()
        .hashValue(this as NumToStringAsPrecision);
  }
}

extension NumToStringAsPrecisionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumToStringAsPrecision, $Out> {
  NumToStringAsPrecisionCopyWith<$R, NumToStringAsPrecision, $Out>
      get $asNumToStringAsPrecision =>
          $base.as((v, t, t2) => _NumToStringAsPrecisionCopyWithImpl(v, t, t2));
}

abstract class NumToStringAsPrecisionCopyWith<
    $R,
    $In extends NumToStringAsPrecision,
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
  NumToStringAsPrecisionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumToStringAsPrecisionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToStringAsPrecision, $Out>
    implements
        NumToStringAsPrecisionCopyWith<$R, NumToStringAsPrecision, $Out> {
  _NumToStringAsPrecisionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToStringAsPrecision> $mapper =
      NumToStringAsPrecisionMapper.ensureInitialized();
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
  NumToStringAsPrecision $make(CopyWithData data) => NumToStringAsPrecision(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToStringAsPrecisionCopyWith<$R2, NumToStringAsPrecision, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _NumToStringAsPrecisionCopyWithImpl($value, $cast, t);
}
