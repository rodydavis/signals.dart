// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_multiply.dart';

class DoubleMultiplyMapper extends SubClassMapperBase<DoubleMultiply> {
  DoubleMultiplyMapper._();

  static DoubleMultiplyMapper? _instance;
  static DoubleMultiplyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleMultiplyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleMultiply';

  static int _$id(DoubleMultiply v) => v.id;
  static const Field<DoubleMultiply, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleMultiply v) => v.inputs;
  static const Field<DoubleMultiply, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleMultiply v) => v.offset;
  static const Field<DoubleMultiply, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleMultiply v) => v.label;
  static const Field<DoubleMultiply, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleMultiply v) => v.expanded;
  static const Field<DoubleMultiply, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleMultiply v) => v.getNode;
  static const Field<DoubleMultiply, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleMultiply> fields = const {
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
  final dynamic discriminatorValue = 'double_multiply';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleMultiply _instantiate(DecodingData data) {
    return DoubleMultiply(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleMultiply fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleMultiply>(map);
  }

  static DoubleMultiply fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleMultiply>(json);
  }
}

mixin DoubleMultiplyMappable {
  String toJson() {
    return DoubleMultiplyMapper.ensureInitialized()
        .encodeJson<DoubleMultiply>(this as DoubleMultiply);
  }

  Map<String, dynamic> toMap() {
    return DoubleMultiplyMapper.ensureInitialized()
        .encodeMap<DoubleMultiply>(this as DoubleMultiply);
  }

  DoubleMultiplyCopyWith<DoubleMultiply, DoubleMultiply, DoubleMultiply>
      get copyWith => _DoubleMultiplyCopyWithImpl(
          this as DoubleMultiply, $identity, $identity);
  @override
  String toString() {
    return DoubleMultiplyMapper.ensureInitialized()
        .stringifyValue(this as DoubleMultiply);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleMultiplyMapper.ensureInitialized()
                .isValueEqual(this as DoubleMultiply, other));
  }

  @override
  int get hashCode {
    return DoubleMultiplyMapper.ensureInitialized()
        .hashValue(this as DoubleMultiply);
  }
}

extension DoubleMultiplyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleMultiply, $Out> {
  DoubleMultiplyCopyWith<$R, DoubleMultiply, $Out> get $asDoubleMultiply =>
      $base.as((v, t, t2) => _DoubleMultiplyCopyWithImpl(v, t, t2));
}

abstract class DoubleMultiplyCopyWith<$R, $In extends DoubleMultiply, $Out>
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
  DoubleMultiplyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleMultiplyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleMultiply, $Out>
    implements DoubleMultiplyCopyWith<$R, DoubleMultiply, $Out> {
  _DoubleMultiplyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleMultiply> $mapper =
      DoubleMultiplyMapper.ensureInitialized();
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
  DoubleMultiply $make(CopyWithData data) => DoubleMultiply(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleMultiplyCopyWith<$R2, DoubleMultiply, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleMultiplyCopyWithImpl($value, $cast, t);
}
