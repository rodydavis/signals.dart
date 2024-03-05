// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_subtract.dart';

class DoubleSubtractMapper extends SubClassMapperBase<DoubleSubtract> {
  DoubleSubtractMapper._();

  static DoubleSubtractMapper? _instance;
  static DoubleSubtractMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleSubtractMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleSubtract';

  static int _$id(DoubleSubtract v) => v.id;
  static const Field<DoubleSubtract, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleSubtract v) => v.inputs;
  static const Field<DoubleSubtract, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleSubtract v) => v.offset;
  static const Field<DoubleSubtract, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleSubtract v) => v.label;
  static const Field<DoubleSubtract, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleSubtract v) => v.expanded;
  static const Field<DoubleSubtract, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleSubtract v) => v.getNode;
  static const Field<DoubleSubtract, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleSubtract> fields = const {
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
  final dynamic discriminatorValue = 'double_subtract';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleSubtract _instantiate(DecodingData data) {
    return DoubleSubtract(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleSubtract fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleSubtract>(map);
  }

  static DoubleSubtract fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleSubtract>(json);
  }
}

mixin DoubleSubtractMappable {
  String toJson() {
    return DoubleSubtractMapper.ensureInitialized()
        .encodeJson<DoubleSubtract>(this as DoubleSubtract);
  }

  Map<String, dynamic> toMap() {
    return DoubleSubtractMapper.ensureInitialized()
        .encodeMap<DoubleSubtract>(this as DoubleSubtract);
  }

  DoubleSubtractCopyWith<DoubleSubtract, DoubleSubtract, DoubleSubtract>
      get copyWith => _DoubleSubtractCopyWithImpl(
          this as DoubleSubtract, $identity, $identity);
  @override
  String toString() {
    return DoubleSubtractMapper.ensureInitialized()
        .stringifyValue(this as DoubleSubtract);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleSubtractMapper.ensureInitialized()
                .isValueEqual(this as DoubleSubtract, other));
  }

  @override
  int get hashCode {
    return DoubleSubtractMapper.ensureInitialized()
        .hashValue(this as DoubleSubtract);
  }
}

extension DoubleSubtractValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleSubtract, $Out> {
  DoubleSubtractCopyWith<$R, DoubleSubtract, $Out> get $asDoubleSubtract =>
      $base.as((v, t, t2) => _DoubleSubtractCopyWithImpl(v, t, t2));
}

abstract class DoubleSubtractCopyWith<$R, $In extends DoubleSubtract, $Out>
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
  DoubleSubtractCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleSubtractCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleSubtract, $Out>
    implements DoubleSubtractCopyWith<$R, DoubleSubtract, $Out> {
  _DoubleSubtractCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleSubtract> $mapper =
      DoubleSubtractMapper.ensureInitialized();
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
  DoubleSubtract $make(CopyWithData data) => DoubleSubtract(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleSubtractCopyWith<$R2, DoubleSubtract, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleSubtractCopyWithImpl($value, $cast, t);
}
