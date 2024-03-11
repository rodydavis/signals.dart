// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'int_clamp.dart';

class IntClampMapper extends SubClassMapperBase<IntClamp> {
  IntClampMapper._();

  static IntClampMapper? _instance;
  static IntClampMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IntClampMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'IntClamp';

  static int _$id(IntClamp v) => v.id;
  static const Field<IntClamp, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(IntClamp v) => v.inputs;
  static const Field<IntClamp, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(IntClamp v) => v.offset;
  static const Field<IntClamp, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(IntClamp v) => v.label;
  static const Field<IntClamp, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(IntClamp v) => v.expanded;
  static const Field<IntClamp, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(IntClamp v) => v.getNode;
  static const Field<IntClamp, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<IntClamp> fields = const {
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
  final dynamic discriminatorValue = 'int_clamp';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static IntClamp _instantiate(DecodingData data) {
    return IntClamp(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static IntClamp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IntClamp>(map);
  }

  static IntClamp fromJson(String json) {
    return ensureInitialized().decodeJson<IntClamp>(json);
  }
}

mixin IntClampMappable {
  String toJson() {
    return IntClampMapper.ensureInitialized()
        .encodeJson<IntClamp>(this as IntClamp);
  }

  Map<String, dynamic> toMap() {
    return IntClampMapper.ensureInitialized()
        .encodeMap<IntClamp>(this as IntClamp);
  }

  IntClampCopyWith<IntClamp, IntClamp, IntClamp> get copyWith =>
      _IntClampCopyWithImpl(this as IntClamp, $identity, $identity);
  @override
  String toString() {
    return IntClampMapper.ensureInitialized().stringifyValue(this as IntClamp);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            IntClampMapper.ensureInitialized()
                .isValueEqual(this as IntClamp, other));
  }

  @override
  int get hashCode {
    return IntClampMapper.ensureInitialized().hashValue(this as IntClamp);
  }
}

extension IntClampValueCopy<$R, $Out> on ObjectCopyWith<$R, IntClamp, $Out> {
  IntClampCopyWith<$R, IntClamp, $Out> get $asIntClamp =>
      $base.as((v, t, t2) => _IntClampCopyWithImpl(v, t, t2));
}

abstract class IntClampCopyWith<$R, $In extends IntClamp, $Out>
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
  IntClampCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IntClampCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IntClamp, $Out>
    implements IntClampCopyWith<$R, IntClamp, $Out> {
  _IntClampCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IntClamp> $mapper =
      IntClampMapper.ensureInitialized();
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
  IntClamp $make(CopyWithData data) => IntClamp(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  IntClampCopyWith<$R2, IntClamp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IntClampCopyWithImpl($value, $cast, t);
}
