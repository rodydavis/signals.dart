// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_compare_to.dart';

class NumCompareToMapper extends SubClassMapperBase<NumCompareTo> {
  NumCompareToMapper._();

  static NumCompareToMapper? _instance;
  static NumCompareToMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumCompareToMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumCompareTo';

  static int _$id(NumCompareTo v) => v.id;
  static const Field<NumCompareTo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumCompareTo v) => v.inputs;
  static const Field<NumCompareTo, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumCompareTo v) => v.offset;
  static const Field<NumCompareTo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumCompareTo v) => v.label;
  static const Field<NumCompareTo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumCompareTo v) => v.expanded;
  static const Field<NumCompareTo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumCompareTo v) => v.getNode;
  static const Field<NumCompareTo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumCompareTo> fields = const {
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
  final dynamic discriminatorValue = 'num_compare_to';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumCompareTo _instantiate(DecodingData data) {
    return NumCompareTo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumCompareTo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumCompareTo>(map);
  }

  static NumCompareTo fromJson(String json) {
    return ensureInitialized().decodeJson<NumCompareTo>(json);
  }
}

mixin NumCompareToMappable {
  String toJson() {
    return NumCompareToMapper.ensureInitialized()
        .encodeJson<NumCompareTo>(this as NumCompareTo);
  }

  Map<String, dynamic> toMap() {
    return NumCompareToMapper.ensureInitialized()
        .encodeMap<NumCompareTo>(this as NumCompareTo);
  }

  NumCompareToCopyWith<NumCompareTo, NumCompareTo, NumCompareTo> get copyWith =>
      _NumCompareToCopyWithImpl(this as NumCompareTo, $identity, $identity);
  @override
  String toString() {
    return NumCompareToMapper.ensureInitialized()
        .stringifyValue(this as NumCompareTo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumCompareToMapper.ensureInitialized()
                .isValueEqual(this as NumCompareTo, other));
  }

  @override
  int get hashCode {
    return NumCompareToMapper.ensureInitialized()
        .hashValue(this as NumCompareTo);
  }
}

extension NumCompareToValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumCompareTo, $Out> {
  NumCompareToCopyWith<$R, NumCompareTo, $Out> get $asNumCompareTo =>
      $base.as((v, t, t2) => _NumCompareToCopyWithImpl(v, t, t2));
}

abstract class NumCompareToCopyWith<$R, $In extends NumCompareTo, $Out>
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
  NumCompareToCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumCompareToCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumCompareTo, $Out>
    implements NumCompareToCopyWith<$R, NumCompareTo, $Out> {
  _NumCompareToCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumCompareTo> $mapper =
      NumCompareToMapper.ensureInitialized();
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
  NumCompareTo $make(CopyWithData data) => NumCompareTo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumCompareToCopyWith<$R2, NumCompareTo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumCompareToCopyWithImpl($value, $cast, t);
}
