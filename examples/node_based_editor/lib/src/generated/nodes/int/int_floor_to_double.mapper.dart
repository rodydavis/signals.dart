// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_floor_to_double.dart';

class IntFloorToDoubleMapper extends SubClassMapperBase<IntFloorToDouble> {
  IntFloorToDoubleMapper._();

  static IntFloorToDoubleMapper? _instance;
  static IntFloorToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntFloorToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntFloorToDouble';

  static int _$id(IntFloorToDouble v) => v.id;
  static const Field<IntFloorToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntFloorToDouble v) =>
      v.inputs;
  static const Field<IntFloorToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntFloorToDouble v) => v.offset;
  static const Field<IntFloorToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntFloorToDouble v) => v.label;
  static const Field<IntFloorToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntFloorToDouble v) => v.expanded;
  static const Field<IntFloorToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntFloorToDouble v) => v.getNode;
  static const Field<IntFloorToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntFloorToDouble> fields = const {
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
  final dynamic discriminatorValue = 'int_floor_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntFloorToDouble _instantiate(DecodingData data) {
    return IntFloorToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntFloorToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntFloorToDouble>(map);
  }

  static IntFloorToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<IntFloorToDouble>(json);
  }
}

mixin IntFloorToDoubleMappable {
  String toJson() {
    return IntFloorToDoubleMapper.ensureInitialized()
        .encodeJson<IntFloorToDouble>(this as IntFloorToDouble);
  }

  Map<String, dynamic> toMap() {
    return IntFloorToDoubleMapper.ensureInitialized()
        .encodeMap<IntFloorToDouble>(this as IntFloorToDouble);
  }

  IntFloorToDoubleCopyWith<IntFloorToDouble, IntFloorToDouble, IntFloorToDouble>
      get copyWith => _IntFloorToDoubleCopyWithImpl(
          this as IntFloorToDouble, $identity, $identity);
  @override
  String toString() {
    return IntFloorToDoubleMapper.ensureInitialized()
        .stringifyValue(this as IntFloorToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntFloorToDoubleMapper.ensureInitialized()
                .isValueEqual(this as IntFloorToDouble, other));
  }

  @override
  int get hashCode {
    return IntFloorToDoubleMapper.ensureInitialized()
        .hashValue(this as IntFloorToDouble);
  }
}

extension IntFloorToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntFloorToDouble, $Out> {
  IntFloorToDoubleCopyWith<$R, IntFloorToDouble, $Out>
      get $asIntFloorToDouble =>
          $base.as((v, t, t2) => _IntFloorToDoubleCopyWithImpl(v, t, t2));
}

abstract class IntFloorToDoubleCopyWith<$R, $In extends IntFloorToDouble, $Out>
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
  IntFloorToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _IntFloorToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntFloorToDouble, $Out>
    implements IntFloorToDoubleCopyWith<$R, IntFloorToDouble, $Out> {
  _IntFloorToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntFloorToDouble> $mapper =
      IntFloorToDoubleMapper.ensureInitialized();
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
  IntFloorToDouble $make(CopyWithData data) => IntFloorToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntFloorToDoubleCopyWith<$R2, IntFloorToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntFloorToDoubleCopyWithImpl($value, $cast, t);
}
