// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_is_negative.dart';

class DoubleIsNegativeMapper extends SubClassMapperBase<DoubleIsNegative> {
  DoubleIsNegativeMapper._();

  static DoubleIsNegativeMapper? _instance;
  static DoubleIsNegativeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleIsNegativeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleIsNegative';

  static int _$id(DoubleIsNegative v) => v.id;
  static const Field<DoubleIsNegative, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleIsNegative v) =>
      v.inputs;
  static const Field<DoubleIsNegative, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleIsNegative v) => v.offset;
  static const Field<DoubleIsNegative, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleIsNegative v) => v.label;
  static const Field<DoubleIsNegative, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleIsNegative v) => v.expanded;
  static const Field<DoubleIsNegative, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleIsNegative v) => v.getNode;
  static const Field<DoubleIsNegative, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleIsNegative> fields = const {
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
  final dynamic discriminatorValue = 'double_is_negative';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleIsNegative _instantiate(DecodingData data) {
    return DoubleIsNegative(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleIsNegative fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleIsNegative>(map);
  }

  static DoubleIsNegative fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleIsNegative>(json);
  }
}

mixin DoubleIsNegativeMappable {
  String toJson() {
    return DoubleIsNegativeMapper.ensureInitialized()
        .encodeJson<DoubleIsNegative>(this as DoubleIsNegative);
  }

  Map<String, dynamic> toMap() {
    return DoubleIsNegativeMapper.ensureInitialized()
        .encodeMap<DoubleIsNegative>(this as DoubleIsNegative);
  }

  DoubleIsNegativeCopyWith<DoubleIsNegative, DoubleIsNegative, DoubleIsNegative>
      get copyWith => _DoubleIsNegativeCopyWithImpl(
          this as DoubleIsNegative, $identity, $identity);
  @override
  String toString() {
    return DoubleIsNegativeMapper.ensureInitialized()
        .stringifyValue(this as DoubleIsNegative);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleIsNegativeMapper.ensureInitialized()
                .isValueEqual(this as DoubleIsNegative, other));
  }

  @override
  int get hashCode {
    return DoubleIsNegativeMapper.ensureInitialized()
        .hashValue(this as DoubleIsNegative);
  }
}

extension DoubleIsNegativeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleIsNegative, $Out> {
  DoubleIsNegativeCopyWith<$R, DoubleIsNegative, $Out>
      get $asDoubleIsNegative =>
          $base.as((v, t, t2) => _DoubleIsNegativeCopyWithImpl(v, t, t2));
}

abstract class DoubleIsNegativeCopyWith<$R, $In extends DoubleIsNegative, $Out>
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
  DoubleIsNegativeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleIsNegativeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleIsNegative, $Out>
    implements DoubleIsNegativeCopyWith<$R, DoubleIsNegative, $Out> {
  _DoubleIsNegativeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleIsNegative> $mapper =
      DoubleIsNegativeMapper.ensureInitialized();
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
  DoubleIsNegative $make(CopyWithData data) => DoubleIsNegative(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleIsNegativeCopyWith<$R2, DoubleIsNegative, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleIsNegativeCopyWithImpl($value, $cast, t);
}
