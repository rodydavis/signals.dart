// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_floor_to_double.dart';

class DoubleFloorToDoubleMapper
    extends SubClassMapperBase<DoubleFloorToDouble> {
  DoubleFloorToDoubleMapper._();

  static DoubleFloorToDoubleMapper? _instance;
  static DoubleFloorToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleFloorToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleFloorToDouble';

  static int _$id(DoubleFloorToDouble v) => v.id;
  static const Field<DoubleFloorToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleFloorToDouble v) =>
      v.inputs;
  static const Field<DoubleFloorToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleFloorToDouble v) => v.offset;
  static const Field<DoubleFloorToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleFloorToDouble v) => v.label;
  static const Field<DoubleFloorToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleFloorToDouble v) => v.expanded;
  static const Field<DoubleFloorToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleFloorToDouble v) => v.getNode;
  static const Field<DoubleFloorToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleFloorToDouble> fields = const {
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
  final dynamic discriminatorValue = 'double_floor_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleFloorToDouble _instantiate(DecodingData data) {
    return DoubleFloorToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleFloorToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleFloorToDouble>(map);
  }

  static DoubleFloorToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleFloorToDouble>(json);
  }
}

mixin DoubleFloorToDoubleMappable {
  String toJson() {
    return DoubleFloorToDoubleMapper.ensureInitialized()
        .encodeJson<DoubleFloorToDouble>(this as DoubleFloorToDouble);
  }

  Map<String, dynamic> toMap() {
    return DoubleFloorToDoubleMapper.ensureInitialized()
        .encodeMap<DoubleFloorToDouble>(this as DoubleFloorToDouble);
  }

  DoubleFloorToDoubleCopyWith<DoubleFloorToDouble, DoubleFloorToDouble,
          DoubleFloorToDouble>
      get copyWith => _DoubleFloorToDoubleCopyWithImpl(
          this as DoubleFloorToDouble, $identity, $identity);
  @override
  String toString() {
    return DoubleFloorToDoubleMapper.ensureInitialized()
        .stringifyValue(this as DoubleFloorToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleFloorToDoubleMapper.ensureInitialized()
                .isValueEqual(this as DoubleFloorToDouble, other));
  }

  @override
  int get hashCode {
    return DoubleFloorToDoubleMapper.ensureInitialized()
        .hashValue(this as DoubleFloorToDouble);
  }
}

extension DoubleFloorToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleFloorToDouble, $Out> {
  DoubleFloorToDoubleCopyWith<$R, DoubleFloorToDouble, $Out>
      get $asDoubleFloorToDouble =>
          $base.as((v, t, t2) => _DoubleFloorToDoubleCopyWithImpl(v, t, t2));
}

abstract class DoubleFloorToDoubleCopyWith<$R, $In extends DoubleFloorToDouble,
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
  DoubleFloorToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DoubleFloorToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleFloorToDouble, $Out>
    implements DoubleFloorToDoubleCopyWith<$R, DoubleFloorToDouble, $Out> {
  _DoubleFloorToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleFloorToDouble> $mapper =
      DoubleFloorToDoubleMapper.ensureInitialized();
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
  DoubleFloorToDouble $make(CopyWithData data) => DoubleFloorToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleFloorToDoubleCopyWith<$R2, DoubleFloorToDouble, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DoubleFloorToDoubleCopyWithImpl($value, $cast, t);
}
