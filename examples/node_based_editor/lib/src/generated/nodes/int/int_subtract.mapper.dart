// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_subtract.dart';

class IntSubtractMapper extends SubClassMapperBase<IntSubtract> {
  IntSubtractMapper._();

  static IntSubtractMapper? _instance;
  static IntSubtractMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntSubtractMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntSubtract';

  static int _$id(IntSubtract v) => v.id;
  static const Field<IntSubtract, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntSubtract v) => v.inputs;
  static const Field<IntSubtract, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntSubtract v) => v.offset;
  static const Field<IntSubtract, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntSubtract v) => v.label;
  static const Field<IntSubtract, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntSubtract v) => v.expanded;
  static const Field<IntSubtract, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntSubtract v) => v.getNode;
  static const Field<IntSubtract, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntSubtract> fields = const {
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
  final dynamic discriminatorValue = 'int_subtract';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntSubtract _instantiate(DecodingData data) {
    return IntSubtract(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntSubtract fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntSubtract>(map);
  }

  static IntSubtract fromJson(String json) {
    return ensureInitialized().decodeJson<IntSubtract>(json);
  }
}

mixin IntSubtractMappable {
  String toJson() {
    return IntSubtractMapper.ensureInitialized()
        .encodeJson<IntSubtract>(this as IntSubtract);
  }

  Map<String, dynamic> toMap() {
    return IntSubtractMapper.ensureInitialized()
        .encodeMap<IntSubtract>(this as IntSubtract);
  }

  IntSubtractCopyWith<IntSubtract, IntSubtract, IntSubtract> get copyWith =>
      _IntSubtractCopyWithImpl(this as IntSubtract, $identity, $identity);
  @override
  String toString() {
    return IntSubtractMapper.ensureInitialized()
        .stringifyValue(this as IntSubtract);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntSubtractMapper.ensureInitialized()
                .isValueEqual(this as IntSubtract, other));
  }

  @override
  int get hashCode {
    return IntSubtractMapper.ensureInitialized().hashValue(this as IntSubtract);
  }
}

extension IntSubtractValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntSubtract, $Out> {
  IntSubtractCopyWith<$R, IntSubtract, $Out> get $asIntSubtract =>
      $base.as((v, t, t2) => _IntSubtractCopyWithImpl(v, t, t2));
}

abstract class IntSubtractCopyWith<$R, $In extends IntSubtract, $Out>
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
  IntSubtractCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntSubtractCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntSubtract, $Out>
    implements IntSubtractCopyWith<$R, IntSubtract, $Out> {
  _IntSubtractCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntSubtract> $mapper =
      IntSubtractMapper.ensureInitialized();
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
  IntSubtract $make(CopyWithData data) => IntSubtract(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntSubtractCopyWith<$R2, IntSubtract, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntSubtractCopyWithImpl($value, $cast, t);
}
