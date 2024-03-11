// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_compare_to.dart';

class DoubleCompareToMapper extends SubClassMapperBase<DoubleCompareTo> {
  DoubleCompareToMapper._();

  static DoubleCompareToMapper? _instance;
  static DoubleCompareToMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleCompareToMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleCompareTo';

  static int _$id(DoubleCompareTo v) => v.id;
  static const Field<DoubleCompareTo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleCompareTo v) =>
      v.inputs;
  static const Field<DoubleCompareTo, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleCompareTo v) => v.offset;
  static const Field<DoubleCompareTo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleCompareTo v) => v.label;
  static const Field<DoubleCompareTo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleCompareTo v) => v.expanded;
  static const Field<DoubleCompareTo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleCompareTo v) => v.getNode;
  static const Field<DoubleCompareTo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleCompareTo> fields = const {
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
  final dynamic discriminatorValue = 'double_compare_to';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleCompareTo _instantiate(DecodingData data) {
    return DoubleCompareTo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleCompareTo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleCompareTo>(map);
  }

  static DoubleCompareTo fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleCompareTo>(json);
  }
}

mixin DoubleCompareToMappable {
  String toJson() {
    return DoubleCompareToMapper.ensureInitialized()
        .encodeJson<DoubleCompareTo>(this as DoubleCompareTo);
  }

  Map<String, dynamic> toMap() {
    return DoubleCompareToMapper.ensureInitialized()
        .encodeMap<DoubleCompareTo>(this as DoubleCompareTo);
  }

  DoubleCompareToCopyWith<DoubleCompareTo, DoubleCompareTo, DoubleCompareTo>
      get copyWith => _DoubleCompareToCopyWithImpl(
          this as DoubleCompareTo, $identity, $identity);
  @override
  String toString() {
    return DoubleCompareToMapper.ensureInitialized()
        .stringifyValue(this as DoubleCompareTo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleCompareToMapper.ensureInitialized()
                .isValueEqual(this as DoubleCompareTo, other));
  }

  @override
  int get hashCode {
    return DoubleCompareToMapper.ensureInitialized()
        .hashValue(this as DoubleCompareTo);
  }
}

extension DoubleCompareToValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleCompareTo, $Out> {
  DoubleCompareToCopyWith<$R, DoubleCompareTo, $Out> get $asDoubleCompareTo =>
      $base.as((v, t, t2) => _DoubleCompareToCopyWithImpl(v, t, t2));
}

abstract class DoubleCompareToCopyWith<$R, $In extends DoubleCompareTo, $Out>
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
  DoubleCompareToCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleCompareToCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleCompareTo, $Out>
    implements DoubleCompareToCopyWith<$R, DoubleCompareTo, $Out> {
  _DoubleCompareToCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleCompareTo> $mapper =
      DoubleCompareToMapper.ensureInitialized();
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
  DoubleCompareTo $make(CopyWithData data) => DoubleCompareTo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleCompareToCopyWith<$R2, DoubleCompareTo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleCompareToCopyWithImpl($value, $cast, t);
}
