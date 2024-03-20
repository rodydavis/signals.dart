// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_string_as_fixed.dart';

class DoubleToStringAsFixedMapper
    extends SubClassMapperBase<DoubleToStringAsFixed> {
  DoubleToStringAsFixedMapper._();

  static DoubleToStringAsFixedMapper? _instance;
  static DoubleToStringAsFixedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleToStringAsFixedMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToStringAsFixed';

  static int _$id(DoubleToStringAsFixed v) => v.id;
  static const Field<DoubleToStringAsFixed, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleToStringAsFixed v) =>
      v.inputs;
  static const Field<DoubleToStringAsFixed, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToStringAsFixed v) => v.offset;
  static const Field<DoubleToStringAsFixed, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleToStringAsFixed v) => v.label;
  static const Field<DoubleToStringAsFixed, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToStringAsFixed v) => v.expanded;
  static const Field<DoubleToStringAsFixed, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToStringAsFixed v) =>
      v.getNode;
  static const Field<DoubleToStringAsFixed, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToStringAsFixed> fields = const {
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
  final dynamic discriminatorValue = 'double_to_string_as_fixed';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToStringAsFixed _instantiate(DecodingData data) {
    return DoubleToStringAsFixed(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToStringAsFixed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToStringAsFixed>(map);
  }

  static DoubleToStringAsFixed fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToStringAsFixed>(json);
  }
}

mixin DoubleToStringAsFixedMappable {
  String toJson() {
    return DoubleToStringAsFixedMapper.ensureInitialized()
        .encodeJson<DoubleToStringAsFixed>(this as DoubleToStringAsFixed);
  }

  Map<String, dynamic> toMap() {
    return DoubleToStringAsFixedMapper.ensureInitialized()
        .encodeMap<DoubleToStringAsFixed>(this as DoubleToStringAsFixed);
  }

  DoubleToStringAsFixedCopyWith<DoubleToStringAsFixed, DoubleToStringAsFixed,
          DoubleToStringAsFixed>
      get copyWith => _DoubleToStringAsFixedCopyWithImpl(
          this as DoubleToStringAsFixed, $identity, $identity);
  @override
  String toString() {
    return DoubleToStringAsFixedMapper.ensureInitialized()
        .stringifyValue(this as DoubleToStringAsFixed);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToStringAsFixedMapper.ensureInitialized()
                .isValueEqual(this as DoubleToStringAsFixed, other));
  }

  @override
  int get hashCode {
    return DoubleToStringAsFixedMapper.ensureInitialized()
        .hashValue(this as DoubleToStringAsFixed);
  }
}

extension DoubleToStringAsFixedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToStringAsFixed, $Out> {
  DoubleToStringAsFixedCopyWith<$R, DoubleToStringAsFixed, $Out>
      get $asDoubleToStringAsFixed =>
          $base.as((v, t, t2) => _DoubleToStringAsFixedCopyWithImpl(v, t, t2));
}

abstract class DoubleToStringAsFixedCopyWith<
    $R,
    $In extends DoubleToStringAsFixed,
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
  DoubleToStringAsFixedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleToStringAsFixedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToStringAsFixed, $Out>
    implements DoubleToStringAsFixedCopyWith<$R, DoubleToStringAsFixed, $Out> {
  _DoubleToStringAsFixedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToStringAsFixed> $mapper =
      DoubleToStringAsFixedMapper.ensureInitialized();
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
  DoubleToStringAsFixed $make(CopyWithData data) => DoubleToStringAsFixed(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToStringAsFixedCopyWith<$R2, DoubleToStringAsFixed, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleToStringAsFixedCopyWithImpl($value, $cast, t);
}
