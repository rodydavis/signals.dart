// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_string_as_fixed.dart';

class NumToStringAsFixedMapper extends SubClassMapperBase<NumToStringAsFixed> {
  NumToStringAsFixedMapper._();

  static NumToStringAsFixedMapper? _instance;
  static NumToStringAsFixedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumToStringAsFixedMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToStringAsFixed';

  static int _$id(NumToStringAsFixed v) => v.id;
  static const Field<NumToStringAsFixed, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToStringAsFixed v) =>
      v.inputs;
  static const Field<NumToStringAsFixed, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToStringAsFixed v) => v.offset;
  static const Field<NumToStringAsFixed, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToStringAsFixed v) => v.label;
  static const Field<NumToStringAsFixed, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToStringAsFixed v) => v.expanded;
  static const Field<NumToStringAsFixed, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToStringAsFixed v) => v.getNode;
  static const Field<NumToStringAsFixed, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToStringAsFixed> fields = const {
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
  final dynamic discriminatorValue = 'num_to_string_as_fixed';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToStringAsFixed _instantiate(DecodingData data) {
    return NumToStringAsFixed(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToStringAsFixed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToStringAsFixed>(map);
  }

  static NumToStringAsFixed fromJson(String json) {
    return ensureInitialized().decodeJson<NumToStringAsFixed>(json);
  }
}

mixin NumToStringAsFixedMappable {
  String toJson() {
    return NumToStringAsFixedMapper.ensureInitialized()
        .encodeJson<NumToStringAsFixed>(this as NumToStringAsFixed);
  }

  Map<String, dynamic> toMap() {
    return NumToStringAsFixedMapper.ensureInitialized()
        .encodeMap<NumToStringAsFixed>(this as NumToStringAsFixed);
  }

  NumToStringAsFixedCopyWith<NumToStringAsFixed, NumToStringAsFixed,
          NumToStringAsFixed>
      get copyWith => _NumToStringAsFixedCopyWithImpl(
          this as NumToStringAsFixed, $identity, $identity);
  @override
  String toString() {
    return NumToStringAsFixedMapper.ensureInitialized()
        .stringifyValue(this as NumToStringAsFixed);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToStringAsFixedMapper.ensureInitialized()
                .isValueEqual(this as NumToStringAsFixed, other));
  }

  @override
  int get hashCode {
    return NumToStringAsFixedMapper.ensureInitialized()
        .hashValue(this as NumToStringAsFixed);
  }
}

extension NumToStringAsFixedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumToStringAsFixed, $Out> {
  NumToStringAsFixedCopyWith<$R, NumToStringAsFixed, $Out>
      get $asNumToStringAsFixed =>
          $base.as((v, t, t2) => _NumToStringAsFixedCopyWithImpl(v, t, t2));
}

abstract class NumToStringAsFixedCopyWith<$R, $In extends NumToStringAsFixed,
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
  NumToStringAsFixedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumToStringAsFixedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToStringAsFixed, $Out>
    implements NumToStringAsFixedCopyWith<$R, NumToStringAsFixed, $Out> {
  _NumToStringAsFixedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToStringAsFixed> $mapper =
      NumToStringAsFixedMapper.ensureInitialized();
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
  NumToStringAsFixed $make(CopyWithData data) => NumToStringAsFixed(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToStringAsFixedCopyWith<$R2, NumToStringAsFixed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumToStringAsFixedCopyWithImpl($value, $cast, t);
}
