// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_min_positive.dart';

class DoubleMinPositiveMapper extends SubClassMapperBase<DoubleMinPositive> {
  DoubleMinPositiveMapper._();

  static DoubleMinPositiveMapper? _instance;
  static DoubleMinPositiveMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleMinPositiveMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleMinPositive';

  static int _$id(DoubleMinPositive v) => v.id;
  static const Field<DoubleMinPositive, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleMinPositive v) =>
      v.inputs;
  static const Field<DoubleMinPositive, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleMinPositive v) => v.offset;
  static const Field<DoubleMinPositive, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleMinPositive v) => v.label;
  static const Field<DoubleMinPositive, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleMinPositive v) => v.expanded;
  static const Field<DoubleMinPositive, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleMinPositive v) => v.getNode;
  static const Field<DoubleMinPositive, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleMinPositive> fields = const {
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
  final dynamic discriminatorValue = 'double_min_positive';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleMinPositive _instantiate(DecodingData data) {
    return DoubleMinPositive(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleMinPositive fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleMinPositive>(map);
  }

  static DoubleMinPositive fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleMinPositive>(json);
  }
}

mixin DoubleMinPositiveMappable {
  String toJson() {
    return DoubleMinPositiveMapper.ensureInitialized()
        .encodeJson<DoubleMinPositive>(this as DoubleMinPositive);
  }

  Map<String, dynamic> toMap() {
    return DoubleMinPositiveMapper.ensureInitialized()
        .encodeMap<DoubleMinPositive>(this as DoubleMinPositive);
  }

  DoubleMinPositiveCopyWith<DoubleMinPositive, DoubleMinPositive,
          DoubleMinPositive>
      get copyWith => _DoubleMinPositiveCopyWithImpl(
          this as DoubleMinPositive, $identity, $identity);
  @override
  String toString() {
    return DoubleMinPositiveMapper.ensureInitialized()
        .stringifyValue(this as DoubleMinPositive);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleMinPositiveMapper.ensureInitialized()
                .isValueEqual(this as DoubleMinPositive, other));
  }

  @override
  int get hashCode {
    return DoubleMinPositiveMapper.ensureInitialized()
        .hashValue(this as DoubleMinPositive);
  }
}

extension DoubleMinPositiveValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleMinPositive, $Out> {
  DoubleMinPositiveCopyWith<$R, DoubleMinPositive, $Out>
      get $asDoubleMinPositive =>
          $base.as((v, t, t2) => _DoubleMinPositiveCopyWithImpl(v, t, t2));
}

abstract class DoubleMinPositiveCopyWith<$R, $In extends DoubleMinPositive,
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
  DoubleMinPositiveCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleMinPositiveCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleMinPositive, $Out>
    implements DoubleMinPositiveCopyWith<$R, DoubleMinPositive, $Out> {
  _DoubleMinPositiveCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleMinPositive> $mapper =
      DoubleMinPositiveMapper.ensureInitialized();
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
  DoubleMinPositive $make(CopyWithData data) => DoubleMinPositive(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleMinPositiveCopyWith<$R2, DoubleMinPositive, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleMinPositiveCopyWithImpl($value, $cast, t);
}
