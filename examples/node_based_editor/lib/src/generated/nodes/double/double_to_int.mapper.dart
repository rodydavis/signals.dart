// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_to_int.dart';

class DoubleToIntMapper extends SubClassMapperBase<DoubleToInt> {
  DoubleToIntMapper._();

  static DoubleToIntMapper? _instance;
  static DoubleToIntMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleToIntMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleToInt';

  static int _$id(DoubleToInt v) => v.id;
  static const Field<DoubleToInt, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleToInt v) => v.inputs;
  static const Field<DoubleToInt, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleToInt v) => v.offset;
  static const Field<DoubleToInt, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleToInt v) => v.label;
  static const Field<DoubleToInt, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleToInt v) => v.expanded;
  static const Field<DoubleToInt, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleToInt v) => v.getNode;
  static const Field<DoubleToInt, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleToInt> fields = const {
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
  final dynamic discriminatorValue = 'double_to_int';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleToInt _instantiate(DecodingData data) {
    return DoubleToInt(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleToInt fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleToInt>(map);
  }

  static DoubleToInt fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleToInt>(json);
  }
}

mixin DoubleToIntMappable {
  String toJson() {
    return DoubleToIntMapper.ensureInitialized()
        .encodeJson<DoubleToInt>(this as DoubleToInt);
  }

  Map<String, dynamic> toMap() {
    return DoubleToIntMapper.ensureInitialized()
        .encodeMap<DoubleToInt>(this as DoubleToInt);
  }

  DoubleToIntCopyWith<DoubleToInt, DoubleToInt, DoubleToInt> get copyWith =>
      _DoubleToIntCopyWithImpl(this as DoubleToInt, $identity, $identity);
  @override
  String toString() {
    return DoubleToIntMapper.ensureInitialized()
        .stringifyValue(this as DoubleToInt);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleToIntMapper.ensureInitialized()
                .isValueEqual(this as DoubleToInt, other));
  }

  @override
  int get hashCode {
    return DoubleToIntMapper.ensureInitialized().hashValue(this as DoubleToInt);
  }
}

extension DoubleToIntValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleToInt, $Out> {
  DoubleToIntCopyWith<$R, DoubleToInt, $Out> get $asDoubleToInt =>
      $base.as((v, t, t2) => _DoubleToIntCopyWithImpl(v, t, t2));
}

abstract class DoubleToIntCopyWith<$R, $In extends DoubleToInt, $Out>
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
  DoubleToIntCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleToIntCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleToInt, $Out>
    implements DoubleToIntCopyWith<$R, DoubleToInt, $Out> {
  _DoubleToIntCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleToInt> $mapper =
      DoubleToIntMapper.ensureInitialized();
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
  DoubleToInt $make(CopyWithData data) => DoubleToInt(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleToIntCopyWith<$R2, DoubleToInt, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleToIntCopyWithImpl($value, $cast, t);
}
