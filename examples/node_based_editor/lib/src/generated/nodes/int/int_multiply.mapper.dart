// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_multiply.dart';

class IntMultiplyMapper extends SubClassMapperBase<IntMultiply> {
  IntMultiplyMapper._();

  static IntMultiplyMapper? _instance;
  static IntMultiplyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntMultiplyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntMultiply';

  static int _$id(IntMultiply v) => v.id;
  static const Field<IntMultiply, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntMultiply v) => v.inputs;
  static const Field<IntMultiply, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntMultiply v) => v.offset;
  static const Field<IntMultiply, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntMultiply v) => v.label;
  static const Field<IntMultiply, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntMultiply v) => v.expanded;
  static const Field<IntMultiply, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntMultiply v) => v.getNode;
  static const Field<IntMultiply, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntMultiply> fields = const {
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
  final dynamic discriminatorValue = 'int_multiply';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntMultiply _instantiate(DecodingData data) {
    return IntMultiply(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntMultiply fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntMultiply>(map);
  }

  static IntMultiply fromJson(String json) {
    return ensureInitialized().decodeJson<IntMultiply>(json);
  }
}

mixin IntMultiplyMappable {
  String toJson() {
    return IntMultiplyMapper.ensureInitialized()
        .encodeJson<IntMultiply>(this as IntMultiply);
  }

  Map<String, dynamic> toMap() {
    return IntMultiplyMapper.ensureInitialized()
        .encodeMap<IntMultiply>(this as IntMultiply);
  }

  IntMultiplyCopyWith<IntMultiply, IntMultiply, IntMultiply> get copyWith =>
      _IntMultiplyCopyWithImpl(this as IntMultiply, $identity, $identity);
  @override
  String toString() {
    return IntMultiplyMapper.ensureInitialized()
        .stringifyValue(this as IntMultiply);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntMultiplyMapper.ensureInitialized()
                .isValueEqual(this as IntMultiply, other));
  }

  @override
  int get hashCode {
    return IntMultiplyMapper.ensureInitialized().hashValue(this as IntMultiply);
  }
}

extension IntMultiplyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntMultiply, $Out> {
  IntMultiplyCopyWith<$R, IntMultiply, $Out> get $asIntMultiply =>
      $base.as((v, t, t2) => _IntMultiplyCopyWithImpl(v, t, t2));
}

abstract class IntMultiplyCopyWith<$R, $In extends IntMultiply, $Out>
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
  IntMultiplyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntMultiplyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntMultiply, $Out>
    implements IntMultiplyCopyWith<$R, IntMultiply, $Out> {
  _IntMultiplyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntMultiply> $mapper =
      IntMultiplyMapper.ensureInitialized();
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
  IntMultiply $make(CopyWithData data) => IntMultiply(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntMultiplyCopyWith<$R2, IntMultiply, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntMultiplyCopyWithImpl($value, $cast, t);
}
