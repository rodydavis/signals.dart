// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_truncating_division.dart';

class IntTruncatingDivisionMapper
    extends SubClassMapperBase<IntTruncatingDivision> {
  IntTruncatingDivisionMapper._();

  static IntTruncatingDivisionMapper? _instance;
  static IntTruncatingDivisionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntTruncatingDivisionMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntTruncatingDivision';

  static int _$id(IntTruncatingDivision v) => v.id;
  static const Field<IntTruncatingDivision, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntTruncatingDivision v) =>
      v.inputs;
  static const Field<IntTruncatingDivision, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntTruncatingDivision v) => v.offset;
  static const Field<IntTruncatingDivision, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntTruncatingDivision v) => v.label;
  static const Field<IntTruncatingDivision, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntTruncatingDivision v) => v.expanded;
  static const Field<IntTruncatingDivision, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntTruncatingDivision v) =>
      v.getNode;
  static const Field<IntTruncatingDivision, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntTruncatingDivision> fields = const {
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
  final dynamic discriminatorValue = 'int_truncating_division';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntTruncatingDivision _instantiate(DecodingData data) {
    return IntTruncatingDivision(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntTruncatingDivision fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntTruncatingDivision>(map);
  }

  static IntTruncatingDivision fromJson(String json) {
    return ensureInitialized().decodeJson<IntTruncatingDivision>(json);
  }
}

mixin IntTruncatingDivisionMappable {
  String toJson() {
    return IntTruncatingDivisionMapper.ensureInitialized()
        .encodeJson<IntTruncatingDivision>(this as IntTruncatingDivision);
  }

  Map<String, dynamic> toMap() {
    return IntTruncatingDivisionMapper.ensureInitialized()
        .encodeMap<IntTruncatingDivision>(this as IntTruncatingDivision);
  }

  IntTruncatingDivisionCopyWith<IntTruncatingDivision, IntTruncatingDivision,
          IntTruncatingDivision>
      get copyWith => _IntTruncatingDivisionCopyWithImpl(
          this as IntTruncatingDivision, $identity, $identity);
  @override
  String toString() {
    return IntTruncatingDivisionMapper.ensureInitialized()
        .stringifyValue(this as IntTruncatingDivision);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntTruncatingDivisionMapper.ensureInitialized()
                .isValueEqual(this as IntTruncatingDivision, other));
  }

  @override
  int get hashCode {
    return IntTruncatingDivisionMapper.ensureInitialized()
        .hashValue(this as IntTruncatingDivision);
  }
}

extension IntTruncatingDivisionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntTruncatingDivision, $Out> {
  IntTruncatingDivisionCopyWith<$R, IntTruncatingDivision, $Out>
      get $asIntTruncatingDivision =>
          $base.as((v, t, t2) => _IntTruncatingDivisionCopyWithImpl(v, t, t2));
}

abstract class IntTruncatingDivisionCopyWith<
    $R,
    $In extends IntTruncatingDivision,
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
  IntTruncatingDivisionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntTruncatingDivisionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntTruncatingDivision, $Out>
    implements IntTruncatingDivisionCopyWith<$R, IntTruncatingDivision, $Out> {
  _IntTruncatingDivisionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntTruncatingDivision> $mapper =
      IntTruncatingDivisionMapper.ensureInitialized();
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
  IntTruncatingDivision $make(CopyWithData data) => IntTruncatingDivision(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntTruncatingDivisionCopyWith<$R2, IntTruncatingDivision, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _IntTruncatingDivisionCopyWithImpl($value, $cast, t);
}
