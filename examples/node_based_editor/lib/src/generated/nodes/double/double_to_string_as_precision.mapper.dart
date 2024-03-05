// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_string_as_precision.dart';

class DoubleToStringAsPrecisionMapper
    extends SubClassMapperBase<DoubleToStringAsPrecision> {
  DoubleToStringAsPrecisionMapper._();

  static DoubleToStringAsPrecisionMapper? _instance;
  static DoubleToStringAsPrecisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = DoubleToStringAsPrecisionMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToStringAsPrecision';

  static int _$id(DoubleToStringAsPrecision v) => v.id;
  static const Field<DoubleToStringAsPrecision, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(
          DoubleToStringAsPrecision v) =>
      v.inputs;
  static const Field<DoubleToStringAsPrecision, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToStringAsPrecision v) => v.offset;
  static const Field<DoubleToStringAsPrecision, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleToStringAsPrecision v) => v.label;
  static const Field<DoubleToStringAsPrecision, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToStringAsPrecision v) => v.expanded;
  static const Field<DoubleToStringAsPrecision, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToStringAsPrecision v) =>
      v.getNode;
  static const Field<DoubleToStringAsPrecision, BaseNode Function(int)>
      _f$getNode = Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToStringAsPrecision> fields = const {
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
  final dynamic discriminatorValue = 'double_to_string_as_precision';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToStringAsPrecision _instantiate(DecodingData data) {
    return DoubleToStringAsPrecision(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToStringAsPrecision fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToStringAsPrecision>(map);
  }

  static DoubleToStringAsPrecision fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToStringAsPrecision>(json);
  }
}

mixin DoubleToStringAsPrecisionMappable {
  String toJson() {
    return DoubleToStringAsPrecisionMapper.ensureInitialized()
        .encodeJson<DoubleToStringAsPrecision>(
            this as DoubleToStringAsPrecision);
  }

  Map<String, dynamic> toMap() {
    return DoubleToStringAsPrecisionMapper.ensureInitialized()
        .encodeMap<DoubleToStringAsPrecision>(
            this as DoubleToStringAsPrecision);
  }

  DoubleToStringAsPrecisionCopyWith<DoubleToStringAsPrecision,
          DoubleToStringAsPrecision, DoubleToStringAsPrecision>
      get copyWith => _DoubleToStringAsPrecisionCopyWithImpl(
          this as DoubleToStringAsPrecision, $identity, $identity);
  @override
  String toString() {
    return DoubleToStringAsPrecisionMapper.ensureInitialized()
        .stringifyValue(this as DoubleToStringAsPrecision);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToStringAsPrecisionMapper.ensureInitialized()
                .isValueEqual(this as DoubleToStringAsPrecision, other));
  }

  @override
  int get hashCode {
    return DoubleToStringAsPrecisionMapper.ensureInitialized()
        .hashValue(this as DoubleToStringAsPrecision);
  }
}

extension DoubleToStringAsPrecisionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToStringAsPrecision, $Out> {
  DoubleToStringAsPrecisionCopyWith<$R, DoubleToStringAsPrecision, $Out>
      get $asDoubleToStringAsPrecision => $base
          .as((v, t, t2) => _DoubleToStringAsPrecisionCopyWithImpl(v, t, t2));
}

abstract class DoubleToStringAsPrecisionCopyWith<
    $R,
    $In extends DoubleToStringAsPrecision,
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
  DoubleToStringAsPrecisionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleToStringAsPrecisionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToStringAsPrecision, $Out>
    implements
        DoubleToStringAsPrecisionCopyWith<$R, DoubleToStringAsPrecision, $Out> {
  _DoubleToStringAsPrecisionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToStringAsPrecision> $mapper =
      DoubleToStringAsPrecisionMapper.ensureInitialized();
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
  DoubleToStringAsPrecision $make(CopyWithData data) =>
      DoubleToStringAsPrecision(
          id: data.get(#id, or: $value.id),
          inputs: data.get(#inputs, or: $value.inputs),
          offset: data.get(#offset, or: $value.offset),
          label: data.get(#label, or: $value.label),
          expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToStringAsPrecisionCopyWith<$R2, DoubleToStringAsPrecision, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleToStringAsPrecisionCopyWithImpl($value, $cast, t);
}
