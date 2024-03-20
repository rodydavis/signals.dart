// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_to_unsigned.dart';

class IntToUnsignedMapper extends SubClassMapperBase<IntToUnsigned> {
  IntToUnsignedMapper._();

  static IntToUnsignedMapper? _instance;
  static IntToUnsignedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntToUnsignedMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntToUnsigned';

  static int _$id(IntToUnsigned v) => v.id;
  static const Field<IntToUnsigned, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntToUnsigned v) => v.inputs;
  static const Field<IntToUnsigned, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntToUnsigned v) => v.offset;
  static const Field<IntToUnsigned, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntToUnsigned v) => v.label;
  static const Field<IntToUnsigned, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntToUnsigned v) => v.expanded;
  static const Field<IntToUnsigned, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntToUnsigned v) => v.getNode;
  static const Field<IntToUnsigned, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntToUnsigned> fields = const {
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
  final dynamic discriminatorValue = 'int_to_unsigned';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntToUnsigned _instantiate(DecodingData data) {
    return IntToUnsigned(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntToUnsigned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntToUnsigned>(map);
  }

  static IntToUnsigned fromJson(String json) {
    return ensureInitialized().decodeJson<IntToUnsigned>(json);
  }
}

mixin IntToUnsignedMappable {
  String toJson() {
    return IntToUnsignedMapper.ensureInitialized()
        .encodeJson<IntToUnsigned>(this as IntToUnsigned);
  }

  Map<String, dynamic> toMap() {
    return IntToUnsignedMapper.ensureInitialized()
        .encodeMap<IntToUnsigned>(this as IntToUnsigned);
  }

  IntToUnsignedCopyWith<IntToUnsigned, IntToUnsigned, IntToUnsigned>
      get copyWith => _IntToUnsignedCopyWithImpl(
          this as IntToUnsigned, $identity, $identity);
  @override
  String toString() {
    return IntToUnsignedMapper.ensureInitialized()
        .stringifyValue(this as IntToUnsigned);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntToUnsignedMapper.ensureInitialized()
                .isValueEqual(this as IntToUnsigned, other));
  }

  @override
  int get hashCode {
    return IntToUnsignedMapper.ensureInitialized()
        .hashValue(this as IntToUnsigned);
  }
}

extension IntToUnsignedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IntToUnsigned, $Out> {
  IntToUnsignedCopyWith<$R, IntToUnsigned, $Out> get $asIntToUnsigned =>
      $base.as((v, t, t2) => _IntToUnsignedCopyWithImpl(v, t, t2));
}

abstract class IntToUnsignedCopyWith<$R, $In extends IntToUnsigned, $Out>
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
  IntToUnsignedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntToUnsignedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntToUnsigned, $Out>
    implements IntToUnsignedCopyWith<$R, IntToUnsigned, $Out> {
  _IntToUnsignedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntToUnsigned> $mapper =
      IntToUnsignedMapper.ensureInitialized();
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
  IntToUnsigned $make(CopyWithData data) => IntToUnsigned(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntToUnsignedCopyWith<$R2, IntToUnsigned, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntToUnsignedCopyWithImpl($value, $cast, t);
}
