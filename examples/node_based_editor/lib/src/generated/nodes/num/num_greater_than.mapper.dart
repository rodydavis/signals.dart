// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_greater_than.dart';

class NumGreaterThanMapper extends SubClassMapperBase<NumGreaterThan> {
  NumGreaterThanMapper._();

  static NumGreaterThanMapper? _instance;
  static NumGreaterThanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumGreaterThanMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumGreaterThan';

  static int _$id(NumGreaterThan v) => v.id;
  static const Field<NumGreaterThan, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumGreaterThan v) => v.inputs;
  static const Field<NumGreaterThan, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumGreaterThan v) => v.offset;
  static const Field<NumGreaterThan, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumGreaterThan v) => v.label;
  static const Field<NumGreaterThan, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumGreaterThan v) => v.expanded;
  static const Field<NumGreaterThan, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumGreaterThan v) => v.getNode;
  static const Field<NumGreaterThan, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumGreaterThan> fields = const {
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
  final dynamic discriminatorValue = 'num_greater_than';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumGreaterThan _instantiate(DecodingData data) {
    return NumGreaterThan(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumGreaterThan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumGreaterThan>(map);
  }

  static NumGreaterThan fromJson(String json) {
    return ensureInitialized().decodeJson<NumGreaterThan>(json);
  }
}

mixin NumGreaterThanMappable {
  String toJson() {
    return NumGreaterThanMapper.ensureInitialized()
        .encodeJson<NumGreaterThan>(this as NumGreaterThan);
  }

  Map<String, dynamic> toMap() {
    return NumGreaterThanMapper.ensureInitialized()
        .encodeMap<NumGreaterThan>(this as NumGreaterThan);
  }

  NumGreaterThanCopyWith<NumGreaterThan, NumGreaterThan, NumGreaterThan>
      get copyWith => _NumGreaterThanCopyWithImpl(
          this as NumGreaterThan, $identity, $identity);
  @override
  String toString() {
    return NumGreaterThanMapper.ensureInitialized()
        .stringifyValue(this as NumGreaterThan);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumGreaterThanMapper.ensureInitialized()
                .isValueEqual(this as NumGreaterThan, other));
  }

  @override
  int get hashCode {
    return NumGreaterThanMapper.ensureInitialized()
        .hashValue(this as NumGreaterThan);
  }
}

extension NumGreaterThanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumGreaterThan, $Out> {
  NumGreaterThanCopyWith<$R, NumGreaterThan, $Out> get $asNumGreaterThan =>
      $base.as((v, t, t2) => _NumGreaterThanCopyWithImpl(v, t, t2));
}

abstract class NumGreaterThanCopyWith<$R, $In extends NumGreaterThan, $Out>
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
  NumGreaterThanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumGreaterThanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumGreaterThan, $Out>
    implements NumGreaterThanCopyWith<$R, NumGreaterThan, $Out> {
  _NumGreaterThanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumGreaterThan> $mapper =
      NumGreaterThanMapper.ensureInitialized();
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
  NumGreaterThan $make(CopyWithData data) => NumGreaterThan(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumGreaterThanCopyWith<$R2, NumGreaterThan, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumGreaterThanCopyWithImpl($value, $cast, t);
}
