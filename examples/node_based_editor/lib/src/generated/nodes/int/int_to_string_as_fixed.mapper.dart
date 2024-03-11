// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_string_as_fixed.dart';

class IntToStringAsFixedMapper extends SubClassMapperBase<IntToStringAsFixed> {
  IntToStringAsFixedMapper._();

  static IntToStringAsFixedMapper? _instance;
  static IntToStringAsFixedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToStringAsFixedMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToStringAsFixed';

  static int _$id(IntToStringAsFixed v) => v.id;
  static const Field<IntToStringAsFixed, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToStringAsFixed v) =>
      v.inputs;
  static const Field<IntToStringAsFixed, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToStringAsFixed v) => v.offset;
  static const Field<IntToStringAsFixed, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToStringAsFixed v) => v.label;
  static const Field<IntToStringAsFixed, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToStringAsFixed v) => v.expanded;
  static const Field<IntToStringAsFixed, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToStringAsFixed v) => v.getNode;
  static const Field<IntToStringAsFixed, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToStringAsFixed> fields = const {
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
  final dynamic discriminatorValue = 'int_to_string_as_fixed';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToStringAsFixed _instantiate(DecodingData data) {
    return IntToStringAsFixed(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToStringAsFixed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToStringAsFixed>(map);
  }

  static IntToStringAsFixed fromJson(String json) {
    return ensureInitialized().decodeJson<IntToStringAsFixed>(json);
  }
}

mixin IntToStringAsFixedMappable {
  String toJson() {
    return IntToStringAsFixedMapper.ensureInitialized()
        .encodeJson<IntToStringAsFixed>(this as IntToStringAsFixed);
  }

  Map<String, dynamic> toMap() {
    return IntToStringAsFixedMapper.ensureInitialized()
        .encodeMap<IntToStringAsFixed>(this as IntToStringAsFixed);
  }

  IntToStringAsFixedCopyWith<IntToStringAsFixed, IntToStringAsFixed,
          IntToStringAsFixed>
      get copyWith => _IntToStringAsFixedCopyWithImpl(
          this as IntToStringAsFixed, $identity, $identity);
  @override
  String toString() {
    return IntToStringAsFixedMapper.ensureInitialized()
        .stringifyValue(this as IntToStringAsFixed);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToStringAsFixedMapper.ensureInitialized()
                .isValueEqual(this as IntToStringAsFixed, other));
  }

  @override
  int get hashCode {
    return IntToStringAsFixedMapper.ensureInitialized()
        .hashValue(this as IntToStringAsFixed);
  }
}

extension IntToStringAsFixedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToStringAsFixed, $Out> {
  IntToStringAsFixedCopyWith<$R, IntToStringAsFixed, $Out>
      get $asIntToStringAsFixed =>
          $base.as((v, t, t2) => _IntToStringAsFixedCopyWithImpl(v, t, t2));
}

abstract class IntToStringAsFixedCopyWith<$R, $In extends IntToStringAsFixed,
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
  IntToStringAsFixedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntToStringAsFixedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToStringAsFixed, $Out>
    implements IntToStringAsFixedCopyWith<$R, IntToStringAsFixed, $Out> {
  _IntToStringAsFixedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToStringAsFixed> $mapper =
      IntToStringAsFixedMapper.ensureInitialized();
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
  IntToStringAsFixed $make(CopyWithData data) => IntToStringAsFixed(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToStringAsFixedCopyWith<$R2, IntToStringAsFixed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToStringAsFixedCopyWithImpl($value, $cast, t);
}
